/* agent.e [17/11/2002][Ant] */

FALSE = 0;
TRUE = 1;
aop_debug = FALSE;

func aop_agent {
  para instr, rulename, param;
  auto ruledef, paracount, op_name, op_value, child_rules, ignore, script, fail_rule;
  auto i, result, token_matched, child_substrs, child_params, children, instr_var, old_script, later;

  /* load data for rule into local variable */
  ruledef = getvar(rulename);
  
  /* check it is a valid ruledef template */
  if (! isdefined(ruledef))
    return "undefined";
  if (type(ruledef) != "list" || ruledef# < 2)
    return "badagent";

  /* get the operation name and value, i.e. pivot and "=" */
  paracount = 1;
  op_name = ruledef[paracount++];
  op_value = ruledef[paracount++];
  
  /* get the agents to create on success */
  switch (aop_has_children(op_name)) {
    case 0:
      if (ruledef# >= paracount && ruledef[paracount] == [])
        paracount++;
      child_rules = [];
      break;
    default:
      if (type(ruledef[paracount]) == "string")
        child_rules = [ruledef[paracount++]];
      else if (type(ruledef[paracount]) == "list")
        child_rules = ruledef[paracount++];
      else
        child_rules = [];
      if (child_rules == [])
        return "badagent";
      break;
  }

  /* set default values */
  ignore = [];
  script = [];
  old_script = FALSE;
  fail_rule = "";

  /* get the optional arguments */
  while (paracount <= ruledef#) {
    
    /* check this is a valid argument */
    if (type(ruledef[paracount]) != "list" || ruledef[paracount]# < 2) {
      aop_error(AOP_WARNING, "rule has unreadable items: \""//rulename//"\"");
      paracount++;
      continue;
    }

    switch (ruledef[paracount][1]) {
      case "ignore":
        /* blocks to ignore */
        ignore = ruledef[paracount][2];
        break;

      case "fail":
        /* child to create on failure */
        fail_rule = ruledef[paracount][2];
        break;

      case "script":
        /* old style script to run */
        old_script = TRUE;
        if (script != [])
          return "badagent";
        for (i = 2; i <= ruledef[paracount]#; i++)
          script = script // [ruledef[paracount][i]];
        break;
        
      case "action":
        /* script actions */
        old_script = FALSE;
        if (script != [])
          return "badagent";
        for (i = 2; i <= ruledef[paracount]#; i++)
          script = script // [ruledef[paracount][i]];
        break;

      default:
        /* unrecognised argument */
        return "badagent";
    }

    paracount++;
  }

  /* strip whitespace from beginning and end of string */
  instr = stripspace(instr);

  /* perform operation */
  result = aop_operation(instr, op_name, op_value, ignore);

  /* badly formed operation */
  if (result == "badop")
    return "badagent";

  /* operation did not return a match */
  if (result == FAIL) {
    if (fail_rule == "")
      /* if no fail template then parsing has failed */
      return "fail";
    else
      /* else pass string, and all variables to next ruledef */
      return [[[instr, fail_rule, param]],[]];
  }

  /* simplify result to token and child strings */
  token_matched = result[1];
  child_substrs = result[2];

  /* execute script */
  if (old_script) {
    /* using old style scripts - set globals */
    v_string = instr;
    v_match = token_matched;
    if (op_name == "read_all")
      v_substrs = [token_matched];
    else
      v_substrs = child_substrs;
    v_paras = param;
    
    result = aop_script_old(script, child_substrs#);
  }
  else {
    /* using new style scripts */
    instr_var = makevarname();
    execute(instr_var // "=\"" // escapequotes(instr) // "\";");
    result = aop_action(script, instr, token_matched, child_substrs, param, instr_var);
  }
  
  child_params = result[1];
  later = result[2];

  /* useful debug information */
  if (aop_debug == 1) {
    writeln("\n***");
    writeln("OPERATION: ",op_name,", ",op_value,", ",instr,";");
    writeln("RESULT: ",token_matched,", ",child_substrs,";");
    writeln("SCRIPT: ", script, ";");
    writeln("RESULT: ",child_params,";\n");
  }

  /* create child list with inputs, rules and parameters */
  children = [];
  for (i = 1; i <= child_substrs#; i++) {
    children = children // [ [ child_substrs[i],
                               child_rules[((i-1)%child_rules#)+1],
                               child_params[i] ] ];
  }
  
  aop_agent_end(rulename, op_name, op_value, param, instr, instr_var, token_matched, child_substrs, child_rules, child_params, script);

  return [children, later];
}

func aop_script_old {
  para script, children;
  auto i, j, k, instruction, return_params, all_vars, var_tmp, str_tmp, exec_args, later;

  later = [];
  return_params = [];

  while (return_params# < children)
    append return_params, [];

  for (i = 1; i <= script#; i++) {
    
    /* each script instruction */
    instruction = script[i];

    switch (instruction[1]) {

    case "declare":
      /* for each script variable, a local EDEN string variable is
         created to hold the name of a persistent, uniquely named
         EDEN variable */
      for (j = 2; j <= instruction#; j++)
        execute (instruction[j] // " = \"" // makevarname() // "\";");
      break;

    case "setparas":
      for (j = 2; j <= instruction#; j++) {
        /* add the EDEN variable names of the script variables indicated to
           the list of each childs parameters */
        for (k = 1; k <= instruction[j]#; k++)
          return_params[j-1] = return_params[j-1] // [getvar(instruction[j][k])];
      }
      break;

    case "allparas":
      if (children < 1)
        break;

      /* all_vars holds the name of the list of all variables */
      all_vars = makevarname();

      /* create a script variable with the given name to the list of all variables */
      execute(instruction[2] // " = \"" // all_vars // "\";");

      /* start to build up the list of variables */
      var_tmp = makevarname();
      str_tmp = all_vars // " is [" // var_tmp;

      return_params[1] = return_params[1] // [var_tmp];

      /* for each child */
      for (j = 2; j <= children; j++) {
        /* make a new EDEN variable and add it to the list of variables*/
        var_tmp = makevarname();
        str_tmp = str_tmp // ", " // var_tmp;

        /* add the new variable to the childs parameter list */
        return_params[j] = return_params[j] // [var_tmp];
      }

      /* create the list of variables */      
      str_tmp = str_tmp // "];";
      execute(str_tmp);
      break;

    case "execute":
      /* extract the variable names */
      exec_args = [];
      for (j = 3; j <= instruction#; j++)
        exec_args = exec_args // [instruction[j]];

      /* format once to substitute for %%s */
      str_tmp = format(instruction[2], exec_args);

      /* format again to substitute for $$s */
      str_tmp = format(str_tmp[1], str_tmp[2]);

      /* execute command */
      execute(str_tmp[1]);
      break;

    case "later":
      /* extract the variable names */
      exec_args = [];
      for (j = 3; j <= instruction#; j++)
        exec_args = exec_args // [instruction[j]];

      /* format once to substitute for "%%"s but do not substitute
         for "$$"s until later, when the variables will have been defined*/

      str_tmp = format(instruction[2], exec_args);

      /* save command to be executed later */
      later = later // [str_tmp];
      break;

    default:
    }
  }

  return [return_params, later];
}

func aop_has_children {
  para op_name;
  switch (op_name) {
    case "literal":
    case "read_all":
    case "literal_re":
      return 0;
    case "pivot":
    case "rev_pivot":
      return 2;
    default:
      return 1;
  }
}

proc aop_agent_end {
  para rulename, op_name, op_value, param, instr, instr_var, token_matched, child_substrs, child_rules, child_params, script;
  return;
}
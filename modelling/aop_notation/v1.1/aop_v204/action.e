/* action.e [18/11/2002][Ant] */

func aop_action {
  para script, instr, token_matched, child_substrs, passed_var, instr_var;
  auto i, child_params, formatted_str, script_later;
  
  script_later = [];
  
  ##check that script is a list
  if (type(script) != "list")
    return ERROR;
  
  ##create child variables/parameters
  child_params = [];
  for (i = 1; i <= child_substrs#; i++)
    append child_params, makevarname();
  
  ##process script
  for (i = 1; i <= script#; i++) {
    
    ##check that script[i] is a tuple
    if (!(type(script[i]) == "list" && script[i]# >= 2))
      return ERROR;
    
    ##format the script action string
    formatted_str = aop_action_format(script[i][2], instr, token_matched,
      child_substrs, passed_var, instr_var, child_params);
    
    switch (script[i][1]) {
      case "now":
        aop_action_execute(formatted_str);
        break;
      case "later":
        ##store script action in a list to be processed later
        append script_later, formatted_str;
        break;
    }
  }
  return [child_params, script_later];
}

/* function: aop_action_format
 * params: script_str = string to format,
 *         i = agent input string,
 *         t = token matched,
 *         s = list of child substrs,
 *         v = name of variable passed to agent,
 *         j = name of variable containing input string
 *         p = list of child parameters to be passed
 * returns: formatted string
 */
func aop_action_format {
  para script_str, i, t, s, v, j, p;
  auto formatted_str, x, y;
  
  formatted_str = "";
  
  ##loop through characters
  for (x = 1; x <= script_str#; x++) {
    
    if (script_str[x] == '$' && x < script_str#) {
      x++;
      switch (script_str[x]) {
        case 'i':
          formatted_str = formatted_str // i;
          break;
        case 't':
          formatted_str = formatted_str // t;
          break;
        case 'v':
          formatted_str = formatted_str // v;
          break;
        case 'j':
          formatted_str = formatted_str // j;
          break;
        case 's':
          if (x < script_str# && isdigit(script_str[++x])) {
            y = int(script_str[x])-48;
            if (y > 0 && y <= s#)
              formatted_str = formatted_str // s[y];
            else
              aop_error(AOP_WARNING, "script variable does not exist: $s" // script_str[x]);
          }
          else
            aop_error(AOP_WARNING, "expected digit after $s");
          break;
        case 'p':
          if (x < script_str# && isdigit(script_str[++x])) {
            y = int(script_str[x])-48;
            if (y > 0 && y <= p#)
              formatted_str = formatted_str // p[y];
            else
              aop_error(AOP_WARNING, "script variable does not exist: $p" // script_str[x]);
          }
          else
            aop_error(AOP_WARNING, "expected digit after $p");
          break;
        case '$':
          formatted_str = formatted_str // script_str[x];
          break;
        default:
          aop_error(AOP_WARNING, "script variable does not exist: $" // script_str[x]);
      }
    }
    else {
      formatted_str = formatted_str // script_str[x];
    }
  }
  return formatted_str;
}

/* function: aop_action_execute
 * params: string to execute
 * returns: nothing
 * notes: redefine this function to do clever things like
 *   delaying executing the string until later
 */
func aop_action_execute {
  para script_str;
  execute(script_str);
}
/* parse.e [18/11/2002][Ant] */

new_parser = TRUE;

dfparse is new_parser ? aop_parse : quiet_dfparse;

proc aop_parse {
  para instr, start_agent;
  auto agent_queue, script_later, agent, result, i, tmp_str;

  /* initialise the commands that the agents may ask us to run later*/
  script_later = [];

  /* initialise the list of agents to be run to the first */
  agent_queue = [[instr, start_agent, makevarname()]];

  /* get the next agent */
  while ((agent = removehead(&agent_queue)) != []) {
    
    /* run it */
    result = aop_agent(agent[1], agent[2], agent[3]);

    /* make sure it ran ok */
    if (result == "badagent") {
      aop_error(AOP_ERROR, "agent is badly defined: \"" // agent[2] // "\"");
      return;
    }
    else if (result == "undefined") {
      aop_error(AOP_ERROR, "agent is undefined: \"" // agent[2] // "\"");
      return;
    }
    else if (result == "fail") {
      aop_error(AOP_ERROR, "parse failure");
      return;
    }
    else {
      /* add the child agents to the beginning of the queue */
      agent_queue = result[1] // agent_queue;
      /* append the script actions to be run after the child agents */
      script_later = result[2] // script_later;
    }
  }

  /* execute the later list */
  for (i = 1; i <= script_later#; i++) {
    if (type(script_later[i]) == "string") {
      ##new style script
      aop_action_execute(script_later[i]);
    }
    else {
      ##old style script
      tmp_str = format(script_later[i][1], script_later[i][2]);
      execute(tmp_str[1]);
    }
  }
}

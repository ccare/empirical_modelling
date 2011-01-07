%eden
installeddi();

%eden
proc garbage_collect {
	/* the revised eddi garbage collection procedure */
        auto ix, j, dCAT;
        for (ix=2; ix<=CATALOGUE#; ix++) {
                dCAT = dependants(CATALOGUE[ix][1]);
                /* writeln("ix = ", ix); writeln(dCAT); writeln((dCAT[2])#); */
                for (j=1; j<=dCAT[2]#; j++) {
                        /* writeln(dependants(dCAT[2][j])); */
                        if ((dependants(dCAT[2][j])[1])==[]) {
                                /* writeln(dCAT[2][j]); */
                        	if(substr(dCAT[2][j],1,4)=="var_") self_asgn(dCAT[2][j]);
                        }
                }
        }
}


%eddi

AN_tables_InitialConditions (variable CHAR,value CHAR);
AN_tables_Integrators (variable CHAR,integrate CHAR);

%eden
proc AN_addIntegrator {
    para var,accum,ic;
    
    AN_tmp_variable="\"" // str(var) // "\"";
    AN_tmp_integrate="\"" // str(accum) // "\"";
    AN_tmp_ic="\"" // str(ic) // "\"";    
    
    execute("%eddi
    AN_tables_icDups is AN_tables_InitialConditions : variable == " // AN_tmp_variable // ";
    AN_tables_acDups is AN_tables_Integrators : variable == " // AN_tmp_variable // ";
     ");   
    
    if (AN_isEmpty(tail(AN_tables_icDups)) == 0) {
        execute("%eddi
	AN_tables_tmpic = AN_tables_InitialConditions-AN_tables_icDups;
	~~AN_tables_icDups;
	~~AN_tables_InitialConditions;
	AN_tables_InitialConditions = AN_tables_tmpic;
	~~AN_tables_tmpic;
        ");  
    }
    else {
        execute("%eddi
	~~AN_tables_icDups;
        "); 
    }
    
    if (AN_isEmpty(tail(AN_tables_acDups)) == 0) {
        execute("%eddi
	AN_tables_tmpac = AN_tables_Integrators-AN_tables_acDups;
	~~AN_tables_acDups;
	~~AN_tables_Integrators;
	AN_tables_Integrators = AN_tables_tmpac;
	~~AN_tables_tmpac;
        ");  
    }
    else {
        execute("%eddi
	~~AN_tables_acDups;
        "); 
    }
    
    execute("%eddi
    AN_tables_InitialConditions << [" // AN_tmp_variable // "," // AN_tmp_ic // "];
    AN_tables_Integrators << [" // AN_tmp_variable // "," // AN_tmp_integrate // "];
    ");
    
}


%eden
func AN_isEmpty {
    para list;
    if (list# > 0) {return 0;} else {return 1;}
}









%eden
proc AN_clock {
    if (AN_clockGoing == 1) {
       AN_time++;
       todo("AN_clock();");
    }
}


proc AN_startClock : AN_clockGoing {
    if (AN_clockGoing == 1) {
        AN_time=0;
        todo("AN_clock();");
    }
}



AN_initialConditions is tail(AN_tables_InitialConditions);
AN_integrators is tail(AN_tables_Integrators);

proc AN_setInitialConditions {
   for (AN_i=1; AN_i <= AN_initialConditions# ; AN_i++)
   {
   execute(AN_initialConditions[AN_i][1] // " = " // AN_initialConditions[AN_i][2] // ";");
   }
}

proc AN_integrate : AN_time {
   for (AN_i=1; AN_i <= AN_integrators# ; AN_i++)
   {
   execute(AN_integrators[AN_i][1] // " = " 
           // AN_integrators[AN_i][1] // " + " // AN_integrators[AN_i][2] // ";");
   }
}

func AN_filter {
    if ($1 > 1) {AN_overloaded();return 1;}
    else if ($1 < -1) {AN_overloaded();return -1;}
    else {return $1;}
}

proc AN_overloaded : AN_overload {
      writeln("WARNING: Analogue Computer in OVERLOAD");
}

func AN_scale {
   return AN_filter($1*$2);
}

func AN_summer {
   return -1.0*AN_filter($1+$2);
}

func AN_ampByTen {
   return 10*$1;
}

include("ANparse.e");

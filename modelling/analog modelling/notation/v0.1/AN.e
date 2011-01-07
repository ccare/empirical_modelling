
## Pre-amble to ensure that EDDI works
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


## EDDI tables to store information about integrators
%eddi
AN_tables_InitialConditions (variable CHAR,value CHAR);
AN_tables_Integrators (variable CHAR,integrate CHAR);


## Utility Proceedure to add an entry cleanly to the database
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

proc AN_dbCleanUp {
    para var;
        execute("%eddi
	AN_tables_tmp = AN_tables_InitialConditions : variable != \"AN_value_" // var // "\";
	~~AN_tables_InitialConditions;
	AN_tables_InitialConditions = AN_tables_tmp;
	~~AN_tables_tmp;
	AN_tables_tmp = AN_tables_Integrators : variable != \"AN_value_" // var // "\";
	~~AN_tables_Integrators;
	AN_tables_Integrators = AN_tables_tmp;
	~~AN_tables_tmp;
        "); 
}
## Utility function to determin whether a list is empty
%eden
func AN_isEmpty {
    para list;
    if (list# > 0) {return 0;} else {return 1;}
}


## Definitons for the analogue computer's clock
AN_time=0;
AN_repopPeriod=0;
%eden
proc AN_clock {
    if (AN_clockGoing == 1) {
       AN_time++;
       todo("AN_clock();");
    }
}
proc AN_repopClock {
    if (AN_clockGoing == 2) {
    	if (AN_time < AN_repopPeriod) {
       		AN_time++;
	} else {
		AN_time=0;
	}
       todo("AN_repopClock();");
    }
}
proc AN_startClock : AN_clockGoing {
    if (AN_clockGoing == 1) {
        todo("AN_clock();");
    }
    if (AN_clockGoing == 2) {
        todo("AN_repopClock();");
    }
}

## Procedures to perform integration (from info stored in eddi tables)

AN_initialConditions is tail(AN_tables_InitialConditions);
AN_integrators is tail(AN_tables_Integrators);

proc AN_setInitialConditions {
   for (AN_i=1; AN_i <= AN_initialConditions# ; AN_i++)
   {
   todo(AN_initialConditions[AN_i][1] // " is " // AN_initialConditions[AN_i][2] // ";");
   }
   setReference();
   AN_time=0;
}

proc AN_integrate : AN_time {
   for (AN_i=1; AN_i <= AN_integrators# ; AN_i++)
   {
   execute(AN_integrators[AN_i][1] // " = " 
           // AN_integrators[AN_i][1] // " + " // AN_integrators[AN_i][2] // ";");
   }
}

## function to protect against overload

func AN_filter {
    if ($1 > 1) {AN_overloaded($1);return 1;}
    else if ($1 < -1) {AN_overloaded($1);return -1;}
    else {return $1;}
}

proc AN_overloaded {
      writeln("WARNING: Analogue Computer in OVERLOAD with value " // str($1) // "MU");
}

## reference
proc setReference {
	AN_REFERENCE_ZERO=0;
	AN_REFERENCE_POSITIVE=1.0;
	AN_REFERENCE_NEGATIVE=-1.0;
}
include("ANparse.e");
include("modes.e");

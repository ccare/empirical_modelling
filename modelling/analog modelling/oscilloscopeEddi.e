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

%eden
installeddi();

%eddi
 OSC_TABLES_SAMPLE (time INT, sample1 REAL, sample2 REAL, sample3 REAL);


%eden
OSC_sampleWindow = 10000;
OSC_startTime is AN_time-OSC_sampleWindow;

%eden
proc OSC_cleanUpSamples  {
    execute("%eddi
    OSC_TABLES_TEMP = OSC_TABLES_SAMPLE : time >= " // str(OSC_startTime) // ";
    ~~OSC_TABLES_SAMPLES;
    OSC_TABLES_SAMPLE = OSC_TABLES_TEMP;
    ~~OSC_TABLES_TEMP;"
    );
}

%eden
sample1src is 0;
sample2src is 0;
sample3src is 0;

%eden
proc OSC_sample {
    execute("%eddi
    OSC_TABLES_SAMPLE << [" // str(AN_time) // "," 
    // str(sample1src) // ","
    // str(sample2src) // ","
    // str(sample3src) // "];"
    );
}





AN_time=0;

proc AN_clock {
    AN_time++;
    if (AN_clockGoing == 1) {
        todo("AN_clock();");
    }
}


AN_clockGoing=1;
AN_clock();

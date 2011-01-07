##==============================================================================
##           A Notation for Electronic Analog Computing (%analog)
##
## clock.e                                          Charlie Care - November 2004
##==============================================================================

##------------------------------------------------------------------------------
## Observables
##------------------------------------------------------------------------------

%eden
## The computer time (incremented by the clock)
AN_time=0;

## The period of time (computer time) that the computer runs
##  before reseting (rep-op mode only)
AN_repopPeriod=0;

## AN_clockGoing is an observable used to control the clocking
##     0 - stopped
##     1 - running (compute mode)
##     2 - running (rep-op mode)

##------------------------------------------------------------------------------
## Procedures
##------------------------------------------------------------------------------

%eden

## Normal (compute mode) clock. Runs when AN_clockGoing = 1
proc AN_clock {
    if (AN_clockGoing == 1) {
       AN_time++;
       todo("AN_clock();");
    }
}

## Rep-op clock: Continually resets after AN_repopPeriod time units.
proc AN_repopClock {
    if (AN_clockGoing == 2) {
    	if (AN_time < AN_repopPeriod) {
       		AN_time++;
	} else {
		AN_setInitialConditions();
		AN_time=0;
	}
       todo("AN_repopClock();");
    }
}

## Procedure to activate the clocks
proc AN_startClock : AN_clockGoing {
    if (AN_clockGoing == 1) {
        todo("AN_clock();");
    }
    if (AN_clockGoing == 2) {
        todo("AN_repopClock();");
    }
}

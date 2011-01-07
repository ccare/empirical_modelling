%scout
display oscilloscope;
integer OSC_width = 580;
integer OSC_height = 300;

%eden
/* open a new display  */

OpenDisplay("oscilloscope", OSC_width, OSC_height);
proc oscilloscope_display_screen : oscilloscope { DisplayScreen(&oscilloscope, "oscilloscope"); }

%scout

integer OSC_numSamples;

window OSC_screen = {
  type: DONALD
  box: [{10, 10}, {570, 290}]
  pict: "oscilloscope_view"
  border: 1
  xmin: 1
  xmax: OSC_numSamples
  ymin: -1
  ymax: 1
  bgcolour: "white"
};

oscilloscope = <OSC_screen>;

%donald
viewport oscilloscope_view

line OSC_xaxis

int OSC_numSamples

OSC_xaxis = [{0, 0}, {OSC_numSamples, 0}]
?A_OSC_xaxis="color=grey";



%eden
OSC_numSamples=100;
_OSC_numSamples is OSC_numSamples;

AN_time=0;
OSC_sample is (AN_time % OSC_numSamples)+1;

proc makeSamples : AN_time {
	if (OSC_sample1src != @) {
    	execute("%eden\nOSC_sample1[OSC_sample]=OSC_sample1src;");
	}
}


proc init : OSC_numSamples {
    for (i=1;i<=OSC_init_oldnumSamples;i++) {
       execute("%donald\nOSC_draw1_" // str(i) // "=[{0,0},{0,0}]");
    }    

    OSC_init_sample = "[0";
    for (i=2;i<=OSC_numSamples;i++) {
        OSC_init_sample = OSC_init_sample // ",0";
    }
    
    OSC_init_sample = OSC_init_sample // "]";
    
    execute(strcat("%eden\nOSC_sample1=",OSC_init_sample,";"));
    
    OSC_init_lines = "";
    for (i=1;i<=OSC_numSamples;i++) {
        OSC_init_lines = OSC_init_lines 
			// "%donald\nline OSC_draw1_" // str(i) // "\n"
			// "int OSC_draw1_" // str(i) // "_val\n"
			// "OSC_draw1_" // str(i) // " = [{" // str(i) // ", 0}, {" // str(i)
			// ", OSC_draw1_" // str(i) // "_val}]\n" 
			// "?_OSC_draw1_" // str(i) 
			// "_val is OSC_sample1[" // str(i) // "];\n";
    }
    execute(OSC_init_lines);

    OSC_init_oldnumSamples = OSC_numSamples;
}

## Add link dependeny here:

OSC_sample1src is b;
%scout
display oscilloscope;
integer OSC_width = 550;
integer OSC_height = 300;

%eden
/* open a new display  */

OpenDisplay("oscilloscope", OSC_width, OSC_height);
proc oscilloscope_display_screen : oscilloscope { DisplayScreen(&oscilloscope, "oscilloscope"); }

%scout
window OSC_screen = {
  type: DONALD
  box: [{10, 10}, {290, 290}]
  pict: "oscilloscope_view"
  border: 1
  xmin: -1
  xmax: 1
  ymin: -1
  ymax: 1
  bgcolour: "white"
};

oscilloscope = <OSC_screen>;

%donald
viewport oscilloscope_view

line OSC_xaxis, OSC_yaxis

real OSC_time
OSC_time=-1.0

OSC_xaxis = [{-1, 0}, {1, 0}]
OSC_yaxis = [{OSC_time, -1}, {OSC_time, 1}]
?A_OSC_xaxis="color=grey";
?A_OSC_yaxis="color=grey";

%eden
OSC_numSamples=100;

OSC_sample=1;

proc OSC_clock {
    OSC_sample++;
    if (OSC_sample > OSC_numSamples) { OSC_sample=1; }
    
    
        todo("OSC_clock();");
}

OSC_signal=0.5;


OSC_traceLine = "
%donald
line _OSC_trace1_?1
_OSC_trace1_?1 = [{?2, 0},{?2,?3}]
%eden
A_OSC_trace1_?1=\"colour=red\";
";


OSC_sampling=1;
OSC_clock();

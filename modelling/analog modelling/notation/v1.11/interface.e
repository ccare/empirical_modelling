DFheight = 721;
DFwidth = 1024;

%eden
include("Run.e");
%eden
%eden
include("oscilloscope.e");
%analog
%analog
open_display;
open_panel;
%scout
integer ANdisp_refPoint_x = 610;
integer ANdisp_refPoint_y = 10;
integer ANdisp_winHeight=700;
screen=oscilloscope&panel&observables;
%scout
integer AN_panel_refPoint_x = 10;
integer AN_panel_refPoint_y = 350;
%scout
window obsBack = {
  type: TEXT
  frame: ([{ANdisp_refPoint_x,ANdisp_refPoint_y},{ANdisp_refPoint_x+ANdisp_winWidth,ANdisp_refPoint_y+ANdisp_winHeight}])
  sensitive: OFF
  border: 1
  bdcolour: "black"
  relief: "raised"
};
window panelBack = {
  type: TEXT
  frame: ([{AN_panel_refPoint_x,AN_panel_refPoint_y},{AN_panel_refPoint_x+AN_panel_winWidth,AN_panel_refPoint_y+AN_panel_winHeight}])
  sensitive: OFF
  border: 1
  bdcolour: "black"
  relief: "raised"
};

integer input_x1,input_x2,input_y1,input_y2;
string inputString;
window input = {
  type: TEXTBOX
  frame: ([{input_x1,input_y1},{input_x2,input_y2}])
  sensitive: ON
  string: inputString
  border: 1
  font: "{courier 10 normal}"
  bgcolour: "white"
  bdcolour: "black"
  relief: "sunken"
};

%eden
inputString="";
input_x1=20;
input_y1=400;

input_x2=52;
input_y2=12;

%scout
screen=oscilloscope&panel&observables&<panelBack/obsBack/input>;
integer AN_panel_refPoint_x = 460;
integer AN_panel_refPoint_y = 400;

OSCx=10;
%eden



%scout
integer inputTitle_x1=20;
integer inputTitle_y1=400;
integer inputTitle_x2=420;
integer inputTitle_y2=inputTitle_y1+30;


window inputTitle = {
  type: TEXT
  alignment: CENTRE
  string: "%analog Definitions"
  font: "{helvetica 14 bold}"
  frame: ([{inputTitle_x1,inputTitle_y1},{inputTitle_x2,inputTitle_y2}])
  sensitive: OFF
  border: 0
  relief: "flat"
};


screen=oscilloscope&panel&observables&<panelBack/obsBack/input/inputTitle>;


input_x1=20;
input_y1=inputTitle_y2+10;

integer AN_panel_refPoint_x = 460;
integer AN_panel_refPoint_y = 480;

integer oscTitle_x1=20;
integer oscTitle_y1=20;
integer oscTitle_x2=OSC_width+oscTitle_x1;
integer oscTitle_y2=oscTitle_y1+30;

window oscTitle = {
  type: TEXT
  alignment: CENTRE
  string: "Trace (observable 'o')"
  font: "{helvetica 14 bold}"
  frame: ([{oscTitle_x1,oscTitle_y1},{oscTitle_x2,oscTitle_y2}])
  sensitive: OFF
  border: 0
  relief: "flat"
};

OSCy=oscTitle_y2;


screen=oscilloscope&panel&observables&<panelBack/obsBack/input/inputTitle/oscTitle>;


integer acceptButton_x1=30;
integer acceptButton_y1=680;
integer acceptButton_x2=100+acceptButton_x1;
integer acceptButton_y2=acceptButton_y1+20;
string acceptButton_relief="raised";

window acceptButton = {
  type: TEXT
  string: "Accept"
  alignment: CENTRE
  frame: ([{acceptButton_x1,acceptButton_y1},{acceptButton_x2,acceptButton_y2}])
  sensitive: ON
  border: 1
  relief: acceptButton_relief
  bgcolour: ANdisp_w_colour
  font: "{helvetica 12 bold}"
};

integer inputWindowButton_x1=30;
integer inputWindowButton_y1=680;
integer inputWindowButton_x2=110+inputWindowButton_x1;
integer inputWindowButton_y2=inputWindowButton_y1+20;
string inputWindowButton_relief="raised";
string inputWindowButton_string="Show tkeden";

window inputWindowButton = {
  type: TEXT
  string: inputWindowButton_string
  alignment: CENTRE
  frame: ([{inputWindowButton_x1,inputWindowButton_y1},{inputWindowButton_x2,inputWindowButton_y2}])
  sensitive: ON
  border: 1
  relief: inputWindowButton_relief
  bgcolour: ANdisp_w_colour
  font: "{helvetica 12 bold}"
};
%eden

inputWindowOpen=0;

proc clickInputButton : ~inputWindowButton_mouse_1 {
	if (~inputWindowButton_mouse_1[2] == 4) {
		if (inputWindowOpen ==1) {inputWindowOpen=0;}
		else if (inputWindowOpen == 0) {inputWindowOpen=1;}
	}
}
proc openInputWindow : inputWindowOpen {
	if (inputWindowOpen==1) {
		inputWindowButton_relief is "sunken";
		tcl("wm iconify .");
		tcl("wm deiconify .");
	}
	else {
		inputWindowButton_relief is "raised";	
		tcl("wm withdraw .");
	}
}
%scout

screen=oscilloscope&panel&observables&<panelBack/obsBack/input/inputTitle/oscTitle/acceptButton/inputWindowButton>;

##integer acceptButton_x1=338;
integer acceptButton_x1=180;
integer acceptButton_y1=690;

integer inputTitle_x2=438;

%eden

proc executeCode : ~acceptButton_mouse_1 {
	if (~acceptButton_mouse_1[2] == 4) {
		acceptButton_relief is "sunken";
		tcl(".screen configure -cursor watch");
		eager();
		if (~input_TEXT_1 != @) {
			execute("%analog\n" // ~input_TEXT_1);
		}
	}
	else {
		tcl(".screen configure -cursor arrow");
		acceptButton_relief is "raised";
	}
}


%scout
integer inputTitle_y1=440;

%eden
##DestroyDisplay("observables");
##DestroyDisplay("oscilloscope");
##DestroyDisplay("panel");
tcl("wm withdraw .observables");
tcl("unset show_observables");
tcl("wm withdraw .oscilloscope");
tcl("unset show_oscilloscope");
tcl("wm withdraw .panel");
tcl("unset show_panel");


tcl("wm withdraw .");

%scout
integer ANdisp_refPoint_x = 610;
integer ANdisp_refPoint_y = 0;
integer ANdisp_winHeight= 721;
integer ANdisp_winWidth= 404;


integer inputWindowButton_y1=690;
integer acceptButton_x1=inputWindowButton_x2+20;
integer inputWindowButton_x1=120;


integer ANdisp_windowWidth_c = 110;


integer AN_panel_refPoint_x = 470;


/* The display window for Mode Switching */

%eden
OpenDisplay("panel", 120, 230);
proc panel_display_screen : panel { DisplayScreen(&panel, "panel"); }

%scout

string AN_panel_potSet_bg;
string AN_panel_pc_bg;
string AN_panel_hold_bg;
string AN_panel_compute_bg;
string AN_panel_repop_bg;
string AN_panel_time;
string AN_panel_repopPeriod;

window AN_panel_title = {
  type: TEXT
  string: "Mode"
  frame: ([{10, 5}, {110, 20}])
  sensitive: ON
    alignment: CENTRE
  font: "{helvetica 12 bold}"
};
window AN_panel_potSet = {
  type: TEXT
  string: "POT SET"
  frame: ([{10, 30}, {110, 45}])
  sensitive: ON
  border: 1
    bgcolour: AN_panel_potSet_bg
    alignment: CENTRE
};
window AN_panel_pc = {
  type: TEXT
  string: "RESET"
  frame: ([{10, 50}, {110, 65}])
  sensitive: ON
  border: 1
    bgcolour: AN_panel_pc_bg
    alignment: CENTRE
};
window AN_panel_hold = {
  type: TEXT
  string: "HOLD"
  frame: ([{10, 70}, {110, 85}])
  sensitive: ON
  border: 1
    bgcolour: AN_panel_hold_bg
    alignment: CENTRE
};
window AN_panel_compute = {
  type: TEXT
  string: "COMPUTE"
  frame: ([{10, 90}, {110, 105}])
  sensitive: ON
  border: 1
    bgcolour: AN_panel_compute_bg
    alignment: CENTRE
};
window AN_panel_repop = {
  type: TEXT
  string: "REP-OP"
  frame: ([{10, 110}, {110, 125}])
  sensitive: ON
  border: 1
    bgcolour: AN_panel_repop_bg
    alignment: CENTRE
};
window AN_panel_clockTitle = {
  type: TEXT
  string: "Clock"
  frame: ([{10, 135}, {110, 150}])
    alignment: CENTRE
  font: "{helvetica 12 bold}"
};
window AN_panel_clock = {
  type: TEXT
  string: AN_panel_time
  frame: ([{10, 155}, {110, 170}])
    alignment: CENTRE
};
window AN_panel_periodTitle = {
  type: TEXT
  string: "Period"
  frame: ([{10, 180}, {110, 195}])
    alignment: CENTRE
  font: "{helvetica 12 bold}"
};
window AN_panel_period = {
  type: TEXT
  string: AN_panel_repopPeriod
  frame: ([{10, 205}, {110, 220}])
    alignment: CENTRE
};
display panel;
panel=<AN_panel_title / AN_panel_potSet / AN_panel_pc / AN_panel_hold
        / AN_panel_compute / AN_panel_repop
	/ AN_panel_clockTitle / AN_panel_clock
	/ AN_panel_periodTitle / AN_panel_period>;


%eden
proc AN_panel_potSet_click : ~AN_panel_potSet_mouse_1 {
   if (~AN_panel_potSet_mouse_1[2] == 5) {
	AN_potset();
   }
}
proc AN_panel_pc_click : ~AN_panel_pc_mouse_1 {
   if (~AN_panel_pc_mouse_1[2] == 5) {
	AN_pc();
   }
}
proc AN_panel_hold_click : ~AN_panel_hold_mouse_1 {
   if (~AN_panel_hold_mouse_1[2] == 5) {
	AN_hold();
   }
}
proc AN_panel_compute_click : ~AN_panel_compute_mouse_1 {
   if (~AN_panel_compute_mouse_1[2] == 5) {
	AN_compute();
   }
}
proc AN_panel_repop_click : ~AN_panel_repop_mouse_1 {
   if (~AN_panel_repop_mouse_1[2] == 5) {
	AN_repop();
   }
}


AN_panel_potSet_bg is ((AN_mode_potset==1) ? AN_panel_bgOn : AN_panel_bgOff);
AN_panel_pc_bg is  ((AN_mode_pc==1) ? AN_panel_bgOn : AN_panel_bgOff);
AN_panel_hold_bg is ((AN_mode_hold==1) ? AN_panel_bgOn : AN_panel_bgOff);
AN_panel_compute_bg is ((AN_mode_compute==1) ? AN_panel_bgOn : AN_panel_bgOff);
AN_panel_repop_bg is ((AN_mode_repop==1) ? AN_panel_bgOn : AN_panel_bgOff);

AN_panel_bgOn="green";
AN_panel_bgOff="darkgrey";

AN_panel_time is str(AN_time);
AN_panel_repopPeriod is str(AN_repopPeriod);

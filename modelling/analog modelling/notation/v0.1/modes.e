%eden
proc AN_potset {
      AN_mode_potset=1;
      AN_mode_pc=0;
      AN_mode_hold=0;
      AN_mode_compute=0;
      AN_mode_repop=0;
      AN_clockGoing=0;
      AN_time=0;
}
proc AN_pc {
      AN_mode_potset=0;
      AN_mode_pc=1;
      AN_mode_hold=0;
      AN_mode_compute=0;
      AN_mode_repop=0;
      AN_clockGoing=0;
      AN_setInitialConditions();
}
proc AN_hold {
      AN_mode_potset=0;
      AN_mode_pc=0;
      AN_mode_hold=1;
      AN_mode_compute=0;
      AN_mode_repop=0;
      AN_clockGoing=0;
}
proc AN_compute {
      AN_mode_potset=0;
      AN_mode_pc=0;
      AN_mode_hold=0;
      AN_mode_compute=1;
      AN_mode_repop=0;
      AN_clockGoing=1;
}
proc AN_repop {
      AN_mode_potset=0;
      AN_mode_pc=0;
      AN_mode_hold=0;
      AN_mode_compute=0;
      AN_mode_repop=1;
      AN_clockGoing=2;
}
AN_potset();

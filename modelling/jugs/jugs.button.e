%eden
/* mouse actions associated with the menu selections in jugs.s */

proc wmenu1_button : wmenu1_mouse_1 {
	if (wmenu1_mouse_1[2] == 4)
		input = 1;
}

proc wmenu2_button : wmenu2_mouse_1 {
	if (wmenu2_mouse_1[2] == 4)
		input = 2;
}

proc wmenu3_button : wmenu3_mouse_1 {
	if (wmenu3_mouse_1[2] == 4)
		input = 3;
}

proc wmenu4_button : wmenu4_mouse_1 {
	if (wmenu4_mouse_1[2] == 4)
		input = 4;
}

proc wmenu5_button : wmenu5_mouse_1 {
	if (wmenu5_mouse_1[2] == 4)
		input = 5;
}

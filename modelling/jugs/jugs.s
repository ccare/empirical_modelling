%eden
include("jugs.e");
%scout
string menu1, menu2, menu3, menu4, menu5;
%eden
menu1 is menu[1];
menu2 is menu[2];
menu3 is menu[3];
menu4 is menu[4];
menu5 is menu[5];
%scout

string valid_fg, valid_bg, invalid_fg, invalid_bg;
valid_fg = "black";
valid_bg = "white";
invalid_fg = "white";
invalid_bg = "black";

integer valid1, valid2, valid3, valid4, valid5;

window wmenu1, wmenu2, wmenu3, wmenu4, wmenu5;
box bmenu1, bmenu2, bmenu3, bmenu4, bmenu5;
point base;

base = {1.c, 20.r};

wmenu1 = {
	frame:	(bmenu1),
	string:	menu1,
	fgcolor:if valid1 then valid_fg else invalid_fg endif,
	bgcolor:if valid1 then valid_bg else invalid_bg endif
	sensitive: ON
};
bmenu1 = [base, 1, strlen(menu1)];

wmenu2 = {
	frame:	(bmenu2),
	string:	menu2,
	fgcolor:if valid2 then valid_fg else invalid_fg endif,
	bgcolor:if valid2 then valid_bg else invalid_bg endif
	sensitive: ON
};
bmenu2 = [bmenu1.ne + {1.c, 0}, 1, strlen(menu2)];
# bmenu2 is one space right of bmenu1

wmenu3 = {
	frame:	(bmenu3),
	string:	menu3,
	fgcolor:if valid3 then valid_fg else invalid_fg endif,
	bgcolor:if valid3 then valid_bg else invalid_bg endif
	sensitive: ON
};
bmenu3 = [bmenu2.ne + {1.c, 0}, 1, strlen(menu3)];
# bmenu3 is one space right of bmenu2

wmenu4 = {
	frame:	(bmenu4),
	string:	menu4,
	fgcolor:if valid4 then valid_fg else invalid_fg endif,
	bgcolor:if valid4 then valid_bg else invalid_bg endif
	sensitive: ON
};
bmenu4 = [bmenu3.ne + {1.c, 0}, 1, strlen(menu4)];
# bmenu4 is one space right of bmenu3

wmenu5 = {
	frame:	(bmenu5),
	string:	menu5,
	fgcolor:if valid5 then valid_fg else invalid_fg endif,
	bgcolor:if valid5 then valid_bg else invalid_bg endif
	sensitive: ON
};
bmenu5 = [bmenu4.ne + {1.c, 0}, 1, strlen(menu5)];
# bmenu5 is one space right of bmenu4

integer capA, capB, contentA, contentB, widthA, widthB, height;
string targ, totstat;

window wcapA, wcapB, wcontentA, wcontentB;
frame fcapA, fcapB;
string cA, cB, JugA, JugB;
%eden
func repeatChar
{
	auto s, i;
	s = substr("", 1, $2);
	for (i = 1; i <= $2; i++)
		s[i] = $1;
	return s;
}

cA is repeatChar('~', widthA*contentA);
cB is repeatChar('~', widthB*contentB);
JugA is repeatChar('|', 2*capA+2+widthA);
JugB is repeatChar('|', 2*capB+2+widthB);
%scout

fcapA = ([bmenu1.ne+{0, -(2+capA).r}, capA, 1],
	 [bmenu1.ne+{(widthA+1).c, -(2+capA).r}, capA, 1],
	 [bmenu1.ne+{0, -2.r}, 1, widthA+2]);
wcapA = {frame:fcapA, string:JugA};
wcontentA = {
	frame:	([wcapA.frame.3.nw+{1.c,-contentA.r}, contentA, widthA]),
	string:	cA,
	bgcolor:"yellow"
};

fcapB = ([fcapA.1.nw+{(widthA+3).c, (capA-capB).r}, capB, 1],
	 [fcapA.2.nw+{(widthA+3).c, (capA-capB).r}, capB, 1],
	 [fcapA.3.nw+{(widthA+3).c, 0}, 1, widthB+2]);
wcapB = {frame:fcapB, string:JugB};
wcontentB = {
	frame:	([wcapB.frame.3.nw+{1.c,-contentB.r}, contentB, widthB]),
	string:	cB,
	bgcolor:"yellow"
};

window wstatus;
wstatus = {
	frame:	([fcapB.2.ne+{2.c, (capB/2).r},1,strlen(targ // totstat)]),
	string:	targ // totstat
};

%eden
include("jugs.disp.d");
%scout
window don;
point p, q;
p = {100, 300};
q = {300, 400};
don = {
	type:	DONALD,
	box:	[p, q],
	pict:	"jugDisplay"
};
display jugs = <wcontentA / wcontentB / wcapA / wcapB / wstatus >;

integer input;

%scout
window w = {
  type: DONALD,
  box: [{10,10},{210,210}],
  sensitive: MOTION,
  border: 1,
  xmin: -1,
  xmax: 1,
  ymin: -1,
  ymax:1
};
screen= <w>;

%eden 
mouseIn is ~w_mousePos[1];

proc myUpdate: mouseIn  {
s = "dx = "//str(mouseIn)//";";
sendServer("", s);
}

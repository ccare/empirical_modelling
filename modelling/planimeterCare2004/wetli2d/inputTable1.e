
%eden
DFwidth=400;
DFheight=400;

%donald
viewport input
line xAxis,yAxis
xAxis = [{0,-1},{0,1}]
yAxis = [{-1,0},{1,0}]



%scout
window w = {
  type: DONALD,
  pict: "input",
  box: [{0,0},{400,400}],
  sensitive: MOTION,
  border: 0,
  xmin: -1,
  xmax: 1,
  ymin: -1,
  ymax:1
};
screen= <w>;

%eden 
mouseIn is ~w_mousePos;

proc myUpdate: mouseIn  {
sendServer("","%eden\ninputTable1_x = "//str(mouseIn[1])//";inputTable1_y= "//str(mouseIn[2])//";");

}

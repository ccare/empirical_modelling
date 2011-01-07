## *****************************************************
## **        A Wheel and Disc Planimeter Unit         **
## **            With DoNaLD Visulisation             **
## **                                                 **
## **                                    Charles Care **
## **                                      12/12/2003 **
## *****************************************************

## =====================================================
## |             Definitions of The Disc               |
## =====================================================

%eden

## The Disc has has an accumulated angular displacement
discRotation = 0;
## And a radius
discRadius = 5;

## The disc's position ranges to change the wheels position
## -1.0 (One edge) -> 0.0 (Centre) -> 1.0 (Other Edge)
discDisplacement = 0.0;

## The disc has a speed
discSpeed = 0.0;

## The disc has a spindle with rotation
discSpindleRotation = 0;


## =====================================================
## |             Definitions of The Wheel              |
## =====================================================

%eden

## The Wheel has an angular displacement
wheelRotation = 0;
## And a radius
wheelRadius = 1;

## The Wheel's position ranges across disc 
## from one edge to the other
## -1.0 (One edge) -> 0.0 (Centre) -> 1.0 (Other Edge)
wheelRatio is discDisplacement; 
## Resolve this to actual displacement from centre of Disc
wheelPos is discRadius*wheelRatio;

## The wheel has a speed
wheelSpeed = 0;


## =====================================================
## |  The Relationship between the disc and the wheel  |
## |      (with respect to a 'time' incrementor)       |
## =====================================================

%eden

## A variable that is 1 when clock is running
clockGoing = 0;

proc clock {

##  newDiscMovement = discMovement;
  discSpeed = discSpindleRotation-discRotation; ## rads / time
##  oldDiskMovement = newDiscMovement;
    
  ## discRotation is accumulated
  discRotation = discRotation+discSpeed;
  
  ## wheelSpeed is defined in terms of the disc
  wheelSpeed = wheelPos*discSpeed;
  ## wheelRotation is accumulated
  wheelRotation = wheelRotation+wheelSpeed;
  
  ## Re-run this procedure soon if not stopped.
  if (clockGoing == 1) {
    todo("clock();");
  }
};


## =====================================================
## |          Visualisation of The Planimeter          |
## =====================================================
##
## -----------------------------------------------------
## Looking from above:
##   the disc is a circle and the wheel a line
## -----------------------------------------------------

%donald
viewport above 

## The disc from above
openshape discTop 

## Definitions of the disc
within discTop {
  ## The disc itself
  circle disc
  point centre
  real radius,rotation,displacement
  centre = {radius*displacement,0}
  disc = circle(centre,radius)
  
  ## Dotted lines on the disc
  real halfpi
  real angleA,angleB,angleC,angleD  
  point A,B,C,D
  line X,Y
    
  angleA = halfpi
  angleB = 2*halfpi
  angleC = 3*halfpi
  angleD = 4*halfpi
  A = centre + {radius*sin(angleA+rotation),radius*cos(angleA+rotation)}
  B = centre + {radius*sin(angleB+rotation),radius*cos(angleB+rotation)}
  C = centre + {radius*sin(angleC+rotation),radius*cos(angleC+rotation)}
  D = centre + {radius*sin(angleD+rotation),radius*cos(angleD+rotation)}
  X = [A,C]
  Y = [B,D]
}

## Eden code to support the disc definitions

## define halfpi
?_discTop_halfpi = PI / 2;
## create dependency between 
## displayed radius and real radius
?_discTop_radius is discRadius;
## create dependency between
## displayed rotation and real rotation
?_discTop_rotation is discRotation;
## create dependency between
## displayed displacement and real displacement
?_discTop_displacement is discDisplacement;
## set linestyles and colours
?A_discTop_X = "linestyle=dotted";
?A_discTop_Y = "linestyle=dotted";
?A_discTop_disc = "outlinecolor=blue";

## The wheel from above
openshape wheelTop

## Definitions of the wheel
within wheelTop {
  point centre
  real radius
  line wheel

  centre = {0,0}
  wheel = [centre-{0,radius},centre+{0,radius}]
}
## Eden code to support wheel definitions

## create dependency between 
## displayed radius and real radius
?_wheelTop_radius is wheelRadius;
## set colour
?A_wheelTop_wheel = "color=red";

## -----------------------------------------------------
## Looking sideways:
##   the disc is a line and the wheel a line
## -----------------------------------------------------

%donald
viewport side

## The disc from the side
openshape discSide

## Definitions of the disc
within discSide {
  line disc
  point centre
  real radius,displacement

  centre = {radius*displacement,0}
  disc = [centre-{radius,0},centre+{radius,0}]
}

## Eden code to support wheel definitions

## create dependency between 
## displayed radius and real radius
?_discSide_radius is discRadius;
## create dependency between
## displayed displacement and real displacement
?_discSide_displacement is discDisplacement;
## Set colour
?A_discSide_disc = "color=blue";

## The wheel from the side
openshape wheelSide

## Definitions of the wheel
within wheelSide {
  point centre
  real radius
  line wheel

  centre = {0,radius}
  wheel = [centre-{0,radius},centre+{0,radius}]
}
## Eden code to support wheel definitions

## create dependency between 
## displayed radius and real radius
?_wheelSide_radius is wheelRadius;
## Set colour
?A_wheelSide_wheel = "color=red";

## -----------------------------------------------------
## Looking Endways:
##   the disc is a line and the wheel a circle
## -----------------------------------------------------
%donald
viewport end

## The disc from the end
openshape discEnd

## definitions of the disc
within discEnd {
  line disc
  point centre
  real radius

  centre = {0,0}
  disc = [centre-{radius,0},centre+{radius,0}]
}
## Eden code to support wheel definitions

## create dependency between 
## displayed radius and real radius
?_discEnd_radius is discRadius;
## Set Colour
?A_discEnd_disc = "color=blue";

## The wheel from the end
openshape wheelEnd 

## Definitions of the wheel
within wheelEnd {
  ## The wheel itself
  circle wheel
  point centre
  real radius,rotation
  centre = {0,radius}
  wheel = circle(centre,radius)
  
  ## Dotted lines on the wheel
  real halfpi
  real angleA,angleB,angleC,angleD  
  point A,B,C,D
  line X,Y  
  
  angleA = halfpi
  angleB = 2*halfpi
  angleC = 3*halfpi
  angleD = 4*halfpi
  A = centre + {radius*sin(angleA+rotation),radius*cos(angleA+rotation)}
  B = centre + {radius*sin(angleB+rotation),radius*cos(angleB+rotation)}
  C = centre + {radius*sin(angleC+rotation),radius*cos(angleC+rotation)}
  D = centre + {radius*sin(angleD+rotation),radius*cos(angleD+rotation)}
  X = [A,C]
  Y = [B,D]
}

## Eden Code to support the wheel definitions

## define halfpi
## create dependency between 
## displayed radius and real radius
?_wheelEnd_radius is wheelRadius;
## create dependency between
## displayed rotation and real rotation
?_wheelEnd_rotation is wheelRotation;
?_wheelEnd_halfpi = PI / 2;
?A_wheelEnd_X = "linestyle=dotted";
?A_wheelEnd_Y = "linestyle=dotted";
?A_wheelEnd_wheel = "outlinecolor=red";

## -----------------------------------------------------
## A 3D axis marker
## -----------------------------------------------------
%donald
viewport axis3D
openshape axis

within axis {
point centre,x,y,z
line X,Y,Z
centre={0,0}
## Ends of each axis mark
y = centre+{0,2}
x = centre+{1.73,-1}
z = centre+{-1.73,-1}
## Each Axis mark
X = [centre,x]
Y = [centre,y]
Z = [centre,z]
}
## Setting Colours, widths 
## and defining the lines as arrows
?A_axis_X="color=LightPink1,linewidth=3,arrow=last";
?A_axis_Y="color=PaleGreen1,linewidth=3,arrow=last";
?A_axis_Z="color=LightBlue1,linewidth=3,arrow=last";

## -----------------------------------------------------
## A Revolution Counter
## -----------------------------------------------------
%donald
viewport revCount
openshape revCounter

within revCounter {
  point counter1,counter2,offset
  openshape wheelCounter,discCounter
  
  counter1 = {0,1}
  counter2 = {0,0}  
  offset = {1,0}
  
  within wheelCounter {
    label title,value
    point t,v
    char data
    t = ~/counter1
    v = t+~/offset
    title = label("Wheel:",t)
    value = label(data,v)    
  }
  within discCounter {
    label title,value
    point t,v
    char data
    
    t = ~/counter2
    v = t+~/offset
    title = label("Disc:",t)
    value = label(data,v)    
  }
}
?discRotationMeterZero=0;
?wheelRotationMeterZero=0;
?_revCounter_wheelCounter_data is ((wheelRotation - wheelRotationMeterZero)/ (2*PI));
?_revCounter_discCounter_data is ((discRotation - discRotationMeterZero) / (2*PI));

## -----------------------------------------------------
## Status of Clock
## -----------------------------------------------------
%donald
viewport clockStat

openshape clockLabel
within clockLabel {
  label l
  char data
  
  ## Initial setting
  data = "Stopped"
  l = label(data,{0,0})
}
## Set colour
?A_clockLabel_l = "color=Red";

## -----------------------------------------------------
## Bringing the views together on Screen
## -----------------------------------------------------
%scout

window viewAbove = {
  type: DONALD,
  box: [{10,10},{410,210}],
  pict: "above",
  xmin: -12,
  xmax: 12,
  ymin: -6,
  ymax: 6,
  sensitive: OFF,
  border: 1,
  bgcolor: "PaleGreen1"
};

window viewSide = {
  type: DONALD,
  box: [{10,220},{410,320}],
  pict: "side",
  xmin: -12,
  xmax: 12,
  ymin: -1,
  ymax: 5,
  sensitive: OFF,
  border: 1,
  bgcolor: "LightBlue1"
};

window viewEnd = {
  type: DONALD,
  box: [{420,10},{820,210}],
  pict: "end",
  xmin: -6,
  xmax: 6,
  ymin: -1,
  ymax: 5,
  sensitive: OFF,
  border: 1,
  bgcolor: "LightPink1"
};

window viewAxis = {
  type: DONALD,
  box: [{420,220},{520,320}],
  pict: "axis3D",
  xmin: -2,
  xmax: 2,
  ymin: -1.5,
  ymax: 2.5,
  sensitive: OFF,
  border: 1,
  bgcolor: "Grey60"
};
window TitleRots = {
  type: TEXT,
  frame: ([{560,220},{710,235}]),
  sensitive: OFF,
  string: "Revolution Counter",
  font: "{Helvetica 12 bold}",
  alignment: CENTRE,
  border: 0
};

window RevCounter = {
  type: DONALD,
  box: [{560,240},{710,295}],
  pict: "revCount",
  xmin: -1,
  xmax: 2,
  ymin: -0.75,
  ymax: 1.75,
  sensitive: OFF,
  border: 1,
  bgcolor: "Grey60"
};

window ButtonReset = {
  type: TEXT,
  frame: ([{600,305},{670,320}]),
  sensitive: ON,
  string: "Reset",
  font: "{Helvetica 12 bold}",
  alignment: CENTRE,
  border: 1
};

window TitleClock = {
  type: TEXT,
  frame: ([{750,220},{820,235}]),
  sensitive: OFF,
  string: "Clock",
  font: "{Helvetica 12 bold}",
  alignment: CENTRE,
  border: 0
};

window clockStatus = {
  type: DONALD,
  box: [{750,240},{820,265}],
  sensitive: OFF,
  pict: "clockStat",
  border: 1,
  xmin:-2
  xmax: 2
  ymin: -1
  ymax:1
  bgcolor: "Grey60"
};
window ButtonStart = {
  type: TEXT,
  frame: ([{750,275},{820,290}]),
  sensitive: ON,
  string: "Start",
  font: "{Helvetica 12 bold}",
  alignment: CENTRE,
  border: 1
};

window ButtonStop = {
  type: TEXT,
  frame: ([{750,305},{820,320}]),
  sensitive: ON,
  string: "Stop",
  font: "{Helvetica 12 bold}",
  alignment: CENTRE,
  border: 1
};

screen = <viewAbove / viewSide / 
viewEnd / viewAxis / TitleRots / RevCounter /
ButtonReset / TitleClock /clockStatus/ButtonStart/ButtonStop>;

## =====================================================
## Registering the buttons with procedures
## =====================================================

%eden

proc reset: ~ButtonReset_mouse_1 {
  ## Set disc and wheel counter zero points to current displacement
  discRotationMeterZero=discRotation;
  wheelRotationMeterZero=wheelRotation;
};

proc start: ~ButtonStart_mouse_1 {
  ## if clock isn't already going then start it
  if (clockGoing == 0) {
    clockGoing = 1;
    _clockLabel_data = "Running";
    A_clockLabel_l = "color=Green";
    clock();
  }
};

proc stop: ~ButtonStop_mouse_1 {
  ## if the clock is going then stop it
  if (clockGoing == 1) {
    clockGoing = 0;
    _clockLabel_data = "Stopped";
    A_clockLabel_l = "color=Red";
  }
};


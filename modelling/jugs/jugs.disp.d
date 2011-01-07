%donald
viewport jugDisplay
line baseA, rsideA, lsideA
line baseB, rsideB, lsideB
int midjugA, midjugB
int jugwidth, halfwidth
int unit, baseht
int htA, htB
int ctA, ctB
halfwidth = jugwidth div 2
jugwidth = 2
baseht = 500
unit = 50
midjugA = 2
point origin
origin = {500, baseht}
baseA = [{midjugA - halfwidth*unit, baseht} , {midjugA + halfwidth*unit, baseht}] 
baseB = [{midjugB - halfwidth*unit, baseht} , {midjugB + halfwidth*unit, baseht}] 
rsideA = [{midjugA - halfwidth*unit, baseht} , {midjugA - halfwidth*unit, baseht + htA *unit}] 
rsideB = [{midjugB - halfwidth*unit, baseht} , {midjugB - halfwidth*unit, baseht + htB*unit}] 
lsideA = [{midjugA + halfwidth*unit, baseht} , {midjugA + halfwidth*unit, baseht + htA *unit}] 
lsideB = [{midjugB + halfwidth*unit, baseht} , {midjugB + halfwidth*unit, baseht + htB*unit}] 
midjugA = 500 - jugwidth * unit
midjugB = 500 + jugwidth * unit
line wA, wB
wA = [{midjugA - halfwidth*unit, baseht + ctA *unit}, {midjugA + halfwidth*unit, baseht + ctA *unit}]
wB = [{midjugB - halfwidth*unit, baseht + ctB *unit}, {midjugB + halfwidth*unit, baseht + ctB *unit}]
? A_wA = "linestyle=dashed, dash=12";
? A_wB = "linestyle=dashed, dash=12";
? A_baseA = "linewidth=3";
? A_baseB = "linewidth=3";
%eden
_htA is capA;
_htB is capB;
_ctA is contentA;
_ctB is contentB;
_jugwidth is widthA;

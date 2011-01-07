## =====================================================
## Planimeter 2
## =====================================================

%eden
include("planimeter.e");

## =====================================================
## Registering the server control variables
## ===================================================== 
discSpindleRotation is planimeter2_x;
discDisplacement is planimeter2_y;

renewObs("planimeter2_x");
renewObs("planimeter2_y");


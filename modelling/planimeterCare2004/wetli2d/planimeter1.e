## =====================================================
## Planimeter 1
## =====================================================

%eden
include("planimeter.e");

## =====================================================
## Registering the server control variables
## ===================================================== 
discSpindleRotation is planimeter1_x;
discDisplacement is planimeter1_y;

renewObs("planimeter1_x");
renewObs("planimeter1_y");

proc sendOutput : wheelRotation {
sendServer("","planimeter1_int="//str(wheelRotation)//";");

}

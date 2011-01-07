%lsd

agent planimeter1
oracle planimeter1_x
oracle planimeter1_y
handle planimeter1_int

agent planimeter2
oracle planimeter2_x
oracle planimeter2_y
handle planimeter2_int

agent inputTable1
handle inputTable1_x
handle inputTable1_y

%eden
planimeter1_x = 0;
planimeter1_y = 0;
planimeter2_x = 0;
planimeter2_y = 0;

%eden 
proc inputY: inputTable1_y {
  planimeter1_y = inputTable1_y;
}
proc inputX: inputTable1_x {
  planimeter1_x = inputTable1_x;
}

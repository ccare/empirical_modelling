How to run this model:

The server and the two/three agents (input and 1 or 3 planimeters) 
can be run on different machines or the same
machine.

For each of these three dtkeden sessions a terminal window should be open with
this directory as the working directory.

Then

1) In the terminal that will run Server, execute ./startServer
2) A dtkeden session in superagent mode should start
3) In the terminal that will run Input, execute ./startInputTable1
4) When prompted for a login use "inputTable1" (without the quotes)
5) In the terminal that will run Planimeter, execute ./startPlanimeter
6) When prompted for a login use "planimeter1" (without the quotes)

NB: For this to work, the three 'start' scripts need execute permissions and you
need write permissions in this directory (the server script creates a temporary
file containing the hostname of the server). 

Charlie Care
11/12/2003

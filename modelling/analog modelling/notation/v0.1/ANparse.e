## Load the up-to-date AOP
cd("aop_v204");
include("Run.e");
cd("..");

## Name of Notation
AN_notationName="%analog";


## Names for input/output
ANparse_name_special = [ "literal", "+", ["fail", "ANparse_name_special1"], ["action",
["now","$v=[\"AN_REFERENCE_POSITIVE\"];"]] ];
ANparse_name_special1 = [ "literal", "-", ["fail", "ANparse_name_special2"], ["action",
["now","$v=[\"AN_REFERENCE_NEGATIVE\"];"]] ];
ANparse_name_special2 = [ "literal", "0", ["fail", "ANparse_name"], ["action",
["now","$v=[\"AN_REFERENCE_ZERO\"];"]] ];
ANparse_name = [ "literal_re", "[a-z]+[a-z,0-9,_]*", ["fail", "ANparse_nameErr"], ["action", 
["now","$v=[\"$t\"];"]] ];
ANparse_nameErr = [ "read_all", [], ["action",["now", "error(\"Not a valid " // AN_notationName // " variable name.\n\n\");"]]];


## Values for scaling potentiometers range over the interval (0,1)
ANparse_potVal = [ "literal_re", "0.[0-9]+" , ["fail", "ANparse_potValErr"], ["action", ["now","$v=[\"$t\"];"]] ];
ANparse_potValErr = [ "read_all", [], ["action",["now", "error(\"Can only scale by values in the interval (0,1).\n\n\");"]]];

## Values for scaling potentiometers range over the interval (0,1)
ANparse_int = [ "literal_re", "[0-9]+" , ["fail", "ANparse_intErr"], ["action", ["now","$v=[\"$t\"];"]] ];
ANparse_intErr = [ "read_all", [], ["action",["now", "error(\"Not an Integer.\n\n\");"]]];



## EQUALS SIGN:  Dependency
ANparse_depend = [ "pivot", "=", ["ANparse_name", "ANparse_scale"], [ "fail", "ANparse_Err"], 
			[ "action", [ "later", "$v = $p1 // $p2;ANparse_add($v);" ]]]; 

## Scale declaration:
ANparse_scale = [ "prefix", "scale(", "ANparse_scale1", [ "fail", "ANparse_summer"], 
			[ "action", [ "later", "$v = [\"scale\"] // $p1;" ]]];
ANparse_scale1 = [ "suffix", ")", "ANparse_scale2", [ "fail", "ANparse_Err"], 
			[ "action", [ "later", "$v = $p1;" ]]];
ANparse_scale2 = [ "pivot", ",", ["ANparse_potVal", "ANparse_name_special"], [ "fail", "ANparse_scale2Err"], 
			[ "action", [ "later", "$v = $p1 // $p2;" ]]];
ANparse_scale2Err = [ "read_all", [], ["action",["now", "error(\"Incorrect syntax for definition scale.\n\n\");"]]];

## Summer declaration:
ANparse_summer = [ "prefix", "summer(", "ANparse_summer1", [ "fail", "ANparse_integrator"], 
			[ "action", [ "later", "$v = [\"summer\"] // $p1;" ]]];
ANparse_summer1 = [ "suffix", ")", "ANparse_summer2", [ "fail", "ANparse_Err"], 
			[ "action", [ "later", "$v = $p1;" ]]];
ANparse_summer2 = [ "pivot", ",", ["ANparse_name_special", "ANparse_name_special"], [ "fail", "ANparse_summer2Err"], 
			[ "action", [ "later", "$v = $p1 // $p2;" ]]];
ANparse_summer2Err = [ "read_all", [], ["action",["now", "error(\"Incorrect syntax for definition summer.\n\n\");"]]];

## Integrator declaration:
ANparse_integrator = [ "prefix", "integrator(", "ANparse_integrator1", [ "fail", "ANparse_amplifyByTen"],
			[ "action", [ "later", "$v = [\"integrator\"] // $p1;" ]]];
ANparse_integrator1 = [ "suffix", ")", "ANparse_integrator2", [ "fail", "ANparse_Err"],
			[ "action", [ "later", "$v = $p1;" ]]];
ANparse_integrator2 = [ "pivot", ",", ["ANparse_name_special", "ANparse_name_special"], [ "fail", "ANparse_integrator2Err"], 
			[ "action", [ "later", "$v = $p1 // $p2;" ]]];
ANparse_integrator2Err = [ "read_all", [], ["action",["now", "error(\"Incorrect syntax for definition integrator.\n\n\");"]]];

## Amplifyer declaration:
ANparse_amplifyByTen = [ "prefix", "amplify(", "ANparse_amplifyByTen1", [ "fail", "ANparse_name_special"],
			[ "action", [ "later", "$v = [\"amplifyByTen\"] // $p1;" ]]];
ANparse_amplifyByTen1 = [ "suffix", ")", "ANparse_name", [ "fail", "ANparse_Err"],
			[ "action", [ "later", "$v = $p1;" ]]];
			

## COMMANDS

ANparse_openPanel = [ "literal", "open_panel", [ "fail", "ANparse_mode"],
			[ "action", ["now", "include(\"panel.e\");"]]];

ANparse_mode = [ "prefix", "mode", "ANparse_mode1", [ "fail", "ANparse_repopPeriod"]];

ANparse_mode1 = [ "literal", "potset", [ "fail", "ANparse_mode2"],
			[ "action", ["now", "AN_potset();"]]];

ANparse_mode2 = [ "literal", "reset", [ "fail", "ANparse_mode3"],
			[ "action", ["now", "AN_pc();"]]];

ANparse_mode3 = [ "literal", "hold", [ "fail", "ANparse_mode4"],
			[ "action", ["now", "AN_hold();"]]];
			
ANparse_mode4 = [ "literal", "compute", [ "fail", "ANparse_mode5"],
			[ "action", ["now", "AN_compute;"]]];
			
ANparse_mode5 = [ "literal", "repop", [ "fail", "ANparse_Err"],
			[ "action", ["now", "AN_repop();"]]];
			
ANparse_repopPeriod = [ "prefix", "period=", "ANparse_int", [ "fail", "ANparse_depend"],
			[ "action", ["now", "AN_repopPeriod is int($p1[1]);"]]];
			
ANparse_repopPeriod1 = [ "literal", "[0-9]+", [ "fail", "ANparse_Err"]];	
			
			
## Initial Rule 
ANparse_init = ["\n", "ANparse_stm", []];
ANparse_stm = ["suffix", ";", "ANparse_openPanel", [ "fail", "ANparse_Err"] ];

## General Error Case
ANparse_Err = [ "read_all", [], ["action",["now", "error(\"Not a valid " // AN_notationName // " definition or command.\n\n\");"]]];


## ADD NOTATION
installAOP(AN_notationName, "ANparse_init");

%eden
proc ANparse_add {
   if ($1# >= 3) {
      if ($1[2] == "scale") {
         todo("%eden\n" //
	 	"AN_dbCleanUp(\"" // $1[1] // "\");\n" //
      		$1[1] // " is AN_filter(" // $1[3] // "*" // $1[4] // ");\n"
	    // AN_notationName );
      }
      else if ($1[2] == "summer") {
         todo("%eden\n" //
	 	"AN_dbCleanUp(\"" // $1[1] // "\");\n" //
      		$1[1] // " is -1.0*AN_filter(" // $1[3] // "+" // $1[4] // ");\n"
	    // AN_notationName );
      }
      else if ($1[2] == "integrator") {
         todo("%eden\n" //
      		$1[1] // " is -1.0*AN_value_" // $1[1] // ";\n" //
		"AN_value_" // $1[1] // " is " // $1[4] // ";\n" //
               "AN_addIntegrator(\"AN_value_" // $1[1] // "\",\"" // $1[3] // "\",\"" // $1[4] // "\");\n"
	    // AN_notationName );
      }
      else if ($1[2] == "amplifyByTen") {
         todo("%eden\n" //
	 	"AN_dbCleanUp(\"" // $1[1] // "\");\n" //
      		$1[1] // " is AN_filter(" // "10.0 * " // $1[3] // ");\n"
	    // AN_notationName );
      }
   } else if ($1# == 2) {
         todo("%eden\n" //
	 	"AN_dbCleanUp(\"" // $1[1] // "\");\n" //
      		$1[1] // " is " // $1[2] // ";\n"
	    // AN_notationName );
   }
}

/*
?AN_tables_InitialConditions
?AN_tables_Integrators

*/

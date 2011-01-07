## Load the up-to-date AOP
cd("aop_v204");
include("Run.e");
cd("..");

## Name of Notation
AN_notationName="%analog";


## Names for entities
ANparse_name = [ "literal_re", "[a-z]+[a-z,0-9,_]*", ["fail", "ANparse_nameErr"], ["action", ["now","$v=\"$t\";"]] ];
ANparse_nameErr = [ "read_all", [], ["action",["now", "error(\"Not a valid " // AN_notationName // " variable name.\n\n\");"]]];

## Values for scaling potentiometers range over the interval (0,1)
ANparse_potVal = [ "literal_re", "0.[0-9]+" , ["fail", "ANparse_potValErr"], ["action", ["now","$v=\"$t\";"]] ];
ANparse_potValErr = [ "read_all", [], ["action",["now", "error(\"Can only scale by values in the interval (0,1).\n\n\");"]]];

## Dependency:
ANparse_depend = [ "pivot", "=", ["ANparse_name", "ANparse_scale"], [ "fail", "ANparse_Err"], 
			[ "action", [ "later", "$v = [$p1] // $p2;ANparse_add($v);" ]]]; 

## Scale declaration:
ANparse_scale = [ "prefix", "scale(", "ANparse_scale1", [ "fail", "ANparse_summer"], 
			[ "action", [ "later", "$v = [\"scale\"] // $p1;" ]]];
ANparse_scale1 = [ "suffix", ")", "ANparse_scale2", [ "fail", "ANparse_Err"], 
			[ "action", [ "later", "$v = $p1;" ]]];
ANparse_scale2 = [ "pivot", ",", ["ANparse_potVal", "ANparse_name"], [ "fail", "ANparse_scale2Err"], 
			[ "action", [ "later", "$v = [$p1,$p2];" ]]];
ANparse_scale2Err = [ "read_all", [], ["action",["now", "error(\"Incorrect syntax for definition scale.\n\n\");"]]];

## Summer declaration:
ANparse_summer = [ "prefix", "summer(", "ANparse_summer1", [ "fail", "ANparse_integrator"], 
			[ "action", [ "later", "$v = [\"summer\"] // $p1;" ]]];
ANparse_summer1 = [ "suffix", ")", "ANparse_summer2", [ "fail", "ANparse_Err"], 
			[ "action", [ "later", "$v = $p1;" ]]];
ANparse_summer2 = [ "pivot", ",", ["ANparse_name", "ANparse_name"], [ "fail", "ANparse_summer2Err"], 
			[ "action", [ "later", "$v = [$p1,$p2];" ]]];
ANparse_summer2Err = [ "read_all", [], ["action",["now", "error(\"Incorrect syntax for definition summer.\n\n\");"]]];

## Integrator declaration:
ANparse_integrator = [ "prefix", "integrator(", "ANparse_integrator1", [ "fail", "ANparse_name"],
			[ "action", [ "later", "$v = [\"integrator\"] // $p1;" ]]];
ANparse_integrator1 = [ "suffix", ")", "ANparse_integrator2", [ "fail", "ANparse_Err"],
			[ "action", [ "later", "$v = $p1;" ]]];
ANparse_integrator2 = [ "pivot", ",", ["ANparse_name", "ANparse_name"], [ "fail", "ANparse_integrator2Err"], 
			[ "action", [ "later", "$v = [$p1,$p2];" ]]];
ANparse_integrator2Err = [ "read_all", [], ["action",["now", "error(\"Incorrect syntax for definition integrator.\n\n\");"]]];

## Initial Rule 
ANparse_init = ["\n", "ANparse_stm", []];
ANparse_stm = ["suffix", ";", "ANparse_depend", [ "fail", "ANparse_Err"] ];

## General Error Case
ANparse_Err = [ "read_all", [], ["action",["now", "error(\"Not a valid " // AN_notationName // " definition.\n\n\");"]]];


## ADD NOTATION
installAOP(AN_notationName, "ANparse_init");

%eden
proc ANparse_add {
   if ($1# == 4) {

   if ($1[2] == "scale") {
      write("add scale:");
      todo("%eden\n" //
      		$1[1] // " is AN_scale(" // $1[3] // "," // $1[4] // ");\n"
	    // AN_notationName );
   }
   else if ($1[2] == "summer") {
      write("add summer:");
      todo("%eden\n" //
      		$1[1] // " is AN_summer(" // $1[3] // "," // $1[4] // ");\n"
	    // AN_notationName );
   }
   else if ($1[2] == "integrator") {
      write("add integrator:");
      todo("%eden\n" //
      		$1[1] // " is -1*AN_value_" // $1[1] // ";\n" //
		"AN_value_" // $1[1] // " = " // $1[4] // ";\n" //
               "AN_addIntegrator(\"AN_value_" // $1[1] // "\",\"" // $1[3] // "\",\"" // $1[4] // "\");\n"
	    // AN_notationName );
   }
}
}

/*
?AN_tables_InitialConditions
?AN_tables_Integrators

*/

New agent-oriented parser. [Ant][18/11/2002]

The scripts contained in this package completely redefine the agent-oriented
parser. You can move between the old and new parsers at anytime by changing the
'new_parser' boolean (e.g. 'new_parser = FALSE;'). All existing scripts should
be compatible with the new AOP, but should you have any problems then email
csvcx@dcs.

Changes:
 - Added new way to specify scripts with the "action" tag (see action.txt).
 - An agents data is now local to itself. You can have more than one parsing
   procedure operating at once. This does not apply to any existing notations
   that use global variables.
 - AOP functions now all have sensible names beginning with 'aop_'. Any global
   variables used (very few) should also begin with 'aop_'.
 - Separated various functionality. New operations can now be added by only
   changing the 'aop_operation' function. Similarly the scripting language is
   not dependent on the agent.
 - Added extra error capabilities - two types of error (WARNING and ERROR).
 - An input that fails to parse no longer asks you to enter a new string or type
   'q'. The new parser simple returns: 'parse failure'.
 - Includes perl style regular expressions (see regexp package).


/* error.e [15/11/2002][Ant] */

/* constants */
AOP_ERROR = 1;
AOP_WARNING = 2;

/* set this to false to suppress warning messages */
aop_show_warnings = TRUE;

/* function: aop_error
 * params: err_type = 1 for error or 2 for warning,
           err_text is string of error message
 * returns: nothing
 * notes: maybe change this function to throw eden style errors - error()
 */
func aop_error {
  para err_type, err_text;
  switch (err_type) {
    case 2: ##AOP_WARNING
      if (aop_show_warnings)
        writeln("WARNING: AOP: ", err_text);
      break;
    case 1: ##AOP_ERROR
    default:
      writeln("ERROR: AOP: ", err_text);
      break;
  }
}
/* operations.e [09/11/2002][Ant] */

FAIL = 0;

/* pivot finds a sub-string, ignoring given blocks, and returns the
   sub-strings on either side of it */
func aop_pivot {
  para instr, pivot, ignore;
  auto i;
  
  i = extract(instr, pivot, ignore, 1);
  
  if (i == 0)
    return FAIL;
  else
    return [pivot, [substr(instr, 1, i - 1), substr(instr, i + pivot#, instr#)]];
}

/* pivot_rev is pivot but searches from the end of the string backwards */
func aop_pivot_rev {
  para instr, pivot, ignore;
  auto str, i, j;
  
  i = extract (instr, pivot, ignore, 1);
  
  if (i == 0)
    return FAIL;

  while (i != 0) {
    j = i;
    i = extract (instr, pivot, ignore, j + pivot#);
  }

  return [pivot, [substr(instr, 1, j-1), substr(instr, j+pivot#, instr#)]];
}

/* split divides a string into chunks using a separator, ignoring all
       occurrences of the separator within the given blocks */
func aop_split {
	para instr, split, ignore;
	auto i, j, list;

	i = 1;
	list = [];

	while (1) {
		j = extract (instr, split, ignore, i);

		if (j == 0)
			return [split] // [list // [substr (instr, i, instr#)]];

		list = list // [substr (instr, i, j - 1)];
		i = j + split#;
	}
}

/* read_prefix matches a prefix to a sort of regular expresion
   it returns the prefix found and the remainder */
func aop_read_prefix {
  para instr, chars, count;
  auto result;

  if (chars == []) {
    if (count == "*")
      return [instr, []];
    else if (count <= instr#)
      return [substr(instr, 1, count), [substr(instr, count + 1, instr#)]];
    else
      return FAIL;
  }
  else {
    if (count == "*")
      result = chars_begin(instr, chars);
    else
      result = chars_finite_begin(instr, chars, count);
    if (result == [])
      return FAIL;
    return [ result[1], [result[2]] ];
  }
}

/* read_suffix matches a suffix to a sort of regular expresion
   it returns the suffix found and the remainder */
func aop_read_suffix {
  para instr, chars, count;
  auto result;

  if (chars == []) {
    if (count == "*")
      return [instr, []];
    else if (count <= instr#)
      return [substr(instr, 1, instr#-count), substr(instr, instr#-count+1, instr#)];
    else
      return FAIL;
  }
  else {
    if (count == "*")
      result = chars_end(instr, chars);
    else
      result = chars_finite_end(instr, chars, count);
    if (result == [])
      return FAIL;
    return [ result[1], [result[2]] ];
  }
}

/* read_all attempts to match a string to a sort of regular expresion
   it returns either the string, or [] if it did not match */
func aop_read_all {
  para instr, chars;
  auto result;

  if (chars == [])
    return [instr, []];

  result = chars_finite_begin (instr, chars, instr#);

  if (result == [])
    return FAIL;
  
  /*strange behaviour, for some reason the old "read_all" does this backwards!
  return ["", [instr]]; */
  return [instr, []];
}

/* prefix checks a string for a literal prefix */
func aop_prefix {
  para instr, prefix;
  auto i;

  if (prefix# > instr#)
    return FAIL;

  for (i = 1; i <= prefix#; i++)
    if (prefix[i] != instr[i])
      return FAIL;

  return [prefix, [substr(instr, prefix#+1, instr#)]];
}

/* suffix checks a string for a literal suffix */
func aop_suffix {
  para instr, suffix;
  auto i;

  if (suffix# > instr#)
    return FAIL;

  for (i = 0; i < suffix#; i++)
    if (suffix[suffix# - i] != instr[instr# - i])
      return FAIL;

  return [suffix, [substr(instr, 1, instr#-suffix#)]];
}

func aop_literal_re {
  para instr, pattern;
  auto matches, i;
  matches = regmatch(pattern, instr);
  for (i = 1; i <= matches#; i++)
    if (matches[i] == instr)
      return [instr, []];
  return FAIL;
}

func aop_prefix_re {
  para instr, pattern;
  auto matches, result;
  matches = regmatch(pattern, instr);
  for (i = 1; i <= matches#; i++) {
    result = aop_prefix(instr, matches[i]);
    if (result != FAIL)
      return result;
  }
  return FAIL;
}

func aop_suffix_re {
  para instr, pattern;
  auto matches, result;
  matches = regmatch(pattern, instr);
  for (i = 1; i <= matches#; i++) {
    result = aop_suffix(instr, matches[i]);
    if (result != FAIL)
      return result;
  }
  return FAIL;
}

func aop_operation {
  para instr, op_name, op_value, ignore;
  auto result;

  switch (op_name) {
    
    case "prefix":
      result = aop_prefix(instr, op_value);
      break;

    case "suffix":
      result = aop_suffix(instr, op_value);
      break;

    case "pivot":
      result = aop_pivot(instr, op_value, ignore);
      break;

    case "rev_pivot":
      result = aop_pivot_rev(instr, op_value, ignore);
      break;

    case "split":
      result = aop_split(instr, op_value, ignore);
      break;

    case "read_prefix":
      if (type(op_value) != "list" || op_value# < 2)
        return ["badop"];
      result = aop_read_prefix(instr, op_value[1], op_value[2]);
      break;

    case "read_suffix":
      if (type(op_value) != "list" || op_value# < 2)
        return ["badop"];
      result = aop_read_suffix(instr, op_value[1], op_value[2]);
      break;

    case "read_all":
      result = aop_read_all(instr, op_value);
      break;

    case "literal":
      if (instr != op_value)
        result = FAIL;
      else
        result = [instr, []];
      break;

    case "literal_re":
      result = aop_literal_re(instr, op_value);
      break;

    case "prefix_re":
      result = aop_prefix_re(instr, op_value);
      break;

    case "suffix_re":
      result = aop_suffix_re(instr, op_value);
      break;

    default:
      return ["badop"];
  }

  return result;
}

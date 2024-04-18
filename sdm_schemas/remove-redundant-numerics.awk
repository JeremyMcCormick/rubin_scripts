# Initialize the list of eligible Felis types and their standard Felis-assigned MySQL
# equivalents.  We will remove all the (pointless) "type overrides" to that type.
BEGIN {
  mysql_types["double"] = "DOUBLE";
  mysql_types["float"]  = "FLOAT";
  mysql_types["long"]   = "BIGINT";
  mysql_types["int"]    = "INTEGER";
}

# By default, every input line will be output.
# The remainder of the logic determines which lines, if any, to suppress.
{ printit = 1 }

# If the datatype is one of the eligible ones, remember it.
/^    datatype: / {
  if ( $2 in mysql_types ) { type = $2 } else { type = "" }
}

# If there is an override (which must follow the "datatype:" line), AND
# the current datatype is one of the eligible ones, AND if the override
# is to the standard MySQL equivalent, suppress the override.
/^    mysql:datatype: / {
  if ( type != "" && $2 == mysql_types[type] ) { printit = 0 }; 
  type = "";
}

# Copy each line to the output verbatim unless it is to be suppressed.
{ if ( printit == 1 ) print }

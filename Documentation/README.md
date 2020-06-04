# Jolie Syntax

```jolie
include "file.iol"

/* 
 * A multi-line
 * comment
 */

inputPort SomeLogger {
Location: MyLocation
Protocol: MyProtocol
Aggregates: SomeService // This is a comment
}

main
{
	readFile@File( {
		filename = "note.json"
		format = "json"
	} )( data )
}
```

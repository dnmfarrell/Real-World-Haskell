Chapter 1
---------
* ghci repl
* the prelude is the haskell 98 standard prelude
* :module loads other modules; :module + Data.Ratio
* integers can be arbitrarily large (libgmp)
* infix operators like minus may need to be enclosed in parentheses to remove parser ambiguity
* True && False. Numbers are not booleans
* Not equals is /= ("≠")
* Operator precedence is scored from 1 to 9 (highest)
* Operator associativity (evaluation order) can be left (+) or right (^)
* Lists are defined with square brackets
* All elements of a list must be of the same type
* Numbers can be enumerated with ".." (like Perl's range operator)
* Concatenate lists with ++
* The construct ("cons") operator : prepends an element to the front of a list (0 : [1,2,3])
* Chars are single quoted characters
* Strings are double quoted and respect escape characters like \t and \n
* Strings are syntactic sugar for lists of chars
* ghc supports source files to be written in utf-8
* Multiline strings can be written using starting and ending backslashes
* Unicode characters can be typed with numeric escapes beginning with backslash
* The zero width escape \& can be used to delimit numeric escapes
* The empty string "" is a synonym for []
* List operators concat ++ and cons : can be used with strings
* ghci stores the result of the last expression evaluted in the variable it
* [Char] is another name for the String type
* Num a => a is the integer type? "its type is numeric"
* Use % to construct a rational number: 11 % 29
* Integral a => Ratio a is the ratio type?

https://www.haskell.org/tutorial/numbers.html
 Explains that Num is the parent class. It appears Haskell interprets the output of basic arithmetic operators (which apply to all Num types) as Num, not as Integer as described in the book.

 * :? prints the help command in ghci
 * : repeats the last command

Chapter 4
---------
* The `do` keyword declares block of actions with side effects.
* Use `let` without `in` to declare new variables in a do block
* The `id` function returns its argument unchanged
* The `getArgs` function returns the program's args
* The `<-` is the equivalent of assignment inside a do block
* `ghc --make <filename>` compiles to binary
* `break` splits a list into 2 parts, returning a pair
* Data.List's `isPrefixOf` `isInfixOf` and `isSuffixOf` can be used to match lists with each other
* The `init` function returns all but the last element of a list
* Partial functions only have return values defined for a subset of valid inputs
* Total functions return valid results over the entire range of valid inputs
* `++` is the append function
* `and`, `or`, `any` and `all` are list boolean functions
* `zipWith` takes a function and 2 lists, calling the function with an element from each list
* haskell has numbered variants for list functions accepting more than 2 arguments; e.g. `zip3` accepts 3 lists and `zip7` accepts 7
* `unlines` joins a list of strings with newlines, also appending a newline to the end of the end of the list:

    unlines ["foo", "bar"]
    "foo\nbar\n"

* Anonymous functions are defined with `\` (as in lamba λ) followed by the parameters and `->` to the function body
* Anonymous functions can only have one clause (you can use `case` to provide additional pattern matching)
* Use `seq a b` to force strict evaluation of a then b (e.g. `transpose.hs` uses seq to force readFile to close filehandle so the file can be written to)
* An infix `$` causes the arguments to the right to be evaluated first

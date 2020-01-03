Chapter 3
---------
* Define new data types using the `data` keyword assigning a data constructor to a type name
* type constructor is another term for data constructor
* New types and data constructors can have the same name; the evaluation context can unambiguously detect one from the other
* The `type` keyword introduces a type synonym (like C's `typedef`)
* Type synonyms are used to clarify code and programmer intention
* Type synonyms can declare new composite types (e.g. a tuple of existing types)
* An algebraic data type can have more than one value constructor (e.g. Bool)
* The multiple value constructors of a type are called "alternatives" or "cases"
* Wild cards (`_`) can be used in pattern matching to indicate we won't use the matched element
* When writing a series of patterns be sure to cover all of a type's constructors
* Record syntax can be used to declare types and their field names
* Record syntax is especially useful for types with many fields
* This pattern only matches if the list contains 2 list constructors: `(_:_:_)` (ie it is at least 2 elements long)
* The `let` keyword defines a local variable in the body of a function:

    let foo = 1
    in ...

* let bound variables can be used both within the block of declarations and the expression which follows `in`
* The `where` keyword is another way to define local variables that apply to the expression that precedes it
* The `map` function accepts a function and a list, calling the function once for each element of the list
* variables declared outside of function scope are ~globally~ file scoped
* the "offside rule" allows properly nested Haskell code to avoid using curly braces and semicolons
* The `case` keyword permits pattern matching within an expression:

    -- if maybe is Just, return it else return the defautValue
    fromMaybe defaultValue maybe =
        case maybe of
          Nothing     -> defaultValue
          Just value  -> value

* Guards `|` augment pattern matching with logical tests:

    len (x:xs)
      | null xs = 1
      | otherwise 1 + len xs

? Why provide the data constructor name in pattern matching ?
? the "durian" example does not work:

    fromList [MyJust True, MyNothing, MyJust False]

    <interactive>:86:1: error:
        Variable not in scope: fromList :: [Perhaps Bool] -> t

? Why can a function accepting Fractional types be called with an integer? Is there no type check?

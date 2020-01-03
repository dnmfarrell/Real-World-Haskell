Chapter 2
---------
* static types means the compiler knows the type of every value at compile time
* Typeclasses are Haskell's way of providing a kind of dynamic typing
* The Int type is for fixed width 32/64 bit integers
* An Integer type is unbounded, but slower than Int
* Double is faster than Float and more precise
* A Type Signature is double colon followed by a type: ":: Char"
* The compare function accepts 2 numbers and returns an "Ordering" type
* function application has higher precedence than operators
* Lists are polymorphic because they can contain any type
* We use a type variable which begins with a lowercase letter as a placeholder
* (that's ^ why type names must begin with an Uppercase letter)
* List members must all be of the same type
* Tuple members can be of different types, but Tuples are fixed-width
* () is a special type, a Tuple of zero elements called "unit" (similar to void in C)
* Tuples of more than a few elements are rarely used, as they are unwieldy
* take returns the first n elements of a list
* drop returns all but the first n elements of a list
* fst and snd return the first and second element of a pair
* haskell doesn't have a return keyword as a function is a single expression
* haskell *does* have a return function though
* the null function checks for an empty list
* Indentation continues an existing function instead of starting a new one
* Haskell lazily evaluates all expressions, include function arguments
* A thunk is a deferred expression

? why is myDrop.hs inferred type signature "myDrop :: (Ord t, Num t) => t -> [a] -> [a]"
A "=>" is a typeclass constraint, meaning t could be either of the preceding types
  Is (Ord t, Num t) a tagged union ("datatype") then?


Exercises
---------
1. last:
 - returns the last element from a list
 - it cannot handle an empty list
 - it would never return if provided an infinite list

source:

```haskell
-- | Extract the last element of a list, which must be finite and non-empty.
last                    :: [a] -> a
#if defined(USE_REPORT_PRELUDE)
-- As defined in the Haskell Report
last [x]                =  x
last (_:xs)             =  last xs
last []                 =  errorEmptyList "last"
#else
-- A more efficient implementation
-- Use foldl to make last a good consumer.
-- This will compile to good code for the actual GHC.List.last.
-- (At least as long it is eta-expaned, otherwise it does not, #10260.)
last xs = foldl (\_ x -> x) lastError xs
{-# INLINE last #-}
-- The inline pragma is required to make GHC remember the implementation via
-- foldl.
lastError :: a
lastError = errorEmptyList "last"
#endif
```

Chapter 5
---------
* in ghci `:reload` imports the last library imported with `:load`
* Module names must begin with capital letters
* Module names must match their source file base name
* Data type constructors can be exported without their value constructors as abstract types
* The -c option tells ghc to only generate object code
* The period is an infix function composition operator used to take the result from the function on the right and feed it to the function on its left
* `replicate` returns a list of elements repeated n times
* Cabal is a packaging tool
* A .cabal file defines the distribution metadata
* With `Build-Type: Simple` cabal will use the Distribution.Simple module and no `Setup.hs` file is needed
* Typical install commands:

    cabal configure --prefix=$HOME --user
    cabal build
    cabal install
    cabal clean

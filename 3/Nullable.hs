-- The book uses Just and Nothing but they are already defined in Prelude
data Perhaps a = MyJust a
               | MyNothing
               deriving (Show)

someBool = MyJust True
someString = MyJust "something"

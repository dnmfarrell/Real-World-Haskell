-- silly non-recursive solution to return the last but one element of a list
lastButOneRev :: [a] -> a
lastButOneRev xs =  head (tail (reverse xs))

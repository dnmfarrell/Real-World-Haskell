-- Write a function splitWith that acts similarly to words, but takes a
-- predicate and a list of any type, and splits its input list on every element
-- for which the predicate returns False.
splitWith :: (a -> Bool) -> [a] -> [[a]]
splitWith f []     = []
splitWith f (x:xs)
  | f x            = [[x]] ++ splitWith f xs
  | otherwise      = splitWith f xs

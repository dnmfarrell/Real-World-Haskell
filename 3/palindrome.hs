pal :: [a] -> [a]
pal []     = []
pal (x:xs) = (x:xs) ++ (reverse (x:xs))

isPal :: (Eq a) => [a] -> Bool
isPal xs = xs == reverse xs

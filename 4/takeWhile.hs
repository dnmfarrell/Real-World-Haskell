takeWhileRec :: (a -> Bool) -> [a] -> [a]
takeWhileRec f []     = []
takeWhileRec f (x:xs) | f x       = x : (takeWhileRec f xs)
                      | otherwise = []

takeWhileFoldr :: (a -> Bool) -> [a] -> [a]
takeWhileFoldr f xs = foldr step [] xs
  where step x acc | f x       = x : acc
                   | otherwise = []

takeWhileFoldl :: (a -> Bool) -> [a] -> [a]
takeWhileFoldl f xs = foldl (\acc x -> if f x then x:acc else []) [] (reverse xs)

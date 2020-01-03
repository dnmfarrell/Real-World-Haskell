concatFoldr :: [[a]] -> [a]
concatFoldr xs = foldr step [] xs
  where step xs ys = xs ++ ys

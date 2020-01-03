len :: Num t => [a] -> t
len []     = 0
len (_:xs) = 1 + len xs

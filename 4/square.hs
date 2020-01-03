square :: [Double] -> [Double]

square (x:xs) = x*x : square xs
square []     = []

square2 xs = map squareOne xs
    where squareOne x = x * x

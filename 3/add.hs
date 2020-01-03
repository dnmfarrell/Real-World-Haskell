myNot True = False
myNot False = True

sumList (x:xs) = x + sumList xs
sumlist []     = 0

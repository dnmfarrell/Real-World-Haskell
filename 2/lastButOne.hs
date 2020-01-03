-- n.b. avoids calculating the length of the list
lastButOne :: [a] -> a
lastButOne (x:(y:ys)) = if null ys then x else lastButOne (y:ys)
lastButOne [x]        = error ("lastButOne: list must have 2 or more elements")
lastButOne []         = error ("lastButOne: list cannot be empty")

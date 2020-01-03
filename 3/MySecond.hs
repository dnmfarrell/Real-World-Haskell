safeSecond :: [a] -> Maybe a

safeSecond [] = Nothing
safeSecond xs = if null (tail xs)
                then Nothing
                else Just (head (tail xs))

tidySecond (_:x:_) = Just x
tidySecond _       = Nothing

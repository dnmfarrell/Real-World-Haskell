mean :: Fractional a => [a] -> a
mean []     = error "list is empty"
mean (x:xs) = sum (x:xs) / (fromIntegral(length (x:xs)))

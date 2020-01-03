-- using a guard enables three clear patterns instead of a single pattern
-- and an if/else
niceDrop n xs | n <= 0 = xs
niceDrop _ []          = []
niceDrop n (_:xs)      = niceDrop (n - 1) xs

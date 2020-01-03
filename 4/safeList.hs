import Data.Maybe

safeHead :: [a] -> Maybe a
safeHead (x:_) = Just x
safeHead []    = Nothing

safeTail :: [a] -> Maybe [a]
safeTail (x:xs) = Just xs
safeTail []     = Nothing

safeLast :: [a] -> Maybe a
safeLast [x,y]  = Just y
safeLast (_:xs) = safeLast xs
safeLast []     = Nothing

safeInit :: [a] -> Maybe [a]
safeInit []     = Nothing
safeInit (x:xs) = Just (safeInit' (x:xs))
  where safeInit' :: [a] -> [a]
        safeInit' (x:xs)
          | null xs   = []
          | otherwise = [x] ++ (safeInit' xs)
        safeInit' [] = []


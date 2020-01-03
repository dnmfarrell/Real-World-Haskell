import Data.Char
anyFoldr :: Foldable t => (a -> Bool) -> t a -> Bool
anyFoldr f xs = foldr (\x acc -> if acc then acc else f x) False xs

anyFoldl :: Foldable t => (a -> Bool) -> t a -> Bool
anyFoldl f xs = foldl (\acc x -> if acc then acc else f x) False xs

-- cycle doesn't seem implementable as a fold as the list
-- inside the function is a local copy
-- cycleFoldr :: [a] -> [a]
-- cycleFoldr [] = error "list must have at least one element"
-- cycleFoldr xs = foldr (\x acc -> xs ++ [x]) [] xs
-- except tonyo did it!
cycleFoldr xs = foldr (\_ c -> xs ++ c) [] [1..]

-- no need to reverse the list with foldr
wordsFoldl :: [Char] -> [[Char]]
wordsFoldl xs = foldl step [] xs
  where step acc x = if isSpace x then acc ++ [[]]
                     else case reverse acc of
                              (y:ys) -> reverse ([y ++ [x]] ++ ys)
                              _ -> [[x]]

wordsFoldr :: [Char] -> [[Char]]
wordsFoldr xs = foldr step [] xs
  where step x acc = if isSpace x then
                       if not (null (head acc)) then [[]] ++ acc else acc
                     else case acc of
                              (y:ys) -> ([x:y] ++ ys)
                              _ -> [[x]]


unlinesFoldr :: [[Char]] -> [Char]
unlinesFoldr xs = foldr (\x acc -> x ++ ['\n'] ++ acc) [] xs

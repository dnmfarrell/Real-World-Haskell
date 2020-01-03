import Data.Char (digitToInt) -- we'll need ord short

asInt :: String -> Int
asInt xs = loop 0 xs

loop :: Int -> String -> Int
loop acc [] = acc
loop acc (x:xs) = let acc' = acc * 10 + digitToInt x
                  in loop acc' xs

asInt_fold :: String -> Int
asInt_fold []       = error "string did not contain any numbers"
asInt_fold ['-']    = error "string did not contain any numbers"
asInt_fold ('-':xs) = -1 * asInt_fold xs
asInt_fold xs       = foldl (\acc x -> acc * 10 + digitToInt x) 0 xs

type ErrorMessage = String
asInt_either :: String -> Either ErrorMessage Int
asInt_either []       = Left "string did not contain any numbers" :: Either ErrorMessage Int
asInt_either ['-']    = Left "string did not contain any numbers" :: Either ErrorMessage Int
asInt_either ('-':xs) = Right (-1 * asInt_fold xs) :: Either ErrorMessage Int
asInt_either xs       = Right (foldl (\acc x -> acc * 10 + digitToInt x) 0 xs) :: Either ErrorMessage Int

module ParseJSON (parseJSON) where

atomStart = "\"tfn0123456789-[{"

data JValue = JString String
            | JDouble Double
            | JInt Int
            | JBool Bool
            | JNull
            | JObject [(String, JValue)]
            | JArray [JValue]
              deriving (Eq, Ord, Show)

parseJSON :: String -> JValue
parseJSON [] = error "Cannot parse an empty string"
parseJSON js = if eof then fst rs
               else error $ "Encountered garbage after JSON object: " ++ (snd rs)
  where rs  = parseNext js atomStart
        eof = null $ skipWhitespace (snd rs)

parseNext :: String -> String -> (JValue, String)
parseNext js allow
  | not (any (x==) allow) = error $ "Expected one of: "++allow++" got: "++[x]
  | otherwise = case x of
  '"'  -> (newJString v, drop 2 ys)
  't'  -> (newJBool v, ys)
  'f'  -> (newJBool v, ys)
  'n'  -> (newJNull v, ys)
  '0'  -> (newJNumber v, ys)
  '1'  -> (newJNumber v, ys)
  '2'  -> (newJNumber v, ys)
  '3'  -> (newJNumber v, ys)
  '4'  -> (newJNumber v, ys)
  '5'  -> (newJNumber v, ys)
  '6'  -> (newJNumber v, ys)
  '7'  -> (newJNumber v, ys)
  '8'  -> (newJNumber v, ys)
  '9'  -> (newJNumber v, ys)
  '-'  -> (newJNumber v, ys)
  '['  -> (JArray (fst ar), snd ar)
  '{'  -> (JObject (fst ob), snd ob)
  _    -> error $ "Unrecognized character: " ++ [x]
  where xs = skipWhitespace js
        x  = head xs
        v  = takeValue xs
        ys = drop (length v) xs
        ar = newJArray ([], skipWhitespace $ tail xs)
        ob = newJObject ([], skipWhitespace $ tail xs)

takeValue :: String -> String
takeValue ('"':xs) = takeStrWhile xs
  where takeStrWhile [] = error "Unterminated string"
        takeStrWhile (x:xs)
          | x == '"'  = []
          | x == '\\' && not (null xs) = case head xs of
                          '"' -> x: (head xs :(takeStrWhile (tail xs)))
                          _   -> x: (takeStrWhile xs)
          | otherwise = x: (takeStrWhile xs)
takeValue xs = takeWhile (\j -> not (any (j==) ("\n\t\r ,]}"))) xs

takeWhitespace :: String -> String
takeWhitespace = takeWhile (\j -> any (j==) "\n\t\r ")

skipWhitespace:: String -> String
skipWhitespace = drop =<< length . takeWhitespace

newJString :: String -> JValue
newJString js = JString js

newJBool :: String -> JValue
newJBool "true"  = JBool True
newJBool "false" = JBool False
newJBool _       = error "Expecting 'true' or 'false'"

newJNull :: String -> JValue
newJNull "null"  = JNull
newJNull _       = error "Expecting 'null'"

newJNumber :: String -> JValue
newJNumber js
  | hasDot || hasPlus || hasE = JDouble $ (read js::Double)
  | otherwise                 = JInt $ (read js::Int)
  where hasDot  = any ('.'==) js
        hasPlus = any ('+'==) js
        hasE    = any ('e'==) js || any ('E'==) js

newJArray :: ([JValue], String) -> ([JValue], String)
newJArray (xs, j:js)
  | j == ']'  = (xs, js)
  | j == ','  = if null xs then  error "Expected an element or ] but found: ,"
                else if any (n==) ",]" then  error $ "Expected element but found: " ++ [n]
                else newJArray (xs, ns)
  | otherwise = if any (t==) ",]" then newJArray (xs ++ [fst v], ts)
                else error $ "Expected one of: ,] but found: " ++ [t]
  where ns = skipWhitespace js
        n  = head ns
        v  = parseNext (j:js) atomStart
        ts = skipWhitespace $ snd v
        t  = head ts

newJObject :: ([(String, JValue)], String) -> ([(String, JValue)], String)
newJObject (xs, j:js)
  | j == '}'  = (xs, js)
  | j == ','  = if null xs then error "Expected a pair or } but found: ,"
                else if any (n==) ",}" then error $ "Expected an element but found: " ++ [n]
                else newJObject (xs, ns)
  | otherwise = if any (t==) ",}" then newJObject (xs ++ [fst p], snd p)
                else error $ "Expected on of: ,} but found: " ++ [t]
  where ns = skipWhitespace js
        n  = head ns
        p  = newJPair (j:js)
        ts = skipWhitespace $ snd p
        t  = head ts

newJPair :: String -> ((String, JValue), String)
newJPair [] = error "Expected a key:pair but got an empty string"
newJPair js = if head ss == ':' then ((k1, v1), v2)
              else error $ "Expected ':' but got " ++ [head ss]
  where k  = parseNext (skipWhitespace js) "\""
        k1 = case getString $ fst k of Just s -> s
        ss = skipWhitespace $ snd k
        v  = parseNext (tail ss) atomStart
        v1 = fst v
        v2 = skipWhitespace $ snd v
        getString (JString s) = Just s

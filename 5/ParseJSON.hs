module ParseJSON where

data JValue = JString String
            | JDouble Double
            | JInt Int
            | JBool Bool
            | JNull
            | JObject [(String, JValue)]
            | JArray [JValue]
              deriving (Eq, Ord, Show)

whitespace = "\n\t "
atomStart = "\"tfn0123456789-[{"

parseJSON :: String -> JValue
parseJSON [] = error "Cannot parse an empty string"
parseJSON js = if null $ snd rs then fst rs
               else error $ "Encountered garbage after JSON object: " ++ (snd rs)
  where rs = parseNext js "[{"

parseNext :: String -> String -> (JValue, String)
parseNext js allow
  | not (any (x==) allow) = error $ "Expected one of: "++allow++" got: "++[x]
  | otherwise = case x of
  '"'  -> (newJString ss, sr)
  't'  -> (newJBool vs, vr)
  'f'  -> (newJBool vs, vr)
  'n'  -> (newJNull vs, vr)
  '0'  -> (newJNumber vs, vr)
  '1'  -> (newJNumber vs, vr)
  '2'  -> (newJNumber vs, vr)
  '3'  -> (newJNumber vs, vr)
  '4'  -> (newJNumber vs, vr)
  '5'  -> (newJNumber vs, vr)
  '6'  -> (newJNumber vs, vr)
  '7'  -> (newJNumber vs, vr)
  '8'  -> (newJNumber vs, vr)
  '9'  -> (newJNumber vs, vr)
  '-'  -> (newJNumber vs, vr)
  '['  -> (JArray (fst ar), snd ar)
  '{'  -> (JObject (fst ob), snd ob)
  _    -> error $ "Unrecognized character: " ++ [x]
  where xs = skipWhitespace js
        x  = head xs
        t  = tail xs
        vs = takeValue xs
        vr = drop (length vs) xs
        ss = takeString xs
        sr = drop ((length ss) + 2) xs
        ar = newJArray ([], skipWhitespace t)
        ob = newJObject ([], skipWhitespace t)

takeValue :: String -> String
takeValue = takeWhile (\j -> not (any (j==) (whitespace ++ ",]}")))

takeString :: String -> String
takeString ('"':xs) = takeStrWhile xs
  where takeStrWhile [] = error "Unterminated string"
        takeStrWhile (x:xs)
          | x == '"'  = []
          | x == '\\' && not (null xs) = case head xs of
                          '"' -> x: (head xs :(takeStrWhile (tail xs)))
                          _   -> x: (takeStrWhile xs)
          | otherwise = x: (takeStrWhile xs)
takeString xs = error "Strings must begin with \""

takeWhitespace :: String -> String
takeWhitespace = takeWhile (\j -> any (j==) whitespace)

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
newJArray (xs, ']':js) = (xs, js)
newJArray (xs, ',':js) 
  | any (n==) ",]" = error $ "Expected an element but found: " ++ [n]
  | otherwise      = newJArray (xs, ns)
  where ns = skipWhitespace js
        n  = head ns
newJArray (xs, js) = newJArray (xs ++ [fst nv], skipWhitespace $ snd nv)
  where nv = parseNext js atomStart

newJObject :: ([(String, JValue)], String) -> ([(String, JValue)], String)
newJObject (xs, '}':js) = (xs, js)
newJObject (xs, ',':js)
  | any (n==) ",}" = error $ "Expected an element but found: " ++ [n]
  | otherwise      = newJObject (xs, ns)
  where ns = skipWhitespace js
        n  = head ns
        kv = newJPair ns
newJObject (xs, js) = newJObject (xs ++ [fst kv], snd kv)
  where ns = skipWhitespace js
        n  = head ns
        kv = newJPair ns

newJPair :: String -> ((String, JValue), String)
newJPair [] = error "Expected a key:pair but got an empty string"
newJPair js = if head ss == ':' then ((k1, v1), v2)
                else error $ "Expected ':' but got " ++ [head ss]
  where xs = skipWhitespace js
        k1 = takeString xs
        k2 = drop ((length k1) + 2) js
        ss = skipWhitespace k2
        v  = parseNext (tail ss) atomStart
        v1 = fst v
        v2 = skipWhitespace $ snd v

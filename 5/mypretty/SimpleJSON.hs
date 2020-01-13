module SimpleJSON
  ( JValue(..)
  , getString
  , getInt
  , getDouble
  , getBool
  , getObject
  , getArray
  , isNull
  , parseJSON
  ) where

whitespace = "\n\t "
atomStart = "\"tfn0123456789-["

data JValue = JString String
            | JDouble Double
            | JInt Int
            | JBool Bool
            | JNull
            | JObject [(String, JValue)]
            | JArray [JValue]
              deriving (Eq, Ord, Show)

getString :: JValue -> Maybe String
getString (JString s) = Just s
getString _           = Nothing

getInt :: JValue -> Maybe Int
getInt (JInt n) = Just n
getInt _        = Nothing

getDouble :: JValue -> Maybe Double
getDouble (JDouble n) = Just n
getDouble _           = Nothing

getBool :: JValue -> Maybe Bool
getBool (JBool b) = Just b
getBool _         = Nothing

getObject :: JValue -> Maybe [(String, JValue)]
getObject (JObject o) = Just o
getObject _           = Nothing

getArray :: JValue -> Maybe [JValue]
getArray (JArray a) = Just a
getArray _          = Nothing

isNull :: JValue -> Bool
isNull v = v == JNull

parseJSON :: String -> JValue
parseJSON [] = error "Cannot parse an empty string"
parseJSON js = fst $ parseNext js "[{"

parseNext :: String -> String -> (JValue, String)
parseNext js allow
  | not (any (x==) allow) = error $ "Expected one of: "++allow++" got: "++[x]
  | otherwise = case x of
  '"'  -> (parseJString ss, sr)
  't'  -> (parseJBool vs, vr)
  'f'  -> (parseJBool vs, vr)
  'n'  -> (parseJNull vs, vr)
  '0'  -> (parseJNumber vs, vr)
  '1'  -> (parseJNumber vs, vr)
  '2'  -> (parseJNumber vs, vr)
  '3'  -> (parseJNumber vs, vr)
  '4'  -> (parseJNumber vs, vr)
  '5'  -> (parseJNumber vs, vr)
  '6'  -> (parseJNumber vs, vr)
  '7'  -> (parseJNumber vs, vr)
  '8'  -> (parseJNumber vs, vr)
  '9'  -> (parseJNumber vs, vr)
  '-'  -> (parseJNumber vs, vr)
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
        ar = parseJArray ([], skipWhitespace t)
        ob = parseJObject ([], skipWhitespace t)

skipWhitespace:: String -> String
skipWhitespace = drop =<< length . takeWhitespace

parseJString :: String -> JValue
parseJString js = JString js

parseJBool :: String -> JValue
parseJBool "true"  = JBool True
parseJBool "false" = JBool False
parseJBool _       = error "Expecting 'true' or 'false'"

parseJNull :: String -> JValue
parseJNull "null"  = JNull
parseJNull _       = error "Expecting 'null'"

parseJNumber :: String -> JValue
parseJNumber js
  | any ('.'==) js = JDouble $ (read js::Double)
  | otherwise      = JInt $ (read js::Int)

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

takeWhitespace :: String -> String
takeWhitespace = takeWhile (\j -> any (j==) whitespace)

parseJArray :: ([JValue], String) -> ([JValue], String)
parseJArray (xs, ']':js) = (xs, js)
parseJArray (xs, ',':js) 
  | any (n==) ",]"  = error $ "Expected an element but found: " ++ [n]
  | otherwise = parseJArray (xs, ns)
  where ns = skipWhitespace js
        n  = head ns

parseJArray (xs, js) = parseJArray (xs ++ [nv1], nv2)
  where nv = parseNext js atomStart
        nv1= fst nv
        nv2= snd nv

parseJObject :: ([(String, JValue)], String) -> ([(String, JValue)], String)
parseJObject = undefined
--parseJObject (xs, '}':js) = (xs, js)
--parseJObject (xs, ',':js) 
--  | n == ','  = error "Encountered ',' but expected an element"
--  | otherwise = parseJObject (xs, ns)
--  where ns = skipWhitespace js
--        n  = head ns
--
--parseJObject (xs, js) = parseJObject (xs ++ [nv1], nv2)
--  where nv = parseNext js atomStart
--        nv1= fst nv
--        nv2= snd nv

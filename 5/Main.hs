module Main where

import SimpleJSON
import Prettify (pretty compact)
import PrettyJSON

main = print (compact (renderJValue (JNumber 1)))

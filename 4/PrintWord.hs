import System.Environment (getArgs)
import Data.Char

interactWith function inputFile outputFile = do
  input <- readFile inputFile
  writeFile outputFile (function input)

main = mainWith myFunction
  where mainWith function = do
          args <- getArgs
          case args of
            [input,output] -> interactWith function input output
            _ -> putStrLn "error: 2 args needed"

        myFunction = firstWords

firstWords xs = unlines (map (\x -> firstWord x) (lines xs))
firstWord xs = takeWhile (\x -> False == (isSpace x)) xs

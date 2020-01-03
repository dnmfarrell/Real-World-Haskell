import System.Environment (getArgs)

interactWith function file = do
  input <- readFile file
  -- avoid openFile: resource busy (file is locked)
  -- https://stackoverflow.com/a/2530948/1554448
  length input `seq` writeFile file $ function input

main = mainWith myFunction
  where mainWith function = do
          args <- getArgs
          case args of
            [file] -> interactWith function file
            _ -> putStrLn "error: 2 args needed"

        myFunction = (\x -> unlines (transpose x))

transpose :: String -> [String]
transpose xs = case (lines xs) of
                 [xs,ys] -> zipWith (\x y -> [x,y]) xs ys
                 _       -> error "did not receive 2 lines of input"

mingling :: String -> String -> String
mingling [] [] = []
mingling (x:xs) (y:ys) = x:y:mingling xs ys

main = do
  first <- getLine
  second <- getLine
  putStrLn $ mingling first second


main = do
  putStrLn "Please enter a Double:"
  intStr <- getLine
  let inpDouble = (read intStr) :: Double
  putStrLn ("Twice " ++ show inpDouble ++ " is " ++ show (inpDouble * 2))

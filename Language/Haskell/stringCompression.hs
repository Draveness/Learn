import Control.Monad (join)

compress :: String -> String
compress s = join $ map convert (partition s "")

convert :: String -> String
convert xs = head xs : (if length xs == 1 then "" else show (length xs))

partition :: String -> String -> [String]
partition ""     s  = [s]
partition s      "" =
  partition (tail s) [head s]
partition (x:xs) s  =
  let char = head s
  in if x == char
     then partition xs (x:s)
     else s : partition xs [x]

main = do
  s <- getLine
  putStrLn $ compress s

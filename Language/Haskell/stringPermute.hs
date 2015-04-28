import Control.Monad
permute :: String -> String
permute "" = ""
permute (x:y:ys) = y:x:permute ys

main = do
  n <- getLine
  forM_  [1..(read n :: Int)] (\a -> do
                                 string <- getLine
                                 putStrLn $ permute string
                             )

import Control.Monad (join)

width = 100
height = 63

drawLine :: [Int] -> [Int] -> [Char] 
drawLine mask x =
    [if elem c x then '1' else '_' | c <- mask]

drawMtx :: [[Int]] -> IO ()
drawMtx matrix =
    let mask = init $ [0..width]
    in  putStrLn $ unlines $ map (drawLine mask) matrix

initMtx :: [[Int]]
initMtx =
  let mid = (width + 1) `div` 2 - 1
      index = init [0..width]
      header = replicate 16 [mid]
      middle = map (\x -> [mid-x, mid+x]) [1..16]
  in header ++ middle

iterMtx :: Int -> Int -> [[Int]] -> [[Int]]
iterMtx 1 _      mtx = mtx
iterMtx n height mtx =
  let olderPart = take (4*height) mtx
      newHeader = replicate height $ last olderPart
      newMiddle = map (\x -> join $ map (\y -> [y-x,y+x]) $ head newHeader) [1..height]
      newMtx = newHeader ++ newMiddle
      newHeight = height `div` 2
  in olderPart ++ iterMtx (n-1) newHeight newMtx

recursiveTree :: Int -> [[Int]]
recursiveTree n =
  reverse . take height $ iterMtx n 8 initMtx ++ replicate 100 []

main = do
  n <- getLine
  drawMtx $ recursiveTree (read n :: Int)

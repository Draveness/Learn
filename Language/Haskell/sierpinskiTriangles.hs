width = 63
height = 32

drawLine mask x =
    [if elem c x then '1' else '_' | c <- mask]
 
drawMtx matrix =
    let mask = init $ [0..width]
    in  putStrLn $ unlines $ map (drawLine mask) matrix

initMtx = let middle = (width + 1) `div` 2 - 1
              index = init $ [0..height]
          in map (\x -> [middle-x..middle+x]) index


sierpinski n = if n <= 5
                 then drawMtx $ mergeMtx n height initMtx
                 else drawMtx $ replicate height []

mergeMtx 0 _      mtx = mtx
mergeMtx n h mtx =
  let half = h `div` 2
      header = take half mtx
      footer = reverse $ drop half mtx
      newFooter = reverse $ map (\(xs,ys) -> deleteElem xs ys) $ zip header footer
  in (mergeMtx (n-1) half $ header) ++ (mergeMtx (n-1) half $ newFooter)
     
deleteElem xs ys = filter (`notElem` xs) ys

main = do
  n <- getLine
  sierpinski (read n :: Int)

import Text.Printf
import Data.List (sortBy)
import GHC.Float (float2Double)

solve points = listDistance (convexHull (startPoint points) (sortPoints points) [])

type Point = (Int, Int)
type Vector = (Int, Int)

ex :: [(Int, Int)]
ex = [(1,1), (2,5), (3,3), (5,3), (3,2), (2,2)]

vector origin end =
  ((fst end - fst origin), (snd end - snd origin))

vectorLen :: Vector -> Float
vectorLen vector =
  ((fromIntegral (fst vector)) ** 2 + (fromIntegral (snd vector)) ** 2) ** 0.5

angle :: Point -> Point -> Point -> Double
angle origin start end =
  let startVec = vector origin start
      endVec = vector origin end
      startLen = vectorLen startVec
      endLen = vectorLen endVec
      vecProduct = fromIntegral $ (fst startVec) * (fst endVec) +
       (snd startVec) * (snd endVec)
      devidend = startLen * endLen
      intermidate = float2Double $ vecProduct /  devidend
  in acos intermidate

startPoint :: [Point] -> Point
startPoint points =
  foldr (\x acc -> if (snd acc) < (snd x) then acc else x) (head points) points

removeItem _ []                 = []
removeItem x (y:ys) | x == y    = removeItem x ys
                    | otherwise = y : removeItem x ys

sortPoints :: [Point] -> [Point]
sortPoints points =
  let start = startPoint points
      base = (fst start + 1, snd start)
      zipWithAngle = map (\point -> (point, angle start base point)) (removeItem start points)
  in start:(map (\(point, angle) -> point) $ sortBy sortFun zipWithAngle)

sortFun (_, a1) (_, a2) =
  if a1 < a2 then LT else GT

convexHull start []           state = reverse $ start:state
convexHull start sortedPoints state =
  if length state < 2
  then convexHull start (tail sortedPoints) $ (head sortedPoints):state
  else
    let current = head state
        previous = head $ tail state
        next = head sortedPoints
        degree = counterClockAngle current previous next
    in
     if degree >= pi
     then convexHull start (tail sortedPoints) $ next:state
     else convexHull start (tail sortedPoints) $ next:(tail state)
       

counterClockAngle origin start end =
  let angle1 = atan2 (fromIntegral (snd start - snd origin)) (fromIntegral (fst start - fst origin))
      angle2 = atan2 (fromIntegral (snd end - snd origin)) (fromIntegral (fst end - fst origin))
      ang = angle2 - angle1
  in proper ang

proper ang =
  if ang < 0
  then proper $ ang + 2 * pi
  else if ang >= 2 * pi
       then proper $ ang - 2 * pi
       else ang

distance :: Point -> Point -> Float
distance start end =
  (fromIntegral (fst start - fst end) ** 2 + fromIntegral (snd start - snd end) ** 2) ** 0.5

listDistance :: [Point] -> Float
listDistance (x:y:ys) = distance x y + listDistance (y:ys)
listDistance x        = 0.0

main :: IO ()
main = do
  n <- readLn :: IO Int
  content <- getContents
  let  
    points = map (\[x, y] -> (x, y)). map (map (read::String->Int)). map words. lines $ content
    ans = solve points
  printf "%.1f\n" ans

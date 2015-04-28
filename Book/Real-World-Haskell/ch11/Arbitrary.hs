class Arbitrary a where
  arbitrary :: Gen a

elements :: [a] -> Gen a
choose :: Random a => (a, a) -> Gen a
oneof :: [Gen a] -> Gen a

data Ternary = Yes
             | No
             | Unknown
             deriving (Eq, Show)

instance Arbitrary Ternary where
  arbitrary = elements [Yes, No, Unknown]

--instance Arbitrary Ternary where
--  arbitrary = do
--    n <- choose (0, 2) :: Gen Int
--    return $ case n of
--                  0 -> Yes
--                  1 -> No
--                  _ -> Unknown

instance (Arbitrary a, Arbitrary b) => Arbitrary (a, b) where
  arbitrary = do
    x <- arbitrary
    y <- arbitrary
    return (x, y)

instance Arbitrary Char where
  arbitrary = elements (['A'..'Z'] ++ ['a'..'z'] ++ " ~!@#$^&*()")

instance Arbitrary Doc where
  arbitrary = do
    n <- choose (1, 6) :: Gen Int
    case n of
         1 -> return Empty
         2 -> do x <- arbitrary
                 return (Char x)
         3 -> do x <- arbitrary
                 return (Text x)
         4 -> return Line
         5 -> do x <- arbitrary
                 y <- arbitrary
                 return (Concat x y)
         6 -> do x <- arbitrary
                 y <- arbitrary
                 return (Union x y)


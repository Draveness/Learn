data Doc = Empty
         | Char Char
         | Test String
         | Line
         | Concat Doc Doc
         | Union Doc Doc
         deriving (Show, Eq)

empty :: Doc
(<>)  :: Doc -> Doc -> Doc

fold :: (Doc -> Doc -> Doc) -> [Doc] -> Doc
fold f = foldr f empty

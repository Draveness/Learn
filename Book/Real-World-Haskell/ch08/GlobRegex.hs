module GlobRegex
       (
         globToRegex
       , matchesGlob
       ) where

import Text.Regex.Posix ((=~))

globToRegex :: String -> String
globToRegex cd = '^' : globToRegex' cs ++ "$"

globToRegex' :: String -> String
globToRegex' "" = ""
globToRegex' ('*':cs) = ".*" ++ globToRegex' cs
globToRegex' ('?':cs) = '.' : globToRegex' cs
globToRegex' ('[':'!':c:cs) = "[^" ++ c : charClass cs

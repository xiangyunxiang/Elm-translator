module Translator.Basic where

join :: String -> [String] -> String
join _ [] = ""
join a xs = foldr1 concat xs
    where concat b c = b ++ a ++ c

data Indent = Indent { num :: Int }

initIndent :: Indent
initIndent = Indent 0

addIndent :: Indent -> Indent
addIndent indent = Indent (num indent + 4)

reduceIndent :: Indent -> Indent
reduceIndent indent = Indent (num indent - 4)

generateIndent :: Indent -> String
generateIndent (Indent 0) = ""
generateIndent (Indent x) = " " ++ generateIndent (Indent $ x - 1)
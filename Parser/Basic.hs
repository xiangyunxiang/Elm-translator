module Parser.Basic where

import AST
import Lexer
import Text.Parsec

type Parser = Parsec [(SourcePos, Token)] ()

tokenP :: (Token -> Maybe a) -> Parser a
tokenP test = token show fst (test . snd)

symbol :: String -> Parser ()
symbol c = tokenP (\t -> case t of
    TSym s -> if s == c then Just () else Nothing
    _ -> Nothing)

keywords :: String -> Parser ()
keywords c = tokenP (\t -> case t of
    TKey s -> if s == c then Just () else Nothing
    _ -> Nothing)

module Parser.Import where

import AST
import Lexer
import Text.Parsec
import Parser.Basic (Parser, tokenP, symbol, keywords)

importP :: Parser Statement
importP = do
    _ <- keywords "import"
    lib <- libP
    _ <- symbol "("
    libfun <- libfunP
    _ <- symbol ")"
    return (Import lib libfun)

libP :: Parser Lib 
libP = do 
    first <- firstlibString
    remain <- many remainLibString
    return (Lib $ first:remain)

firstlibString :: Parser LibString 
firstlibString = tokenP 
        (\t -> case t of 
            (TType s) -> Just (LibString s)
            _ -> Nothing)

remainLibString :: Parser LibString
remainLibString = do
    _ <- symbol "."
    firstlibString

libfunP :: Parser LibFun 
libfunP = do 
    first <- firstLibFunString
    remain <- many remainLibFunString
    return (LibFun $ first:remain)

firstLibFunString :: Parser LibFunString 
firstLibFunString = tokenP 
        (\t -> case t of 
            (TName s) -> Just (LibFunString s)
            _ -> Nothing)

remainLibFunString :: Parser LibFunString
remainLibFunString = do
    _ <- symbol ","
    firstLibFunString

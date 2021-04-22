module Parser.EnumDef where
import AST
import Lexer
import Text.Parsec
import Parser.Basic ( Parser, tokenP, symbol, keywords )

enumDefP :: Parser Statement
enumDefP = do
    _ <- keywords "data"
    enumName <- enumNameP
    _ <- symbol "="
    firstDataType <- firstDataTypeP
    remainDataType <- many remainDataTypeP
    return (EnumDef enumName $ firstDataType:remainDataType)

enumNameP :: Parser EnumName
enumNameP = tokenP
            (\t -> case t of 
                (TType s) -> Just (EnumName s)
                _ -> Nothing)

typeNameP :: Parser TypeName
typeNameP = tokenP
            (\t -> case t of 
                (TType s) -> Just (TypeName s)
                _ -> Nothing)

argTypeP :: Parser ArgType
argTypeP = tokenP
            (\t -> case t of 
                (TType s) -> Just (ArgType s)
                _ -> Nothing)

firstDataTypeP :: Parser DataType
firstDataTypeP = do 
    typename <- typeNameP
    argTypes <- many argTypeP
    return (DataType typename argTypes)

remainDataTypeP :: Parser DataType
remainDataTypeP = do 
    _ <- symbol "|"
    typename <- typeNameP
    argTypes <- many argTypeP
    return (DataType typename argTypes)


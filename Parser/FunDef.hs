module Parser.FunDef where
import AST
import Lexer
import Text.Parsec
import Parser.Basic (Parser, tokenP, symbol, keywords)
import Parser.Expr (exprP)

functionP :: Parser Statement 
functionP = do 
    firstline <- funDeclP
    secondline <- funDefP
    return (Function firstline secondline)

funDeclP :: Parser FunDecl
funDeclP = do
    name <- funNameP
    _ <- symbol "::"
    first <- firstFunArgType
    remain <- many remainFunArgType
    return (FunDecl name $ first:remain)

firstFunArgType :: Parser FunArgType
firstFunArgType = do
    name <- funArgNameP
    param <- many funArgTypeParamP
    return (FunArgType name param)

funArgNameP :: Parser FunArgTypeName
funArgNameP = tokenP 
        (\t -> case t of 
            (TType s) -> Just (FunArgTypeName s)
            _ -> Nothing)

funArgTypeParamP :: Parser FunArgTypeParam
funArgTypeParamP = tokenP 
        (\t -> case t of 
            (TType s) -> Just (FunArgTypeParam s)
            _ -> Nothing)

remainFunArgType :: Parser FunArgType
remainFunArgType = do 
    _ <- symbol "->"
    firstFunArgType

funDefP :: Parser FunDef
funDefP = do 
    left <- funNameP
    args <- many funArgP
    _ <- symbol "="
    right <- exprP
    _ <- symbol ";"
    return (FunDef left args right)

funNameP :: Parser FunName
funNameP = tokenP 
        (\t -> case t of 
            (TName s) -> Just (FunName s)
            _ -> Nothing)

funArgP :: Parser FunArg
funArgP = tokenP
          (\t -> case t of 
            (TName s) -> Just (FunArg s)
            (TNum s) -> Just (FunArg s)
            (TStr s) -> Just (FunArg s)
            (TChar s) -> Just (FunArg [s])
            _ -> Nothing)

module Parser.Expr where

import AST
import Lexer
import Text.Parsec
import Parser.Basic (Parser, tokenP, symbol, keywords)

exprP :: Parser Expression 
exprP = caseP <|> ifP <|> termP

termP :: Parser Expression
termP = chainl1 factorP addopP

factorP :: Parser Expression
factorP = chainl1 nodeP multiopP

nodeP :: Parser Expression
nodeP = applicationP <|> atomP

atomP :: Parser Expression
atomP = variableP <|> literalP <|> parenP <|> listP


addopP :: Parser (Expression -> Expression -> Expression)
addopP = do { symbol "+"; return AddOp } <|> do { symbol "-"; return SubstractOp }

multiopP :: Parser (Expression -> Expression -> Expression)
multiopP = do { symbol "*"; return MultiplyOp } <|> do { symbol "/"; return DivisionOp }

caseP :: Parser Expression
caseP = do
    _ <- keywords "case"
    ex <- termP
    _ <- keywords "of"
    caseExpressions <- many $ try caseExpressionP
    return (Case ex caseExpressions)

ifP :: Parser Expression
ifP = do
    _ <- keywords "if"
    cond <- termP
    _ <- keywords "then"
    condTrue <- termP
    _ <- keywords "else"
    condFalse <- termP
    return (If cond condTrue condFalse)

caseExpressionP :: Parser CaseExpression
caseExpressionP = do
    term1 <- termP
    _ <- symbol "->"
    term2 <- termP
    _ <- symbol ";"
    return (CaseExpression term1 term2)

literalP :: Parser Expression
literalP = tokenP
          (\t -> case t of 
            (TNum s) -> Just (Literal (Integer s))
            (TStr s) -> Just (Literal (String s))
            _ -> Nothing)

variableP :: Parser Expression
variableP = tokenP
          (\t -> case t of 
            (TName s) -> Just (Variable s)
            (TType s) -> Just (Variable s)
            _ -> Nothing)

-- typeP :: Parser Expression
-- typeP = tokenP
--           (\t -> case t of 
--             (TType s) -> Just (Variable s)
--             _ -> Nothing)

applicationP :: Parser Expression
applicationP = foldl1 Application <$> many1 atomP

parenP :: Parser Expression
parenP = do
    _ <- symbol "("
    content <- termP
    _ <- symbol ")"
    return content

listP :: Parser Expression
listP = do
    _ <- symbol "["
    content <- many listElementP
    _ <- symbol "]"
    return (List content)

listElementP :: Parser Expression
listElementP = do
    skipMany $ symbol ","
    element <- termP
    return element
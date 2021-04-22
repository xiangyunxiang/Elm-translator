module Parser.Parser where

import Parser.FunDef (functionP)
import Parser.EnumDef (enumDefP)
import Parser.ModelDef (modelDefP)
import Parser.Import (importP)
import Parser.Basic ( Parser, tokenP, symbol ) 
import AST
import Lexer
import Text.Parsec


statementP :: Parser Statement
statementP = functionP <|> try modelDefP <|> enumDefP <|> importP

programP :: Parser Program
programP = Program <$> many statementP

-- parseProgram :: String -> Either ParseError [(SourcePos, Token)]
-- parseProgram input = parse (tokensL <* eof) "" input


parseProgram :: String -> Either ParseError Program
parseProgram input = do
    ts <- parse (tokensL <* eof) "" input
    parse programP "" ts

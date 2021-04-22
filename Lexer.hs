module Lexer where

import Text.Parsec
import qualified Control.Monad.Identity as Data.Functor.Identity
import Control.Monad.State ( State )
import Text.Parsec.Pos (SourcePos)


data Token = TKey String | TName String | TSym String | TNum String | TType String | TStr String | TChar Char | TComment deriving Show 

type Lexer = Parsec String ()

stringL :: Lexer Token
stringL = TStr <$> str
    where str = char '\"' *> many alphaNum <* char '\"'

charL :: Lexer Token
charL = TChar <$> ch
    where ch = char '\'' *> alphaNum <* char '\''

keyL :: Lexer Token
keyL = TKey <$> keywords
    where keywords = string "data" <|> string "case" <|> string "of" <|> string "if" <|> string "then" <|> string "else"

nameL :: Lexer Token
nameL = TName <$> lowerName
    where lowerName = ((:) <$> lower) <*> many (alphaNum <|> char '_')

typeL :: Lexer Token
typeL = TType <$> upperName
    where upperName = try (string "()") <|> ((:) <$> upper) <*> many (alphaNum <|> char '_')

numL :: Lexer Token
numL = TNum <$> (((:) <$> digit) <*> many digit)

symL :: Lexer Token
symL = TSym <$> (string "::" <|> try (string "->") <|> (choice . map (string . (: [])) $ "=+-*/|{},().;[]"))

commentL :: Lexer Token
commentL = do string "--" ; manyTill anyChar ((endOfLine >> return ()) <|> eof) ; return TComment

importL :: Lexer Token
importL = do string "import" ; manyTill anyChar ((endOfLine >> return ()) <|> eof) ; return TComment

tokensL :: Lexer [(SourcePos, Token)]
tokensL = do
    spaces 
    ts <- many (((,) <$> getPosition) <*> tokenP)
    return $ filter (\(sp, t) -> case t of
                                 TComment -> False
                                 _ -> True) ts
    where tokenP = (try commentL <|> try importL <|> try keyL <|> typeL <|> nameL <|> symL <|> numL <|> stringL <|> charL) <* spaces
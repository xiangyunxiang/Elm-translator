module Parser.ModelDef where
import AST
import Lexer
import Text.Parsec
import Parser.Basic ( Parser, tokenP, symbol, keywords )

modelDefP :: Parser Statement 
modelDefP = do
    _ <- keywords "data"
    modelName <- modelNameP
    _ <- symbol "="
    modelType <- modelTypeP
    modelProperty <- modelPropertyP
    return (ModelDef modelName modelType modelProperty)

modelNameP :: Parser ModelName
modelNameP = tokenP
            (\t -> case t of 
                (TType s) -> Just (ModelName s)
                _ -> Nothing)

modelTypeP :: Parser ModelType
modelTypeP = tokenP
            (\t -> case t of 
                (TType s) -> Just (ModelType s)
                _ -> Nothing)

modelPropertyP :: Parser ModelProperty
modelPropertyP = do
    _ <- symbol "{"
    firstproperty <- firstpropertyP
    remainproperty <- many remainpropertyP
    _ <- symbol "}"
    return (ModelProperty $ firstproperty:remainproperty)

propertyNameP :: Parser PropertyName
propertyNameP = tokenP
            (\t -> case t of 
                (TName s) -> Just (PropertyName s)
                _ -> Nothing)

propertyTypeP :: Parser PropertyType
propertyTypeP = tokenP
            (\t -> case t of 
                (TType s) -> Just (PropertyType s)
                _ -> Nothing)

firstpropertyP :: Parser Property
firstpropertyP = do
    propertyName <- propertyNameP
    _ <- symbol "::"
    propertyType <- propertyTypeP
    return (Property propertyName propertyType)

remainpropertyP :: Parser Property
remainpropertyP = do
    _ <- symbol ","
    property <- firstpropertyP
    return property




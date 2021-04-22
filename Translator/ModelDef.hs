module Translator.ModelDef where
import AST
import Translator.Basic

translateModelDef :: Statement -> String
translateModelDef (ModelDef modelName modelType modelProperty) = "def " ++ getModelType modelType ++ "(" ++ getCommaPropertyList modelProperty ++ "):\n    return {" ++ getDictPropertyList modelProperty ++ " }\n\n" ++ getPropertyFunctionList modelProperty

getCommaPropertyList :: ModelProperty -> String
getCommaPropertyList (ModelProperty modelPropertyList) = join ", " $ map getPropertyName modelPropertyList

getPropertyName :: Property -> String
getPropertyName (Property (PropertyName name) _) = name

getDictPropertyList :: ModelProperty -> String
getDictPropertyList (ModelProperty modelPropertyList) = join ", " $ map getDictPropertyName modelPropertyList

getDictPropertyName :: Property -> String
getDictPropertyName (Property (PropertyName name) _) = " \"" ++ name ++ "\": " ++ name

getPropertyFunctionList :: ModelProperty -> String
getPropertyFunctionList (ModelProperty modelPropertyList) = join "\n" $ map getPropertyFunction modelPropertyList

getPropertyFunction :: Property -> String
getPropertyFunction (Property (PropertyName name) _) = "def " ++ name ++ "(model):\n    return model[\"" ++ name ++ "\"]\n"

getModelType :: ModelType -> String
getModelType (ModelType x) = x


module Translator.EnumDef where

import Translator.Basic
import AST
import Data.List
import Data.Maybe

translateEnumDef :: Statement -> String
translateEnumDef (EnumDef enumName dataTypeList) = join "\n" $ map translateDataType dataTypeList

translateDataType :: DataType -> String 
translateDataType (DataType typeName argTypeList) = "def " ++ getTypeName typeName ++ "(" ++ getCommaArgTypeListHead argTypeList ++ "model):\n    return update([\"" ++ getTypeName typeName ++ "\"" ++ getCommaArgTypeListTail argTypeList ++"], model)\n" 

getTypeName :: TypeName -> String
getTypeName (TypeName name) = name

getCommaArgTypeListHead :: [ArgType] -> String
getCommaArgTypeListHead argTypeList = 
    case join ", " $ map getArgType argTypeList of
        "" -> ""
        _ -> join ", " (zipWith (++) (map getArgType argTypeList) (getNumSuffix argTypeList)) ++ ", "

getCommaArgTypeListTail :: [ArgType] -> String
getCommaArgTypeListTail argTypeList = 
    case join ", " $ map getArgType argTypeList of
        "" -> ""
        _ -> ", " ++ join ", " (zipWith (++) (map getArgType argTypeList) (getNumSuffix argTypeList)) 

getNumSuffix :: [a] -> [String]
getNumSuffix list = map show [1..(length list)]

getArgType :: ArgType -> String
getArgType (ArgType name) = name
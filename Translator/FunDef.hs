module Translator.FunDef where
import AST
import Translator.Basic
import Translator.Expression


translateFunDef :: FunDef -> String
translateFunDef (FunDef funName funArgList expression) = "def " ++ getFunName funName ++ "(" ++ getCommaFunArgList funArgList ++ "):\n" ++ translateExpression expression ++ "\n    return " ++ getLastFunArg funArgList ++ "\n"

getFunName :: FunName -> String
getFunName (FunName name) = name

getCommaFunArgList :: [FunArg] -> String
getCommaFunArgList funArgList = join ", " $ map getFunArgName funArgList

getFunArgName :: FunArg -> String
getFunArgName (FunArg name) = name

getLastFunArg :: [FunArg] -> String
getLastFunArg funArgList = 
    case funArgList of
        [] -> "model"
        _ -> getFunArgName $ last funArgList
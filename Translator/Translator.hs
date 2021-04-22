module Translator.Translator where

import AST
import Translator.ModelDef ( translateModelDef )
import Translator.EnumDef ( translateEnumDef )
import Translator.FunDef ( translateFunDef )

translate :: Program -> IO ()
translate program = 
    writeFile "output.py" $ translateProgram program

translateProgram :: Program -> String
translateProgram (Program x) = "from microbit import *\n\n" ++ (unlines (map translateStatement x)) ++ "view(model())"

translateStatement :: Statement -> String
translateStatement (Function funDecl funDef) = translateFunDef funDef
translateStatement (EnumDef enumName dataTypeList) = translateEnumDef (EnumDef enumName dataTypeList)
translateStatement (ModelDef modelName modelType modelProperty) = translateModelDef (ModelDef modelName modelType modelProperty)






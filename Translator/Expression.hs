module Translator.Expression where
import AST
import Translator.Basic

translateExpression :: Expression -> String
translateExpression (Literal x) = translateLiteral x
translateExpression (Variable name) = translateVariable name
translateExpression (List expressionList) = join "\n" $ map translateExpression expressionList
translateExpression (Case cond caseExpressionList) = translateCase cond caseExpressionList
translateExpression (If cond condTrue condFalse) = translateIf cond condTrue condFalse
translateExpression (Application exp1 exp2) = translateApplication exp1 exp2
translateExpression (AddOp exp1 exp2) = translateExpression exp1 ++ " + " ++ translateExpression exp2
translateExpression (SubstractOp exp1 exp2) = translateExpression exp1 ++ " - " ++ translateExpression exp2
translateExpression (MultiplyOp exp1 exp2) = translateExpression exp1 ++ " * " ++ translateExpression exp2
translateExpression (DivisionOp exp1 exp2) = translateExpression exp1 ++ " / " ++ translateExpression exp2

translateLiteral :: Literal -> String
translateLiteral (Integer x) = x
translateLiteral (String x) = x
translateLiteral (Bool x) = x

translateCase :: Expression -> [CaseExpression] -> String
translateCase cond caseExpressionList = join "\n" $ map ((translateCaseCond cond ++) . translateCaseExpression) caseExpressionList

translateCaseCond :: Expression -> String
translateCaseCond cond = "    if " ++ translateExpression cond ++ "[0] == \""

translateCaseExpression :: CaseExpression -> String
translateCaseExpression (CaseExpression (Application exp1 exp2) right) = translateExpression exp1 ++ "\":\n        " ++ translateExpression exp2 ++ " = signal[1]\n    " ++ translateExpression right
translateCaseExpression (CaseExpression left right) = translateExpression left ++ "\":\n    " ++ translateExpression right

translateIf :: Expression -> Expression -> Expression -> String
translateIf cond condTrue condFalse = "    if " ++ translateExpression cond ++ ":\n        " ++ translateExpression condTrue ++ "    else:\n        " ++ translateExpression condFalse

translateVariable :: String -> String
translateVariable "displayClear" = "display.clear()\n"
translateVariable x = x

translateApplication :: Expression -> Expression -> String
translateApplication (Application (Variable "whileTrue") list1) list2 = "    while True:\n" ++ translateExpression list1 ++ "        " ++ translateExpression list2
translateApplication (Variable "buttonAWasPressed") (Variable x) = "        if button_a.was_pressed():\n            model = " ++ x ++ "(model)\n"
translateApplication (Variable "buttonBWasPressed") (Variable x) = "        if button_b.was_pressed():\n            model = " ++ x ++ "(model)\n"
translateApplication (Variable "compassHeading") (Variable x) = "        if compass.heading():\n            model = " ++ x ++ "(compass.heading(), model)\n"
translateApplication (Variable "displayShowNumber") exp = "display.show(str(" ++ translateExpression exp ++ "))\n"
translateApplication (Variable "Model") exp = "    model = Model(" ++ translateExpression exp ++ ")\n"
translateApplication (Application (Variable "Model") exp1) exp2 = "    model = Model(" ++ translateExpression exp1 ++ ", " ++ translateExpression exp2 ++ ")\n"
translateApplication exp1 exp2 = translateExpression exp1 ++ "(" ++ translateExpression exp2 ++ ")"
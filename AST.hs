module AST where

newtype Program = Program [Statement] deriving Show

data Statement = Function FunDecl FunDef
               | EnumDef EnumName [DataType] 
               | ModelDef ModelName ModelType ModelProperty
               | Import Lib LibFun deriving Show

-- Model Definition
newtype ModelName = ModelName String deriving Show

newtype ModelType = ModelType String deriving Show

newtype ModelProperty = ModelProperty [Property] deriving Show

data Property = Property PropertyName PropertyType deriving Show

newtype PropertyName = PropertyName String deriving Show

newtype PropertyType = PropertyType String deriving Show

-- Function Definition
data FunDecl = FunDecl FunName [FunArgType] deriving Show
data FunArgType = FunArgType FunArgTypeName [FunArgTypeParam] deriving Show
newtype FunArgTypeName = FunArgTypeName String deriving Show
newtype FunArgTypeParam = FunArgTypeParam String deriving Show

data FunDef = FunDef FunName [FunArg] Expression deriving Show

newtype FunName = FunName String deriving Show

newtype FunArg = FunArg String deriving Show

data Expression = Literal Literal
                | Variable String
                | Type String
                | List [Expression]
                | If Expression Expression Expression
                | Case Expression [CaseExpression]
                | Application Expression Expression
                | TypeApplication Expression Expression
                | AddOp Expression Expression 
                | SubstractOp Expression Expression
                | MultiplyOp Expression Expression
                | DivisionOp Expression Expression
                deriving Show

data Literal = Integer String
             | String String
             | Bool String
             deriving Show

data CaseExpression = CaseExpression Expression Expression deriving Show
    {-Constant Double
                 | Addition Expression Expression
                 | Subtraction Expression Expression
                 | Multiplication Expression Expression
                 | Division Expression Expression
                 | Negation Expression
                 deriving Show-}


-- Data Definition
newtype EnumName = EnumName String deriving Show

data DataType = DataType TypeName [ArgType] deriving Show

newtype TypeName = TypeName String deriving Show

newtype ArgType = ArgType String deriving Show


-- Import Def
newtype Lib = Lib [LibString] deriving Show
newtype LibString = LibString String deriving Show
newtype LibFun = LibFun [LibFunString] deriving Show
newtype LibFunString = LibFunString String deriving Show

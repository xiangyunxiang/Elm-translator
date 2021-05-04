# Elm-Translator

In order to run the project, Ghci interpreter for Haskell is needed. 

-   After the ghci has been installed, type `ghci` in terminal to start it.

```bash
> ghci

GHCi, version 8.10.3: https://www.haskell.org/ghc/  :? for help
Prelude> 
```

-   Type `:l example/button.hs` to do the type checking

```bash
Prelude> :l example/button.hs
[1 of 2] Compiling Microbit.MicroPython ( Microbit\MicroPython.hs, interpreted )
[2 of 2] Compiling Main             ( example\button.hs, interpreted )
Ok, two modules loaded.
```

-   Type `:l main` to load the translator.

```bash
*Main> :l main
[ 1 of 16] Compiling AST              ( AST.hs, interpreted )
[ 2 of 16] Compiling Lexer            ( Lexer.hs, interpreted )
[ 3 of 16] Compiling Parser.Basic     ( Parser\Basic.hs, interpreted )
[ 4 of 16] Compiling Parser.EnumDef   ( Parser\EnumDef.hs, interpreted )
[ 5 of 16] Compiling Parser.Expr      ( Parser\Expr.hs, interpreted )
[ 6 of 16] Compiling Parser.FunDef    ( Parser\FunDef.hs, interpreted )
[ 7 of 16] Compiling Parser.Import    ( Parser\Import.hs, interpreted )
[ 8 of 16] Compiling Parser.ModelDef  ( Parser\ModelDef.hs, interpreted )
[ 9 of 16] Compiling Parser.Parser    ( Parser\Parser.hs, interpreted )
[10 of 16] Compiling Translator.Basic ( Translator\Basic.hs, interpreted )
[11 of 16] Compiling Translator.EnumDef ( Translator\EnumDef.hs, interpreted )
[12 of 16] Compiling Translator.Expression ( Translator\Expression.hs, interpreted )
[13 of 16] Compiling Translator.FunDef ( Translator\FunDef.hs, interpreted )
[14 of 16] Compiling Translator.ModelDef ( Translator\ModelDef.hs, interpreted )
[15 of 16] Compiling Translator.Translator ( Translator\Translator.hs, interpreted )
[16 of 16] Compiling Main             ( main.hs, interpreted )
Ok, 16 modules loaded.
```

-   Then type `main`, and type `example/button.hs` as the file name. The output will be stored in the file output.py automatically.

```bash
*Main> main
Please enter the file to be translated:
example/button.hs
"Parse Successfully"
```


import Parser.Parser ( parseProgram )
import AST
import Translator.Translator ( translate )

main :: IO ()
main = do 
    putStrLn "Please enter the file to be translated:"
    file <- getLine 
    input <- readFile file
    case parseProgram input of
        Right program -> print "Parse Successfully" >> translate program
        Left err -> print err

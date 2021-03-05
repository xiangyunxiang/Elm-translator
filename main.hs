module Main where

import Microbit.Basic ( forever, showNumber )
import Microbit.Input ( onPressButton_A, onPressButton_B )

main :: IO ()
main = do
  args <- getArgs
  case args of
    [filename] -> do

      source <- readFile (head args)

      case parseProgram source of
        Right program -> putStrLn "Loaded successfully" >> run_prog program
        Left err -> print err
    _ -> putStrLn "Usage: elm <filename>"
  return ()
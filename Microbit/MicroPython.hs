module Microbit.MicroPython where

whileTrue :: [IO a] -> [IO b] -> IO ()
whileTrue _in _out = print 1

buttonAWasPressed :: a ->  IO a
buttonAWasPressed = return

buttonBWasPressed :: a ->  IO a
buttonBWasPressed = return

displayShowNumber :: Int -> IO ()
displayShowNumber num = print 1

displayShowString :: String -> IO ()
displayShowString str = print 1

displayClear :: IO ()
displayClear = print 1

compassHeading :: (Int -> a) -> IO a
compassHeading m =  return (m 1)
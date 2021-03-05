---------------------------------------------
--Lib

clearScreen :: IO ()
clearScreen = print 1 

showNumber :: Int -> IO ()
showNumber str = print 1

forever :: [IO a] -> [IO ()] -> IO ()
forever _in _out =  print 1

onPressButton_A :: a ->  IO a
onPressButton_A m =  return m 

onPressButton_B :: a ->  IO a
onPressButton_B m =  return m 

compassHeading :: (Int -> a) -> IO a
compassHeading m =  return (m 1)

--------------------------------------------------

-- MODEL
data Model = Model {open :: Bool, heading :: Int}

init :: Model
init = Model False  0
 
-- UPDATE
data Msg = Open | Close | Change Int

update :: Msg -> Model -> Model
update msg model =
  case msg of
    Open -> Model True (heading model) 
    Close -> Model False (heading model)  
    Change newInt -> Model (open model) newInt  

-- VIEW
view :: Model -> IO ()
view model = 
  forever 
    [onPressButton_A Close,
     onPressButton_B Open,
     compassHeading Change ]

    [viewCompass model]

viewCompass :: Model -> IO ()
viewCompass model = 
  if (open model) then showNumber (heading model)
  else clearScreen


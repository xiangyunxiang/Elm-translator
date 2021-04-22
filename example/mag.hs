import Microbit.MicroPython ( whileTrue, buttonAWasPressed, buttonBWasPressed, displayShowNumber, displayClear, compassHeading )
-- MODEL
data Model = Model {on :: Bool, heading :: Int}

model :: Model
model = Model False 0;


-- UPDATE
data Signal = Open | Close | Change Int

update :: Signal -> Model -> Model
update signal model =
  case signal of
    Open -> Model True (heading model);
    Close -> Model False (heading model);
    Change newInt -> Model (on model) newInt;
  ;


-- VIEW
view :: Model -> IO ()
view model = 
  whileTrue 
    [buttonAWasPressed Close,
     buttonBWasPressed Open,
     compassHeading Change ]

    [viewCompass model];

-- VIEW Compass
viewCompass :: Model -> IO ()
viewCompass model = 
  if (on model) then displayShowNumber (heading model)
  else displayClear;

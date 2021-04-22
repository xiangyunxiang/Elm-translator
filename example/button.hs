import Microbit.MicroPython ( whileTrue, buttonAWasPressed, buttonBWasPressed, displayShowNumber )

-- MODEL
data Model = Model { num :: Int }

model :: Model
model = Model 0;


-- UPDATE
data Signal = Increment | Decrement

update :: Signal -> Model -> Model
update signal model =
    case signal of
        Increment -> Model (num model + 1);
        Decrement -> Model (num model - 1);
    ;


-- VIEW
view :: Model -> IO ()
view model = whileTrue 
            [ 
              buttonAWasPressed Increment, 
              buttonBWasPressed Decrement
            ] 
            [ 
              displayShowNumber (num model) 
            ];
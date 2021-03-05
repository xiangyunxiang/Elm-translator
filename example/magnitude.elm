import Microbit.Basic exposing (forever, showNumber, clearScreen)
import Microbit.Input exposing (onButtonPressed_A, onButtonPressed_B, CompassHeading)

-- MODEL
type alias Model = {open : Bool, heading : Int}

init : Model
init = {open = False, heading = 0}


-- UPDATE
type Msg = Open | Close | Change Int

update : Msg -> Model -> Model
update msg model =
	case msg of
		Open -> {model | open = True}
		Close -> {model | open = False}
		Change newInt -> {model | heading = newInt}


-- VIEW
view : Model -> IO
view model = forever [ onPressButton_A Close,
					   onPressButton_B Open,
					   CompassHeading Change,
					   viewCompass model
					 ]

viewCompass : Model -> IO
viewCompass model = 
	if model.open == True then showNumber model.heading
	else clearScreen


-- forever :: [IO] -> IO
-- showNumber :: Int -> IO
-- clearScreen :: IO
-- onPressButton_A :: Msg -> IO
-- onPressButton_B :: Msg -> IO
-- CompassHeading :: Msg -> IO
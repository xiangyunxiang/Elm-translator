import Microbit.Basic exposing (showNumber, forever)
import Microbit.Input exposing (onPressButton_A, onPressButton_B)

-- MODEL
type alias Model = { num : Int }

init : Model
init = { num = 0 }


-- UPDATE
type Msg = Increment | Decrement

update : Msg -> Model -> Model
update msg model =
	case msg of
		Increment -> { model | num = model.num + 1 }
		Decrement -> { model | num = model.num - 1 }


-- VIEW

view : Model -> IO
view model = forever [ onPressButton_A Increment,
					   onPressButton_B Decrement,
					   showNumber model.num
					 ]
					 
					 
-- showNumber :: Int -> IO
-- forever :: [IO] -> IO
-- onPressButton_A :: Msg -> IO
-- onPressButton_B :: Msg -> IO
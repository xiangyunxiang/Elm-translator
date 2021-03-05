import Microbit.Basic exposing (forever)
import Microbit.Input exposing (acceleration_X)
import Microbit.Led exposing (plot)

-- MODEL
type alias Model = { acc : Int }

init : Model
init = { acc = 0 }


-- UPDATE
type Msg = Change Int

update : Msg -> Model -> Model
update msg model =
	case msg of
		Change newInt -> { model | acc = newInt }


-- VIEW
view : Model -> IO
view model = forever [ acceleration_X Change,
					   plot viewAcceleration model
					 ]

viewAcceleration : Model -> [(Int, Int)]
viewAcceleration model =
	if model.acc < -700 then return [(0, 2)]
	else if model.acc >= -700 && model.acc < -300 then return [(1, 1), (1, 2), (1, 3)]
	else if model.acc >= -300 && model.acc < 300 then return [(2, 0), (2, 1), (2, 2), (2, 3), (2, 4)]
	else if model.acc >= 300 && model.acc < 700 then return [(3, 1), (3, 2), (3, 3)]
	else return [(4, 2)]
	
-- forever :: [IO] -> IO
-- acceleration_X :: Msg -> IO
-- plot :: [Int, Int] -> IO
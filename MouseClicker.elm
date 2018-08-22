module MouseClicker exposing (..)

import Html exposing (Html, div, text, program)
import Mouse
import Keyboard
import Char


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { x : Int
    , y : Int
    , keyPressed : Int
    }



-- INIT


init : ( Model, Cmd Msg )
init =
    ( Model 0 0 0, Cmd.none )



-- MESSAGES


type Msg
    = MouseMessage Mouse.Position
    | KeyboardMsg Int



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MouseMessage whatever ->
            ( { model | x = whatever.x, y = whatever.y }, Cmd.none )

        KeyboardMsg code ->
            ( { model | keyPressed = code }, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Mouse.clicks MouseMessage
        , Keyboard.presses KeyboardMsg
        ]



--VIEW


view : Model -> Html Msg
view model =
    div []
        [ text
            ("Position X is: "
                ++ (toString model.x)
                ++ " and Y is: "
                ++ (toString model.y)
            )
        , div []
            [ text ("You pressed: " ++ (toString (Char.fromCode model.keyPressed))) ]
        ]

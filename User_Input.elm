module UserInput exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main =
    Html.beginnerProgram { model = model, view = view, update = update }


type alias Model =
    { text : String }


model : Model
model =
    { text = "" }


type Msg
    = Text String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Text txt ->
            { model | text = txt }



-- bigText : Attribute msg
-- bigText =
--     style
--         [ ( "fontSize", "10em" )
--         , ( "color", "sandybrown" )
--         ]
--
--
-- smallText : Attribute Msg
-- smallText =
--     style
--         [ ( "fontSize", "5em" )
--         , ( "color", "indianred" )
--         ]
--
--
-- checkerTextSize : String -> Attribute Msg
-- checkerTextSize str =
--     if String.length str > 10 then
--         smallText
--     else
--         bigText


adjustSize : Model -> Attribute Msg
adjustSize { text } =
    let
        ( size, color ) =
            if String.length text > 10 then
                ( "5em", "plum" )
            else
                ( "10em", "blue" )
    in
        style
            [ ( "fontSize", size )
            , ( "color", color )
            , ( "fontFamily", "verdana" )
            ]


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Put the text here", onInput Text ] []
        , div [ adjustSize model ] [ text model.text ]
        ]

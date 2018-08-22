module CoinFlip exposing (..)

import Html exposing (Html, program, div, text, button, img, Attribute, br)
import Html.Attributes exposing (src, style)
import Html.Events exposing (onClick)
import Random


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



--MODEL


type alias Model =
    { side : String
    , number : Int
    }


init : ( Model, Cmd Msg )
init =
    ( Model "Heads" 0, Cmd.none )



-- MESSAGES


type Msg
    = StartFlip
    | GenerateFlip Bool
    | GetNum
    | GenerateNum Int



-- UPDATES


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        StartFlip ->
            ( model, Random.generate GenerateFlip (Random.bool) )

        GenerateFlip bool ->
            ( { model | side = generateSide bool }, Cmd.none )

        GetNum ->
            ( model, Random.generate GenerateNum (Random.int 1 100) )

        GenerateNum num ->
            ( { model | number = num }, Cmd.none )


generateSide : Bool -> String
generateSide bool =
    if bool then
        "Heads"
    else
        "Tails"



--SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


getImage : Model -> Attribute msg
getImage model =
    let
        imgUrl =
            if model.side == "Heads" then
                "./images/heads.jpg"
            else
                "./images/tails.jpg"
    in
        src imgUrl


view : Model -> Html Msg
view model =
    div
        [ style
            [ ( "fontSize", "3em" )
            , ( "textAlign", "center" )
            ]
        ]
        [ img
            [ getImage model
            , style
                [ ( "height", "auto" )
                , ( "width", "500px" )
                ]
            ]
            []
        , br [] []
        , text (("The result is: ") ++ model.side)
        , div []
            [ button [ onClick StartFlip ] [ text "Flip" ] ]
        , div []
            [ text ("Random number is: " ++ toString model.number) ]
        , br [] []
        , button [ onClick GetNum ] [ text "Generate Number" ]
        ]

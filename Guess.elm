module Guess exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }


type alias RevealedWord =
    { pos : Int, text : String }


type alias Result =
    { text : String, isCurrect : Bool }


type alias Model =
    { word : String
    , guess : String
    , revealedWord : RevealedWord
    , result : Result
    , wordList : List String
    }


initialWordList : List String
initialWordList =
    [ "fabiovalinhos", "RubyonRails", "Maltodextrina", "Crossfit", "Campinas", "Bruninho" ]


model : Model
model =
    Model "Saturday" "" { pos = 2, text = "S" } { text = "", isCurrect = False } initialWordList


type Msg
    = Answer String
    | Reveal
    | Check
    | Another


update : Msg -> Model -> Model
update msg model =
    case msg of
        Answer txt ->
            { model | guess = txt }

        Reveal ->
            { model | revealedWord = revealAndIncrement model }

        Check ->
            { model | result = checkResult model }

        Another ->
            let
                newWord =
                    getNewWord model
            in
                { model
                    | word = newWord
                    , guess = ""
                    , revealedWord = { pos = 2, text = String.slice 0 1 newWord }
                    , wordList = List.drop 1 model.wordList
                }


getNewWord : Model -> String
getNewWord model =
    let
        list =
            List.filter (\a -> a /= model.word) model.wordList
    in
        String.concat (List.take 1 list)


checkResult : Model -> Result
checkResult { word, guess, result } =
    if String.toLower word == String.toLower guess then
        { result | text = "You got it!", isCurrect = True }
    else
        { result | text = "Nope", isCurrect = False }


revealAndIncrement : Model -> RevealedWord
revealAndIncrement { revealedWord, word } =
    if revealedWord.text == word then
        revealedWord
    else
        { revealedWord | pos = revealedWord.pos + 1, text = String.slice 0 revealedWord.pos word }


genResult : Model -> Html Msg
genResult { result } =
    if String.isEmpty result.text then
        div [] []
    else
        let
            color =
                if result.isCurrect then
                    "forestgreen"
                else
                    "tomato"
        in
            div
                [ style
                    [ ( "color", color )
                    , ( "fontSize", "3em" )
                    , ( "fontFamily", "impact" )
                    ]
                ]
                [ text result.text ]


mainStyle : Attribute Msg
mainStyle =
    style
        [ ( "textAlign", "center" )
        , ( "fontSize", "2em" )
        , ( "fontFamily", "monospace" )
        ]


view : Model -> Html Msg
view model =
    div [ mainStyle ]
        [ h2 []
            [ text
                ("I'm thinking the word start with "
                    ++ model.revealedWord.text
                    ++ " that has "
                    ++ toString (String.length model.word)
                    ++ " letters."
                )
            ]
        , input [ placeholder "Put your guess", onInput Answer ] []
        , p []
            [ button [ onClick Reveal ] [ text "Give me a hint" ]
            , button [ onClick Check ] [ text "Submit answer" ]
            , button [ onClick Another ] [ text "Another word" ]
            ]
        , genResult model
        ]



-- revealLetter : Model -> String
-- revealLetter model =
--     if String.length model.word == String.length model.revealedWord then
--         model.word
--     else
--         String.slice 0 model.revealedPos model.word
--
-- checkIfCorrect : Model -> String -> Bool
-- checkIfCorrect model txt =
--     if txt == model.word then
--         True
--     else
--         False
-- generateResult : Model -> Html Msg
-- generateResult { isCorrect, revealedWord, word } =
--     let
--         txt =
--             if revealedWord.text == word then
--                 "You didn't it!"
--             else if isCorrect then
--                 "You got it"
--             else
--                 "Nope"
--     in
--         text txt

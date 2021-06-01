module Main exposing (main)

import Browser
import Html exposing (Html, button, div, input, label, span, text)
import Html.Attributes exposing (checked, class, style, type_)
import Round


main : Program () Model Msg
main =
    Browser.element { init = init, update = update, view = view, subscriptions = subscriptions }



-- MODEL


type alias Model =
    String


init : () -> ( Model, Cmd Msg )
init _ =
    ( "Why hello there", Cmd.none )



-- UPDATE


type Msg
    = HandleThingInput String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        HandleThingInput str ->
            ( str, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


buttonTight : String
buttonTight =
    "px-1 bg-gray-200 border border-gray-500 rounded-lg focus:border-2 hover:bg-gray-300 "


buttonStandard : String
buttonStandard =
    "bg-gray-300 border border-gray-900 rounded w-36 py-2 text-center"


renderTopBar : Html Msg
renderTopBar =
    let
        resetButton =
            button [ class buttonTight ] [ text "reset wizard" ]
    in
    div [ class "border-b border-gray-500 p-4" ]
        [ resetButton
        ]


renderMainArea : Html Msg
renderMainArea =
    let
        renderResources =
            div [ class "h-full w-48 border-r border-gray-500 flex-col p-2" ]
                [ div [ class "flex justify-between" ]
                    [ div [] [ text "Gold" ]
                    , div [] [ text "5/5" ]
                    ]
                ]

        renderActions =
            div [ class "h-full flex-grow border-r border-gray-500 flex-col" ]
                [ div [ class "w-full flex justify-center space-x-4 border-b border-gray-500 p-1" ]
                    [ button [ class "text-lg font-medium focus:outline-none" ] [ text "Main" ]
                    , button [ class "text-lg font-medium underline opacity-50 hover:opacity-100 hover:text-blue-500 focus:outline-none" ] [ text "Player" ]
                    ]
                , div [ class "w-full flex-grow flex-col space-y-8 p-4" ]
                    [ div [ class "flex flex-wrap" ]
                        [ button [ class buttonStandard ] [ text "Clean Stables" ]
                        ]
                    , div [ class "flex flex-wrap" ]
                        [ button [ class buttonStandard, class "bg-yellow-500" ] [ text "Rest" ]
                        ]
                    , div [ class "flex flex-wrap" ]
                        [ button [ class buttonStandard ] [ text "Pouch" ]
                        ]
                    ]
                ]

        renderStats =
            let
                renderMeter : Float -> Float -> String -> Html Msg
                renderMeter current max fillColor =
                    div
                        [ class "border-2 border-black rounded-lg overflow-hidden relative bg-gray-700 box-content"
                        , style "height" "24px"
                        , style "width" "140px"
                        ]
                        [ div
                            [ class "h-full rounded-r-lg"
                            , class <| "bg-" ++ fillColor
                            , style "width" (String.fromFloat (current / max * 100) ++ "%")
                            ]
                            [ span
                                [ class "bg-white bg-opacity-75 rounded absolute right-0 mr-1 inline-block leading-tight px-1"
                                , style "top" "50%"
                                , style "transform" "translate(0, -50%)"
                                , style "height" "fit-content"
                                ]
                                [ text (Round.round 1 current ++ " / " ++ Round.round 1 max) ]
                            ]
                        ]
            in
            div [ class "h-full w-64 border-r border-gray-500 flex-col" ]
                [ div [ class "w-full flex justify-center space-x-4 border-b-4 border-dashed border-gray-900 p-1" ]
                    [ div [ class "text-lg font-medium invisible" ] [ text "Placeholder" ]
                    ]
                , div [ class "w-full flex-grow flex-col space-y-2 p-1 pt-2" ]
                    [ div [ class "flex justify-between items-center" ]
                        [ div [] [ text "Stamina" ]
                        , renderMeter 9.0 10.0 "yellow-500"
                        ]
                    , div [ class "flex justify-between items-center" ]
                        [ div [] [ text "Hp" ]
                        , renderMeter 5.0 5.0 "red-700"
                        ]
                    ]
                ]

        renderLog =
            let
                logLabel =
                    "flex items-center space-x-1"
            in
            div [ class "h-full w-64 flex-col" ]
                [ div [ class "w-full border-b border-gray-500 flex" ]
                    [ div [ class "h-full flex justify-center items-center p-2 w-full" ]
                        [ button [ class "p-2 bg-gray-200 hover:bg-gray-300 border border-gray-500 rounded" ] [ text "Clear" ]
                        , div [ class "flex flex-col flex-grow pl-2" ]
                            [ label [ class logLabel ]
                                [ input [ type_ "checkbox", checked True ] []
                                , span [] [ text "event" ]
                                ]
                            , label [ class logLabel ]
                                [ input [ type_ "checkbox", checked True ] []
                                , span [] [ text "unlock" ]
                                ]
                            ]
                        , div [ class "flex flex-col flex-grow pl-2" ]
                            [ label [ class logLabel ]
                                [ input [ type_ "checkbox", checked True ] []
                                , span [] [ text "loot" ]
                                ]
                            , label [ class logLabel ]
                                [ input [ type_ "checkbox", checked True ] []
                                , span [] [ text "combat" ]
                                ]
                            ]
                        ]
                    ]
                ]
    in
    div [ class "flex-grow flex-shrink flex border-b border-gray-500" ]
        [ renderResources
        , renderActions
        , renderStats
        , renderLog
        ]


renderBottomBar : Html Msg
renderBottomBar =
    div [ class "h-24" ] []


view : Model -> Html Msg
view model =
    div [ class "w-screen h-screen flex items-center justify-center" ]
        [ div [ style "width" "1340px", style "height" "960px", class "bg-gray-200 rounded shadow flex flex-col" ]
            [ renderTopBar
            , renderMainArea
            , renderBottomBar
            ]
        ]

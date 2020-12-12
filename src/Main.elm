module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Set exposing (Set)



---- MODEL ----


type alias Model =
    { orn : Set String
    }


init : ( Model, Cmd Msg )
init =
    ( { orn = Set.empty
      }
    , Cmd.none
    )



---- UPDATE ----


type Msg
    = Clicked String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Clicked url ->
            ( { model
                | orn =
                    if Set.member url model.orn then
                        Set.remove url model.orn

                    else
                        Set.insert url model.orn
              }
            , Cmd.none
            )



---- VIEW ----


view : Model -> Html Msg
view model =
    div [ class "flex justify-center relative" ]
        [ img [ src "tree.jpg" ] []
        , dragons |> List.map (\d -> viewOrn (Set.member d.url model.orn) d) |> div []
        ]


viewOrn visible config =
    div
        [ onClick (Clicked config.url)
        , class "w-20 h-20 z-10 absolute "
        , style "top" (String.fromInt config.top ++ "px")
        , style "left" (String.fromInt config.left ++ "px")
        ]
        [ if visible then
            img [ src config.url ] []

          else
            span [] []
        ]



---- PROGRAM ----


main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = always Sub.none
        }


dragons =
    [ { url = "red1.jpg", top = 422, left = 600 }
    , { url = "green1.gif", top = 275, left = 730 }
    ]

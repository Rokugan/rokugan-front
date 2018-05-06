module Main exposing (..)

import Html exposing (Html)
import Html.Attributes
import Navigation exposing (Location)

import Model exposing (..)
import Msg exposing (..)
import DataBase.Cards

main : Program Never Model Msg
main =
  Navigation.program HandleLocation
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

init : Location -> (Model, Cmd Msg)
init location =
  { location = location
  , cardList = []
  , error = Nothing
  } ! [ DataBase.Cards.all ]

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    HandleLocation location -> { model | location = location } ! []
    HttpResults resultMsg ->
      case resultMsg of
        AllCards results ->
          case results of
            Err error -> { model | error = Just (toString error) } ! []
            Ok cards -> { model | cardList = cards } ! []

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

view : Model -> Html Msg
view { error } =
  Html.div
    [ Html.Attributes.class "playmat" ]
    [ case error of
      Nothing -> Html.text ""
      Just content -> Html.text content
    ]

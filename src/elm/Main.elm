module Main exposing (..)

import Html exposing (Html)
import Html.Attributes
import Navigation exposing (Location)

import Model exposing (..)
import Msg exposing (..)

main : Program Never Model Msg
main =
  Navigation.program HandleLocation
    { init = init
    , update = update
    , subscriptions = subscriptions
    , view = view
    }

init : Location -> (Model, Cmd msg)
init location =
  { location = location } ! []

update : msg -> Model -> (Model, Cmd msg)
update msg model =
  model ! []

subscriptions : Model -> Sub msg
subscriptions model =
  Sub.none

view : Model -> Html msg
view model =
  Html.div
    [ Html.Attributes.class "playmat" ]
    []

module Model exposing (..)

import Navigation exposing (Location)

import Card exposing (Card)

type alias Model =
  { location : Location
  , cardList : List Card
  , error : Maybe String
  }

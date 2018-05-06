module Msg exposing (..)

import Navigation exposing (Location)
import Http

import Card exposing (Card)

type Msg
  = HandleLocation Location
  | HttpResults HttpResultsMsg

type HttpResultsMsg
  = AllCards (Result Http.Error (List Card))

module DataBase.Cards exposing (..)

import Http
import Json.Decode as Decode

import Msg exposing (..)
import DataBase.Cards.Decoder

endpoint : String
endpoint = "https://api.fiveringsdb.com"

all : Cmd Msg
all =
  Http.send (HttpResults << AllCards)
    <| flip Http.get (Decode.field "records" DataBase.Cards.Decoder.decodeCards)
    <| String.join "/"
        [ endpoint
        , "cards"
        ]

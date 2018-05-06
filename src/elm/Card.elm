module Card exposing (..)

import Card.Clan as Clan
import Card.Side as Side
import Card.Type as Type

type alias Card =
  { clan : Clan.Clan
  , cost : Int
  , deckLimit : Int
  , id : String
  , influenceCost : Maybe Int
  , name : String
  , nameCanonical : String
  , packCards : List
    { illustrator : String
    , imageUrl : Maybe String
    , pack : Pack
    , position : String
    , quantity : Int
    }
  , side : Side.Side
  , text : Maybe String
  , textCanonical : Maybe String
  , traits : List Trait
  , type_ : Type.Type
  , unicity : Bool
  }

type alias Pack =
  { name : String
  , id : String
  }

type alias Trait = {}

module DataBase.Cards.Decoder exposing (decodeCard, decodeCards)

import Json.Decode as Decode exposing (Decoder, string, int, field, bool, maybe)
import Json.Decode.Extra as Decode exposing ((|:))

import Card exposing (..)
import Card.Clan as Clan exposing (Clan)
import Card.Side as Side exposing (Side)
import Card.Type as Type exposing (Type)

decodeCard : Decoder Card
decodeCard =
  Decode.succeed Card
    |: Decode.andThen decodeClan (field "clan" string)
    |: Decode.map (Maybe.withDefault 0) (maybe (field "cost" int))
    |: field "deck_limit" int
    |: field "id" string
    |: maybe (field "influence_cost" int)
    |: field "name" string
    |: field "name_canonical" string
    |: field "pack_cards" decodePackCards
    |: Decode.andThen decodeSide (field "side" string)
    |: maybe (field "text" string)
    |: maybe (field "text_canonical" string)
    |: field "traits" decodeTraits
    |: Decode.andThen decodeType (field "type" string)
    |: field "unicity" bool

decodeCards : Decoder (List Card)
decodeCards =
  Decode.list decodeCard



decodeClan : String -> Decoder Clan
decodeClan clan =
  case clan of
    "crab" -> Decode.succeed Clan.Crab
    "crane" -> Decode.succeed Clan.Crane
    "dragon" -> Decode.succeed Clan.Dragon
    "lion" -> Decode.succeed Clan.Lion
    "phoenix" -> Decode.succeed Clan.Phoenix
    "scorpion" -> Decode.succeed Clan.Scorpion
    "unicorn" -> Decode.succeed Clan.Unicorn
    "neutral" -> Decode.succeed Clan.Neutral
    _ -> Decode.fail ("Bad clan: " ++ clan)

createPackCard
   : String
  -> Maybe String
  -> Pack
  -> String
  -> Int
  -> { illustrator : String
     , imageUrl : Maybe String
     , pack : Pack
     , position : String
     , quantity : Int
     }
createPackCard illustrator imageUrl pack position quantity =
  { illustrator = illustrator
  , imageUrl = imageUrl
  , pack = pack
  , position = position
  , quantity = quantity
  }

decodePackCards : Decoder
  (List { illustrator : String
        , imageUrl : Maybe String
        , pack : Pack
        , position : String
        , quantity : Int
        })
decodePackCards =
  Decode.list <|
    Decode.map5 createPackCard
      (field "illustrator" string)
      (maybe (field "image_url" string))
      (field "pack" decodePack)
      (field "position" string)
      (field "quantity" int)

decodePack : Decoder Pack
decodePack =
  Decode.map2 Pack
    (field "id" string)
    (field "id" string)

decodeSide : String -> Decoder Side
decodeSide side =
  case side of
    "dynasty" -> Decode.succeed Side.Dynasty
    "conflict" -> Decode.succeed Side.Conflict
    "province" -> Decode.succeed Side.Province
    "role" -> Decode.succeed Side.Role
    _ -> Decode.fail ("Bad side: " ++ side)

decodeTraits : Decoder (List Trait)
decodeTraits =
  Decode.list (Decode.succeed {})

decodeType : String -> Decoder Type
decodeType type_ =
  case type_ of
    "event" -> Decode.succeed Type.Event
    "attachment" -> Decode.succeed Type.Attachment
    "character" -> Decode.succeed Type.Character
    "province" -> Decode.succeed Type.Province
    "holding" -> Decode.succeed Type.Holding
    "stronghold" -> Decode.succeed Type.Stronghold
    "role" -> Decode.succeed Type.Role
    _ -> Decode.fail ("Bad type: " ++ type_)

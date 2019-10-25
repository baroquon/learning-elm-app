module Main exposing (..)

import Browser
import Html exposing (Html, text, div, h1, img, input, br)
import Html.Attributes exposing (src, class, value)
import Html.Events exposing (onInput)


---- MODEL ----

type alias Team = 
    {
        id: Int
    ,   name: String
    ,   city: String
    }

type alias Model =
    {
        teams : List Team
    }

team1 = 
  {
    id=1
  , name = "Cubs"
  , city = "Chicago"
  }
team2 = 
  {
    id=2
  , name = "Cardinals"
  , city = "St. Louis"
  }
team3 = 
  {
    id=3
  , name = "Marlins"
  , city = "Miami"
  }
team4 = 
  {
    id=4
  , name = "Braves"
  , city = "Atlanta"
  }
init : ( Model, Cmd Msg )
init =
    ( { teams=[team1, team2, team3, team4] }, Cmd.none )



---- UPDATE ----
type Msg
  = ChangeName Int String
  | ChangeCity Int String

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    ChangeName id newContent ->
      let
          updateEntry t =
              if t.id == id then
                  { t | name = newContent }
              else
                  t
      in
      ( { model | teams = List.map updateEntry model.teams }
      , Cmd.none
      )
    ChangeCity id newContent ->
      let
          updateEntry t =
              if t.id == id then
                  { t | city = newContent }
              else
                  t
      in
      ( { model | teams = List.map updateEntry model.teams }
      , Cmd.none
      )

---- VIEW ----
mapFunc : Team -> Html Msg
mapFunc passedInTeam =
  div []
    [  text (passedInTeam.name ++ " from " ++ passedInTeam.city)
    , br [] []
    , input [ value passedInTeam.name, onInput (ChangeName passedInTeam.id)] []
    , br [] []
    , input [ value passedInTeam.city, onInput (ChangeCity passedInTeam.id)] []
    ]

view : Model -> Html Msg
view model =
    div 
      [ class "hello-container" ]
        [ img [ src "/logo.svg" ] []
        , h1 [] [ text "List of Teams" ]
        , div [] (List.map mapFunc model.teams)
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

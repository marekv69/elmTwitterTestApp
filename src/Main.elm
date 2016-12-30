import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Dropdown exposing (..)



-- model


type alias Model =
    {
      sortByDateDropdown : Dropdown.Dropdown
    }




init : ( Model, Cmd Msg )
init =
    let
        initModel =
            {
              sortByDateDropdown = Dropdown.init "" ["2", "3", "4"] "Your age"
            }

        cmd =
            Cmd.none
    in
        ( initModel, cmd )



-- update


type Msg
    = SortByDateDropdownMsg Dropdown.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of

      {--  LeaderBoardMsg msg ->
            let
                ( leaderBoardModel, cmd ) =
                    LeaderBoard.update msg model.leaderBoard
            in
                ( { model | leaderBoard = leaderBoardModel }
                , Cmd.map LeaderBoardMsg cmd

                 )--}
      SortByDateDropdownMsg msg ->
        ( {model | sortByDateDropdown = Dropdown.update msg model.sortByDateDropdown}
        , Cmd.none
        )




-- view


view : Model -> Html Msg
view model =

    div [ class "twitter-app-page" ]
        [
           h2 [] [text "Show 50 latest tweets by user name"]
        ,  searchBar model
        , div [ class "tweet-list"]
              [
                Html.map SortByDateDropdownMsg (Dropdown.renderDropdownHtml model.sortByDateDropdown)
              ]
        ]

searchBar : Model -> Html Msg
searchBar model =
  div [ class"search-bar"]
      [
        Html.form []
             [ div [ class "input-group" ]
                   [ input [
                             class "searchInput form-control"
                           , placeholder "Type twitter username"
                           , type_ "text"
                           , value ""
                           ]
                           [
                           ]
                   , span [
                            class "input-group-btn"
                          ]
                          [
                            button [
                                     type_ "button"
                                   , class "btn btn-primary"
                                   ]
                                   [
                                     text "Show tweets"
                                   ]
                          ]
                   ]
             ]
      ]

-- subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }

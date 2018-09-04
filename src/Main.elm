module Main exposing (Model)

import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (..)
import Url


main =
    Browser.application
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        , onUrlRequest = UrlRequested
        , onUrlChange = UrlChanged
        }



-- MODEL


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( Model key url "" "", Cmd.none )


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , clicked : String
    , received : String
    }



-- UPDATE


type Msg
    = UrlRequested Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlRequested (Browser.External link) ->
            ( { model | clicked = link }, Nav.load link )

        UrlRequested (Browser.Internal url) ->
            ( { model | clicked = Url.toString url }, Nav.pushUrl model.key (Url.toString url) )

        UrlChanged url ->
            ( { model | received = Url.toString url }, Cmd.none )



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "some"
    , body =
        [ div []
            [ a [ href "/page2" ] [ text "page2" ]
            , a [ href "/page3" ] [ text "page3" ]
            , a [ href "https://duckduckgo.com" ] [ text "duckduckGo" ]
            ]
        , div []
            [ text <| "clicked " ++ model.clicked ]
        , div []
            [ text <| "received " ++ model.received ]
        ]
    }



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none

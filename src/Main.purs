module Main where

import Prelude

import Effect (Effect)
import Halogen as H
import Halogen.Aff as HA
import Halogen.HTML as HH
import Halogen.HTML.Events as HE
import Halogen.HTML.Properties as HP
import Halogen.VDom.Driver (runUI)
import MainStyle as Style
import Web.UIEvent.MouseEvent (MouseEvent)
import Data.Either (Either)

main :: Effect Unit
main = HA.runHalogenAff do
  body <- HA.awaitBody
  runUI component unit body

data Action = Increment | Decrement

type OnClick = MouseEvent -> Action
type State = Int


b :: String
b = "hello"

primaryButton :: forall m. String -> OnClick -> H.ComponentHTML Action () m
primaryButton text handleClick =
  HH.button [ classes [ Style.button ], HE.onClick handleClick] [ HH.text text ]

classes :: forall i r. Array String -> HH.IProp ( class :: String | r) i
classes classNames = HP.classes (map HH.ClassName classNames)

component :: forall query input output monad. H.Component query input output monad
component =
  H.mkComponent
    { initialState
    , render
    , eval: H.mkEval $ H.defaultEval { handleAction = handleAction }
    }
  where
    initialState :: forall i. i -> State
    initialState _ = 0
    
    render :: forall m. State -> H.ComponentHTML Action () m
    render state =
      HH.div  [ classes [Style.buttonGroup] ]
              [ primaryButton "-" (\_ -> Decrement)
              , HH.div [ classes [ Style.text] ]
                       [ HH.text $ show state ]
              , primaryButton "+" (\_ -> Increment)
              ]

    handleAction :: forall o m. Action -> H.HalogenM State Action () o m Unit
    handleAction = case _ of
      Increment -> H.modify_ \state -> state + 1
      Decrement -> H.modify_ \state -> state - 1


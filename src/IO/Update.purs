module IO.Update where

import Prelude
import Signal as S
import Signal.DOM as S
import Signal.Time as S

data Event = Tick S.Time | MouseDown S.CoordinatePair

type State = S.CoordinatePair

update :: Event -> State -> State
update (MouseDown pos) _ = pos
update _ s = s

initialState :: State
initialState = { x: 0, y: 0 }

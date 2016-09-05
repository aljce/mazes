module IO.Render where

import Prelude
import IO.Update
import Graphics.Drawing as G
import Control.Monad.Eff (Eff)
import Graphics.Canvas (CANVAS, Context2D)

render :: forall e. Context2D -> State -> Eff (canvas :: CANVAS | e) Unit
render ctx pos = G.render ctx (G.filled (G.fillColor G.black) (G.circle 0.0 0.0 20.0))

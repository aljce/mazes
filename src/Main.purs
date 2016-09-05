module Main where

import Prelude
import IO.Update
import IO.Render
import Signal as S
import Signal.DOM as S
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Exception.Unsafe (unsafeThrow)
import Control.Monad.Eff.Timer (TIMER)
import DOM (DOM)
import Data.Maybe (Maybe(..))
import Graphics.Canvas (getCanvasElementById, getContext2D, CANVAS)
import Signal (merge)
import Signal.DOM (mousePos, mouseButton)

main :: Eff (canvas :: CANVAS, timer :: TIMER, dom :: DOM) Unit
main = getCanvasElementById "maze" >>= \may -> case may of
  Just canvas -> do
    ctx <- getContext2D canvas
    frames <- S.animationFrame
    mouseDown <- S.filter id false <$> mouseButton 0
    mousePos <- S.sampleOn mouseDown <$> mousePos
    let eventSF = map Tick frames `merge` map MouseDown mousePos
        mainSF  = S.foldp update initialState eventSF
    S.runSignal (render ctx <$> mainSF)
  Nothing -> unsafeThrow "No maze element found."

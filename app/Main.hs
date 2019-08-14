{-# LANGUAGE TemplateHaskell #-}

module Main where

import           Concurrency.RateLimiter
import           Control.Applicative            ( (<|>) )
import           Control.Concurrent             ( threadDelay )
import           Control.Monad.IO.Class         ( liftIO )
import           Data.Functor                   ( void )
import           Time
import           Transient.Base
import           Transient.EVars
import           Transient.Indeterminism

showRates :: IO ()
showRates = void . keep' $ do
  var <- newEVar :: TransIO (EVar Exchange)
  let f = rateLimiter (minutes 1) $$(refineTH 1000) (pure 22) (lastWriteEVar var)
  let g = sleep 2 >> readEVar var >>= liftIO . print >> g :: TransIO ()
  let h = async (pure 11 >>= print) >> sleep 5 >> h :: TransIO ()
  f <|> g <|> h
  where sleep n = liftIO $ threadDelay (1000000 * n) :: TransIO ()

main :: IO ()
main = putStrLn "Hello, Haskell!"

{-# LANGUAGE TemplateHaskell #-}

module Main where

import           Concurrency.RateLimiter        ( RateLimit
                                                , rateLimiter
                                                )
import           Control.Applicative            ( (<|>) )
import           Control.Concurrent             ( threadDelay )
import           Control.Monad.IO.Class         ( liftIO )
import           Data.Functor                   ( void )
import           Refined                        ( refineTH )
import           Time                           ( seconds )
import           Transient.Base
import           Transient.EVars
import           Transient.Indeterminism

main :: IO ()
main = void . keep' $ do
  var <- newEVar :: TransIO (EVar Int)
  let r = $$(refineTH 1000) :: RateLimit
  let f = rateLimiter (seconds 5) r (pure 22) (lastWriteEVar var)
  let g = sleep 2 >> readEVar var >>= liftIO . print >> g :: TransIO ()
  let h = async (pure 11 >>= print) >> sleep 5 >> h :: TransIO ()
  f <|> g <|> h

sleep :: Int -> TransIO ()
sleep n = liftIO $ threadDelay (1000000 * n)

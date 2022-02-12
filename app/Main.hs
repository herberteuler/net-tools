{-# LANGUAGE NoImplicitPrelude #-}

module Main where

import Config
import Dhall
import RIO
import System.Environment

main :: IO ()
main = runSimpleApp $ do config <- liftIO $ do [f] <- getArgs
                                               inputFile config f
                         logInfo $ displayShow (config :: Config)

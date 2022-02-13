{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}

module Ping (runPing) where

import Config
import RIO

runPing :: Config -> RIO SimpleApp ()
runPing config = logInfo $ displayShow config

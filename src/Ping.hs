{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Ping (runPing) where

import Config
import Database.Selda
import Database.Selda.SQLite
import Database.Selda.SqlType
import Data.Time.Clock
import RIO

data PingResult = PSuccess !(Maybe Int)
                | PSocket !Int
                | PSend !Int
                | PSendBytes !Int
                | PReceive !Int
                | PClose !Int
                | PDefault
                deriving (Show)

instance SqlType PingResult where

    mkLit = undefined

    sqlType _ = TJSON

    fromSql = undefined

    defaultValue = undefined

data PingEvent = PingEvent { peTime :: !UTCTime
                           , peSrc :: !Text
                           , peDst :: !Text
                           , peResult :: !PingResult
                           }
               deriving (Show, Generic)

instance SqlRow PingEvent

runPing :: Config -> RIO SimpleApp ()
runPing config = logInfo $ displayShow config

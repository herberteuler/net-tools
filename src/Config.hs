{-# LANGUAGE OverloadedStrings #-}

module Config ( Config(..)
              , Server(..)
              , config
              ) where

import Dhall

data Config = Config { configPingDb :: !Text
                     , configIps :: ![Server]
                     }
              deriving (Show)

data Server = Server { serverIpv4 :: !Text
                     , serverIpv6 :: !(Maybe Text)
                     , serverCity :: !Text
                     , serverRegion :: !Text
                     , serverCountry :: !Text
                     , serverProvider :: !Text
                     , serverActive :: !Bool
                     }
          deriving (Show)

config :: Decoder Config
config = record (Config <$> field "ping-db" strictText
                        <*> field "servers" (list server)
                )

server :: Decoder Server
server = record (Server <$> field "ipv4" strictText
                        <*> field "ipv6" (Dhall.maybe strictText)
                        <*> field "city" strictText
                        <*> field "region" strictText
                        <*> field "country" strictText
                        <*> field "provider" strictText
                        <*> field "active" bool
                )

{-# LANGUAGE OverloadedStrings #-}

module Config ( Config(..)
              , Server(..)
              , config
              ) where

import Dhall

data Config = Config { configPing :: !PingConfig
                     , configIps :: ![Server]
                     }
              deriving (Show)

data PingConfig = PingConfig { pcDb :: !Text
                             , pcTimeout :: !Natural
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
config = record (Config <$> field "ping" ping
                        <*> field "servers" (list server)
                )

ping :: Decoder PingConfig
ping = record (PingConfig <$> field "db" strictText
                          <*> field "timeout" natural
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

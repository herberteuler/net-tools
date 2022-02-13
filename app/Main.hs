{-# LANGUAGE NoImplicitPrelude #-}

module Main where

import Config
import Dhall
import Options.Applicative
import Ping
import RIO

data NetTools = NetTools { ntConfig :: FilePath, ntCommand :: Command }
  deriving Show

data Command = Ping
  deriving Show

netTools :: Parser NetTools
netTools = NetTools <$> strOption (long "config"
                                  <> short 'c'
                                  <> metavar "CONFIG"
                                  <> help "Configuration")
                    <*> subparser ping

ping :: Mod CommandFields Command
ping = command "ping" $ info cmd (progDesc "Ping servers")
  where
    cmd = pure Ping

main :: IO ()
main = runSimpleApp $ do nt <- liftIO $ execParser opts
                         case nt of
                           NetTools confFile cmd ->
                             do conf <- liftIO $ inputFile config confFile
                                case cmd of
                                  Ping -> runPing conf
  where
    opts = info (netTools <**> helper)
                ( fullDesc
                <> header "net-tools - a set of tools to monitor servers")

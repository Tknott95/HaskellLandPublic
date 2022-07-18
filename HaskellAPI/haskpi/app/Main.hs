{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DeriveGeneric #-}

module Main where

import Servant.API
import Servant.Server
import Network.Wai
import Network.Wai.Handler.Warp

import GHC.Generics (Generic)
import Data.Aeson (ToJSON, FromJSON)
import Control.Monad.IO.Class

import Data.Proxy
-- import Data.Aeson.Types
-- data SortBy = Weight | Wins

data Fighter = 
  Fighter {
    name :: String,
    weight :: Double,
    wins :: Int,
    losses :: Int
  } deriving (Eq, Show, Generic)

instance ToJSON Fighter
instance FromJSON Fighter

-- :> Capture "name" String    can be added to capture value in url
-- for another endpoint  :<|>
type FighterAPI =
  "api" :> "fighters"
  -- :> QueryParam "sort_by" SortBy
  :> Get '[JSON] [Fighter]
  :<|>  "api" :> "post" :> "fighters" :> 
  ReqBody '[JSON] Fighter :> Post '[JSON] Fighter

fightersList :: [Fighter]
fightersList = 
  [ Fighter "Rocky Balboa" 215 27 13,
    Fighter "Apollo Creed" 214.5 44 3
  ]

myServer :: Server FighterAPI
myServer = 
  getFightersInline
  :<|> postFighterInline
  
  where
    -- getFightersInline :: [Fighter]
    getFightersInline = return fightersList
    postFighterInline :: Fighter -> Handler Fighter
    postFighterInline _fighter = do
       -- print $ "POST HIT" -- fighter
       let fString = show _fighter
       let fWins =  show $ wins _fighter
       liftIO $ print fString
       liftIO $ print fWins
       return  _fighter

myAPI :: Proxy FighterAPI
myAPI = Proxy

fullServer :: Application
fullServer = serve myAPI myServer

main :: IO ()
main = do
   putStrLn "\n\n Hello, Haskell! - check port 1335 -  /api/fighters"
   run 1335 fullServer

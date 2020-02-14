{-# LANGUAGE DeriveGeneric       #-}
{-# LANGUAGE OverloadedStrings   #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE DerivingVia         #-}
{-# LANGUAGE TypeApplications    #-}
{-# LANGUAGE PolyKinds           #-}
{-# LANGUAGE DataKinds           #-}
{-# LANGUAGE KindSignatures      #-}
{-|
Module      : Data.Time.Deriving
Description : Short description
Copyright   : (c) Shae Erisson, 2020
                  David Johnson, 2020
License     : BSD3
Stability   : experimental
-}
module Data.Time.Deriving where

import           Data.Aeson            hiding (decode, encode)
import qualified Data.ByteString.Char8 as BC8
import           Data.Proxy
import           Data.Text
import           Data.Time
import           GHC.Generics
import           GHC.TypeLits

-- | Derive `LocalTime`
newtype Time (s :: Symbol) = Time { f :: LocalTime }
  deriving (Show, Eq, Ord, Generic)

instance KnownSymbol s => FromJSON (Time s) where
    parseJSON =
      withText "Time" $ \t ->
        case parseTimeM True defaultTimeLocale k (unpack t) of
          Just d -> pure (Time d)
          _      -> fail "could not parse MyTime"
      where
        k = symbolVal (Proxy @ s)

instance KnownSymbol s => Read (Time s) where
    readsPrec _ s =
        case parseTimeM True defaultTimeLocale k s of
          Just d -> [(Time d, mempty)]
          _      -> []
      where
        k = symbolVal (Proxy @ s)

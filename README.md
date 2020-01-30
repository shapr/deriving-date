# deriving-date
deriving-date for custom FromJSON date-time formats

Automatically derive date parsing logic via type-level `Symbol`s.

```haskell
import Data.Aeson         (FromJSON, fromJSON)
import Data.Time.Deriving (Time)

newtype MyTime = MT { lt :: LocalTime }
  deriving (Read, FromJSON) via (Time "%M/%d/%y %H:%M:%S")
  deriving Show

main :: IO ()
main = do
  print @(Result MyTime) $ fromJSON (String "01/01/20 10:10:02")
  print (read "01/01/20 10:10:02" :: MyTime)
```
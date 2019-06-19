import UI.NCurses
import Data.String
import qualified Data.Map.Strict as Map


-- fromList tuple-pairs
-- findWithDefault defTile coords Map



data Tile = Tile String Bool Int Int deriving (Show , Read)

water = Tile "~" False 1
dirt = Tile "x" True 2

waterMap = [((x,y),water) |  x <- [1..10], y <- [1..10] ]

m = Map.fromList waterMap

test = do
    writeFile "map.txt" (show m)



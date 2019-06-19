import UI.NCurses
import Data.String
import qualified Data.Map.Strict as Map
-- import System.Environment -- getArgs 

-- data Map = Map [[Tile]]

-- fromList tuple-pairs
-- findWithDefault defTile coords Map

---- TODO, check if colors supported and maxcolorid etc..


-- '~' walkable colorid
data Tile = Tile String Bool Int deriving (Show , Read)
drawTile :: Tile -> Update ()
drawTile (Tile c w clr) = do
    setColor defaultColorID
    drawText (fromString c)

type TileMap = Map.Map (Int,Int) Tile

loadedMap :: IO TileMap
loadedMap = do
    txt <- readFile "map.txt"
    return (read txt)




main :: IO ()
main = do
    map <- loadedMap
    runCurses $ myCursedApp map

myCursedApp mp = (do
        setEcho False
        w <- defaultWindow

        x <- newColorID ColorWhite ColorBlue 5

        -- mp....

        -- fmap (x<-) [newColor....]
        -- Update newColorID
        -- Color Color Int -> Curses Update

        -- zz <- Map.fromList [(1, newColorID ColorWhite ColorBlue 5)]
        let tmpClrList = [(ColorRed, ColorRed, 1),
                            (ColorGreen, ColorWhite, 2),
                            (ColorWhite, ColorBlue, 5)]
        clrList <- mapM (\(x,y,z) -> (newColorID x y z)) tmpClrList
        -- curry uncurry

        -- fmap setColor x 

        updateWindow w $ do
            clear
            setColor defaultColorID
            moveCursor 1 10
            drawString "Hello world!"
            moveCursor 3 10
            setColor (clrList!!1)
            drawString "(press q to quit)"
            moveCursor 20 20

            drawTile (Tile "~" True 5)

            -- setColor (colorId 5)

            setColor x--(newColorID ColorBlue 5)
            -- (newColorID ColorBlue ColorBlue 5)
            -- drawString "testaaaaaaaaaaaaaaaaaaa"
            drawString "~~~~~~~"
            moveCursor 0 0
        render
        waitFor w (\ev -> ev == EventCharacter 'q' || ev == EventCharacter 'Q')
        )

waitFor :: Window -> (Event -> Bool) -> Curses ()
waitFor w p = loop where
    loop = do
        ev <- getEvent w Nothing
        case ev of
            Nothing -> loop
            Just ev' -> if p ev' then return () else loop



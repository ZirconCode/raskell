import UI.NCurses


main :: IO ()
main = runCurses $ do
    setEcho False
    w <- defaultWindow

    x <- newColorID ColorWhite ColorBlue 5
    
    -- fmap setColor x 

    updateWindow w $ do
        clear
        setColor defaultColorID
        moveCursor 1 10
        drawString "Hello world!"
        moveCursor 3 10
        drawString "(press q to quit)"
        moveCursor 20 20
        
        setColor x--(newColorID ColorBlue 5)
        -- (newColorID ColorBlue ColorBlue 5)
        -- drawString "testaaaaaaaaaaaaaaaaaaa"
        drawString "~~~~~~~"
        moveCursor 0 0
    render
    waitFor w (\ev -> ev == EventCharacter 'q' || ev == EventCharacter 'Q')

waitFor :: Window -> (Event -> Bool) -> Curses ()
waitFor w p = loop where
    loop = do
        ev <- getEvent w Nothing
        case ev of
            Nothing -> loop
            Just ev' -> if p ev' then return () else loop



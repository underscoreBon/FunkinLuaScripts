function onCreatePost()
    makeLuaText('Lyrics', '', screenWidth, 0, 480)
    setTextAlignment('Lyrics', 'center')
    addLuaText('Lyrics')
    screenCenter('Lyrics', 'x')
    setTextSize('Lyrics', 25)
end

function onEvent(eventName, value1, value2)
    if eventName == 'Lyrics' then
        setTextString('Lyrics', value1)
    end
    if eventName == 'FlashyFlash' then
        cameraFlash('game', getColorFromHex('FFFFF'), value1, false)
    end
end
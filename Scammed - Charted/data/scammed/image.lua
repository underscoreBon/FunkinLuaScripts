function onCreatePost()
    makeLuaSprite('image', 'scam', screenWidth, screenHeight)
    setObjectCamera('image', 'game')
    scaleObject('image', 1, 1)
    addLuaSprite('image', true)
    screenCenter('image', 'xy')
    setScrollFactor('image', 0,0)
end
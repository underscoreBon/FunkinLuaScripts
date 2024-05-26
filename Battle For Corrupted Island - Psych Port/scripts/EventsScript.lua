Chromacrap = 0;
shadersEnabled = false -- Just in case the player used a build without shaders

function boundTo(value, min, max)
    return math.max(min, math.min(max, value))
end
function math.lerp(from,to,i)return from+(to-from)*i end

function setChrome(chromeOffset)
    setShaderFloat("temporaryShader", "rOffset", chromeOffset);
    setShaderFloat("temporaryShader", "gOffset", 0.0);
    setShaderFloat("temporaryShader", "bOffset", chromeOffset * -1);
end

function onCreatePost()
    --luaDebugMode = true
    if shadersEnabled then
    setPropertyFromClass("openfl.Lib", "application.window.title", 'Friday Night Funkin\': Corrupted Island (Psych Port)')
    initLuaShader("vcr")
    
    makeLuaSprite("temporaryShader")
    makeGraphic("temporaryShader", screenWidth, screenHeight)
    
    setSpriteShader("temporaryShader", "vcr")
    
    addHaxeLibrary("ShaderFilter", "openfl.filters")
    runHaxeCode([[
        trace(ShaderFilter);
        game.camGame.setFilters([new ShaderFilter(game.getLuaObject("temporaryShader").shader)]);
        game.camHUD.setFilters([new ShaderFilter(game.getLuaObject("temporaryShader").shader)]);
    ]])
    end

    makeLuaText('Lyrics', '', screenWidth, 0, 480)
    setTextAlignment('Lyrics', 'center')
    addLuaText('Lyrics')
    screenCenter('Lyrics', 'x')
    setTextSize('Lyrics', 25)


    if not buildTarget == 'windows' then -- FUCK YOU PIRACY!
    makeLuaText('piratewarning', '/!\\ THIS MOD IS RUNNING ON A UNOFFCIAL SOURCE!!! GET THE ACTUAL MOD (or PORT) IF YOU CAN!!! /!\\', 0, 0, screenHeight - 20)
    setTextColor('piratewarning', "FF0000")
    setTextAlignment('piratewarning', 'center')
    addLuaText('piratewarning')
    screenCenter('piratewarning', 'x')
    setTextSize('piratewarning', 15)
    end
end

function onSongStart()
    runTimer('piratefade', 5)
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'piratefade' then
        doTweenAlpha('yarrrrrrrrrrrr', 'piratewarning', 0, 1, 'circInOut')
    end
end



function onUpdate(elapsed)
    if shadersEnabled then
    Chromacrap = math.lerp(Chromacrap, 0, boundTo(elapsed * 20, 0, 1))
    setChrome(Chromacrap)
    end
end

function onEvent(eventName, value1, value2)
    if eventName == 'Add Chromatic Abberation' then
        if shadersEnabled then
        Chromacrap = Chromacrap + value1
        end
    end
    if eventName == 'Lyrics' then
        setTextString('Lyrics', value1)
    end
end

function onDestroy()
    setPropertyFromClass("openfl.Lib", "application.window.title", 'Friday Night Funkin\': Psych Engine')
end
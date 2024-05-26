--[[Dave And Bambi 3.0 HUD]]--

-- Recreated by n_bonnie2
-- i know its low effort.

-- DO NOT STEAL!

topTextStuff = { -- For The Top text Stuff, it goes like  ['Song Name'] = 'The Top Text like in expunged songs'
    ['Dad Battle'] = 'You can Remove this, Its just an test',
    ['Song Name'] = 'The Top Text like in expunged songs'
}

creditsStuff  = { -- ['Song Name'] = 'Credit Text/icon (put in images/credits)/Heading (put in images/headings)'
    ['Dad Battle'] = 'Test/nb/daveHeading',
    ['Song Name'] = 'Credit Text/icon (put in images/credits)/Heading (put in images/headings)'
}

------------------------------------------------------------------------------
comboOffset = {}
creditsConstructor = {}

function onCreatePost()

    -- Getting Arrays
    comboOffset = getPropertyFromClass('ClientPrefs', 'comboOffset')

    -- Basic HUD
    makeLuaText("side", songName, 500, 5, screenHeight - 30)
    setTextSize("side", 18)
    setTextAlignment("side", "left")
    setObjectCamera("side", "hud")
    setTextFont('side', 'COMICBOLD.ttf')
    addLuaText("side")

    makeLuaText("side2", topTextStuff[songName], 500, 5, screenHeight - 50) -- i just wnated to make this
    setTextSize("side2", 18)
    setTextAlignment("side2", "left")
    setObjectCamera("side2", "hud")
    setTextFont('side2', 'COMICBOLD.ttf')
    addLuaText("side2")

    setObjectOrder('healthBarBG', getObjectOrder('healthBar') + 0.5)
    setObjectOrder('timeBarBG', getObjectOrder('timeBar') + 1)
    setObjectOrder('timeTxt', getObjectOrder('timeBar') + 2)
    screenCenter('timeBar', 'x')
    setTextFont('scoreTxt', 'COMICBOLD.ttf')
    setTextFont('timeTxt', 'COMICBOLD.ttf')
    setTimeBarColors('00ff00', '808080')
    setProperty('timeTxt.y', getProperty('timeTxt.y') - 5)

    -- Credits Stuff

    if creditsStuff[songName] == nil then -- [Prevents HUD from fucking up]
    --debugPrint('NOT making credits')
    else
    --debugPrint('making credits')
    creditsConstructor = LuaTextsplit(creditsStuff[songName],'/')
    --debugPrint(creditsConstructor)

    makeLuaText("creditText", creditsConstructor[1], 500, 5 - 500, 200) -- 5, 200
    setTextSize("creditText", 25)
    setTextAlignment("creditText", "left")
    setObjectCamera("creditText", "hud")
    setTextFont('creditText', 'COMICBOLD.ttf')
    addLuaText("creditText")

    makeLuaSprite('creditBorder', 'songHeadings/'..creditsConstructor[3], 0 - 500, 200) --0, 200
    setObjectCamera('creditBorder', 'hud')
    scaleObject('creditBorder', 1, 1)
    addLuaSprite('creditBorder')

    makeLuaSprite('creditIcon', 'credits/'..creditsConstructor[2], 320 - 500, 180) -- 320, 160
    setObjectCamera('creditIcon', 'hud')
    scaleObject('creditIcon', 0.7, 0.7)
    addLuaSprite('creditIcon')
    end


end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if not isSustainNote then
    if getPropertyFromClass('PlayState', 'isPixelStage') then -- combo but restored
        makeLuaSprite('combo' .. getProperty('combo'), 'pixelUI/combo-pixel', 500 + comboOffset[1], 400 - comboOffset[2])
        scaleObject('combo' .. getProperty('combo'), 4, 4)
        else
        makeLuaSprite('combo' .. getProperty('combo'), 'combo', 485 + comboOffset[1], 330 - comboOffset[2])
        scaleObject('combo' .. getProperty('combo'), 0.55, 0.55)
        end

		setObjectCamera('combo' .. getProperty('combo'), 'hud')
		addLuaSprite('combo' .. getProperty('combo'))
		setProperty('combo' .. getProperty('combo')..'.acceleration.y', 500)
        if getPropertyFromClass('PlayState', 'isPixelStage') then
        setProperty('combo'..getProperty('combo')..'.antialiasing', false)
        else
        setProperty('combo'..getProperty('combo')..'.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
        end

		setProperty('combo' .. getProperty('combo')..'.acceleration.y', getRandomInt(200, 300))
		setProperty('combo' .. getProperty('combo')..'.velocity.y', getProperty('combo' ..getProperty('combo')..'.velocity.y') - getRandomInt(140, 160))
		setProperty('combo' .. getProperty('combo')..'.velocity.x', getRandomInt(-5, 5))
		setProperty('combo' .. getProperty('combo')..'.visible', not getPropertyFromClass('ClientPrefs', 'hideHud'))

        runTimer('combo'..getProperty('combo'), crochet * 0.002, 1)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if string.find(tag, 'combo') then
		doTweenAlpha(tag, tag, 0, 0.2, 'linear')
	end
    if tag == 'creditLifetime' then
        doTweenX('StartE1', 'creditText', 5 - 500, 0.5, 'circOut')
        doTweenX('Start1E1', 'creditBorder', 0 - 500, 0.5, 'circOut')
        doTweenX('Start2E2', 'creditIcon', 320 - 500, 0.5, 'circOut')
    end
end

function LuaTextsplit(inputstr, sep) -- thanks to: https://stackoverflow.com/questions/1426954/split-string-in-lua, very useful
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

function onSongStart()
    doTweenX('Start', 'creditText', 5 + 50, 0.5, 'circOut')
    doTweenX('Start1', 'creditBorder', 0 + 50, 0.5, 'circOut')
    doTweenX('Start2', 'creditIcon', 320 + 50, 0.5, 'circOut')
    runTimer('creditLifetime', 4)
end

function onTweenCompleted(tag)
    if tag == 'Start' then
        doTweenX('StartA', 'creditText', 5, 0.25, 'circIn')
    end
    if tag == 'Start1' then
        doTweenX('Start1A', 'creditBorder', 0, 0.25, 'circIn')
    end
    if tag == 'Start2' then
        doTweenX('Start2A', 'creditIcon', 320, 0.25, 'circIn')
    end
end

-- screw this, im not adding the full icon bounce
function onBeatHit()
    if getProperty('healthBar.percent') >= 80 then   
    doTweenX('icon1', 'iconP1.scale', 1.5, 0.005, 'quartOut')
    doTweenX('icon2', 'iconP2.scale', 1, 0.1, 'quartOut')
    elseif getProperty('healthBar.percent') <= 20 then
    doTweenX('icon1', 'iconP1.scale', 1, 0.1, 'quartOut')
    doTweenX('icon2', 'iconP2.scale', 1.5, 0.005, 'quartOut')
    else
    doTweenX('icon1', 'iconP1.scale', 1, 0.1, 'quartOut')
    doTweenX('icon2', 'iconP2.scale', 1, 0.1, 'quartOut')
    end
end

function onUpdatePost()

    if getProperty('healthBar.percent') <= 80 then
    setProperty('iconP2.scale.y', (getProperty('iconP2.scale.y') - 1) / -2.5 + 1 )
    else 
    setProperty('iconP2.scale.y', 1)
    end

    if getProperty('healthBar.percent') >= 20 then
    setProperty('iconP1.scale.y', (getProperty('iconP1.scale.y') - 1) / -2.5 + 1 )
    else
    setProperty('iconP1.scale.y', 1)
    end

    setProperty('iconP1.origin.y', 0)
    setProperty('iconP2.origin.y', 0)
end
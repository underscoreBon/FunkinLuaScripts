function onCreatePost()
    boxElements = {390, 120, 20, (downscroll and 50 or 530), 8} -- w, h, x, y, outline size

    --Hides most HUD elements
    setProperty('healthBar.visible', false)
    setProperty('healthBarBG.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('timeBarBG.visible', false)
    --setProperty('iconP1.visible', false)
    setProperty('iconP2.visible', false)
    setProperty('scoreTxt.visible', false)
    setProperty('timeTxt.visible', false)
 

    -- UT Hud Elements
    makeLuaSprite('blackthing', nil, 0, 675)
    makeGraphic('blackthing', screenWidth,2300, '000000')
    setObjectCamera('blackthing', 'hud')
    addLuaSprite('blackthing', true)

    makeLuaSprite('boxPart1', nil, boxElements[3], boxElements[4])
    makeGraphic('boxPart1', boxElements[1], boxElements[2], 'FFFFFF')
    setObjectCamera('boxPart1', 'hud')
    addLuaSprite('boxPart1', true)

    makeLuaSprite('boxPart2', nil, boxElements[3] + (boxElements[5]), boxElements[4] + (boxElements[5])) -- + 10
    makeGraphic('boxPart2', boxElements[1] - (boxElements[5]*2), boxElements[2] - (boxElements[5]*2), '000000')
    setObjectCamera('boxPart2', 'hud')
    addLuaSprite('boxPart2', true)

    makeLuaText('yourScore', '* Score: 0\n* Misses: 0\n* Accuracy: 100% \n* [SFC]', screenWidth, 60, boxElements[4] + 10)
    setTextAlignment('yourScore', 'left')
    setTextSize('yourScore', 30)
    setTextFont('yourScore', 'Determination.ttf')
    addLuaText('yourScore')

    makeLuaSprite('HPred', nil, 400, 682)
    makeGraphic('HPred', 500, 25, 'FF0000')
    setObjectCamera('HPred', 'hud')
    addLuaSprite('HPred', true)

    makeLuaSprite('HPyellow', nil, 400, 682)
    makeGraphic('HPyellow', 500, 25, 'fff200')
    setObjectCamera('HPyellow', 'hud')
    addLuaSprite('HPyellow', true)

    makeLuaText('yourName', '', 200, 30, 680)
    setTextAlignment('yourName', 'left')
    setTextSize('yourName', 25)
    setTextFont('yourName', 'MNC.ttf')
    addLuaText('yourName')

    makeLuaText('yourLOVE', 'LV 19     Hp', screenWidth, 240, 680)
    setTextAlignment('yourLOVE', 'left')
    setTextSize('yourLOVE', 25)
    setTextFont('yourLOVE', 'MNC.ttf')
    addLuaText('yourLOVE')

    makeLuaText('yourhealth', '100 / 100', screenWidth, 920, 680)
    setTextAlignment('yourhealth', 'left')
    setTextSize('yourhealth', 25)
    setTextFont('yourhealth', 'MNC.ttf')
    addLuaText('yourhealth')

    makeLuaText('yourMisses', '- 0', screenWidth, 1115, 680)
    setTextAlignment('yourMisses', 'left')
    setTextSize('yourMisses', 25)
    setTextFont('yourMisses', 'MNC.ttf')
    addLuaText('yourMisses')
    setTextColor('yourMisses', 'FF0000')

    -- I hate Psych
    setRatingFC('?')
end

function onUpdatePost(elapsed)
    setProperty('iconP1.x', 1100)
    setProperty('iconP1.y', (downscroll and 50 or 540))
    makeGraphic('HPyellow', 500*(getProperty('healthBar.percent')/100), 25, 'fff200')
    setTextString('yourhealth', math.floor(getProperty('healthBar.percent'))..' / 100')
    setTextString('yourName', boyfriendName)
    setTextString('yourMisses', '- '..misses)
    if hits <= 0 then
    setTextString('yourScore', '* Score: '..score..'\n* Accuracy: ? \n* [N/A]')
    else 
    setTextString('yourScore', '* Score: '..score..'\n* Accuracy: '..(math.floor(getProperty('ratingPercent')*10000)/100)..'%\n* ['..ratingFC..']')
    end
end

function noteMiss(membersIndex, noteData, noteType, isSustainNote)
    playSound('hurt')
    if flashingLights then -- hello, eplispsy 
    setProperty('boyfriend.alpha', 1)
    missThing = 0
    runTimer('damageThingy', 0.05, 14)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'damageThingy' then
        --debugPrint('sand')
        if missThing == 0 then
            missThing = 1
            setProperty('boyfriend.alpha', 0.3)
        else
            missThing = 0
            setProperty('boyfriend.alpha', 1)
        end
        if loopsLeft == 0 then
            --debugPrint('awwww..')
            setProperty('boyfriend.alpha', 1)
        end
    end
end
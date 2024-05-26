-- script 100% by n_bonnie2!!!!
-- USE WITH CREDIT!!!!
attackmeter = 0
barx = 1200
bary = 180

function goodNoteHit(id, direction, noteType, isSustainNote)
    if not isSustainNote then
        attackmeter = attackmeter + 2
    else
        attackmeter = attackmeter + 0
    end
end


function onUpdatePost(elapsed)
    if not inGameOver then
        makeLuaSprite('BarUnderlay', '', barx, bary)
        makeLuaSprite('BarOverlay', '', barx + 5, bary + 300 - attackmeter*3 + 5)
        makeGraphic('BarUnderlay', 30, 310, '000000')
        makeGraphic('BarOverlay', 20, attackmeter*3, '00f7ff')
        setObjectCamera('BarUnderlay', 'hud')
        setObjectCamera('BarOverlay', 'hud')
        addLuaSprite('BarUnderlay', false)
        addLuaSprite('BarOverlay', false)

        health = getProperty('health')
        removeLuaText('meter', false)
            if attackmeter == 100 or attackmeter > 100 then
            makeLuaText('meter', '[100%]', 1000, 715, 520)
            else
            makeLuaText('meter', "["..attackmeter.."%]", 1000, 715, 520)
            end
        end
        setTextSize('meter', 20)
        setTextAlignment('meter', 'center')
        addLuaText('meter')
            if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SHIFT') then
               if attackmeter == 100 then
               playSound('attack', 0.8)
               attackmeter = 0
               setProperty('health', health + 0.5)
               setProperty('boyfriend.holdTimer', 0)
               cameraShake('game', 0.05, 0.3)
               playAnim('bf', 'attack', true)
        end
    end
end


function onSongStart()
    songStarted = true
    makeLuaText('d', 'When the Meter is Full, Press [SHIFT] To Attack' , 1280, 0, 500)
    setTextSize('d', 25)
    setTextAlignment('d', 'center')
    addLuaText('d')
    runTimer('deeznutsbegone', 4)
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'deeznutsbegone' then
    removeLuaText('d', false)
    end
end

function onUpdate(elapsed)
    if attackmeter > 100 then
        attackmeter = 100
        else
        if attackmeter < 0 then
        attackmeter = 0
        end
    end
end
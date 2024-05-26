canDodge = false

secondHealth = 1

directions = { -- Dont mess with this
    'left', 
    'down', 
    'up', 
    'right'
}

dodgeAnims = { -- Replace these with the dodge animations
    'dodgeLEFT',
    'dodgeDOWN',
    'dodgeUP',
    'dodgeRIGHT'
}

hurtAnims = { -- If there are multiple HURT animations also replace
    'hurt', 
    'hurt', 
    'hurt', 
    'hurt'
}

function onCreatePost()
    makeLuaSprite('2hpBG', nil, 0, getProperty('healthBar.y') - 60)
    makeGraphic('2hpBG', 400, 25, '000000')
    setObjectCamera('2hpBG', 'hud')
    addLuaSprite('2hpBG', false)
    screenCenter('2hpBG', 'x')

    makeLuaSprite('2hp', nil, 0, getProperty('healthBar.y') - (60 - 4))
    makeGraphic('2hp', 390, 15, '00FF2F')
    setObjectCamera('2hp', 'hud')
    addLuaSprite('2hp', false)
    screenCenter('2hp', 'x')
end

function onEvent(eventName, value1, value2)
    if eventName == 'Dodge Event' then
        makeAnimatedLuaSprite('warning', 'NOTE_assets', 0, 0)
        addAnimationByPrefix('warning', '1', 'purple0000') -- add animations because yes
        addAnimationByPrefix('warning', '2', 'blue0000')
        addAnimationByPrefix('warning', '3', 'green0000')
        addAnimationByPrefix('warning', '4', 'red0000')
        setObjectCamera('warning', 'hud')
        addLuaSprite('warning', true)
        screenCenter('warning')
        setProperty('warning.alpha', 0)
        if tonumber(value1) <= 4 then
            arrowID = value1
            playAnim('warning', tostring(arrowID), true)
            beatInt = crochet/1000
            runTimer('dodgeTimer', beatInt/4, 4) -- start timer
        else
            debugPrint('ERROR ON EVENT: Why did you go higher?') -- i hate myself!
        end
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'dodgeTimer' then 
        --debugPrint(loopsLeft)
        if loopsLeft == 0 then 
        canDodge = true
        runTimer('dodgeTime', 0.2)
        playSound('confirmMenu', 1) -- Tick sound here
        else 
            if loopsLeft == 3 or loopsLeft == 1 then 
                playSound('scrollMenu', 1) -- Attack sound here
                setProperty('warning.alpha', 1)
                doTweenAlpha('warningBack', 'warning', 0, beatInt, 'linear')
            end
        end
    end
    if tag == 'dodgeTime' then 
        if canDodge then --                |
            damage() -- damages the player V
        end
        canDodge = false
    end
end

function onUpdate(elapsed)
    if keyJustPressed(directions[tonumber(arrowID)]) then
        if canDodge then
            canDodge = false
            dodge()
        end
    end
end

function onUpdatePost(elapsed)
    setProperty('2hp._frame.frame.width', (math.lerp(0, 390, secondHealth)))
    if secondHealth <= 0 then
        setProperty('health', 0)
    end
end

function damage() -- function for the damage
    --debugPrint('OOF!')
    --setHealth(getHealth() - 0.25)
    secondHealth = secondHealth - 0.1
    triggerEvent('Play Animation', hurtAnims[tonumber(arrowID)], 'bf')
end

function dodge() -- function for dodge
    --debugPrint('DODGE!')
    setProperty('boyfriend.specialAnim', true)
    triggerEvent('Play Animation', dodgeAnims[tonumber(arrowID)], 'bf')
end


function math.lerp(a, b, t)
	return a + t * (b - a);
end

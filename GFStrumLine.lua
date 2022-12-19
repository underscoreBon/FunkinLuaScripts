notes = 4
arrowIdles = {'arrowLEFT', 'arrowDOWN', 'arrowUP', 'arrowRIGHT'}
arrowAnimations = {'left confirm', 'down confirm', 'up confirm', 'right confirm'}
 
function onCreatePost()
    for i = 1, notes do
    makeAnimatedLuaSprite('fakeNote'..i, 'NOTE_assets', getCharacterX('gf') + (125) + (115 * (i - 1)), getCharacterY('gf') + 250) -- THIS DOES NOT WORK WITH NOTESKINS AND PIXEL STAGES!!!!
    addAnimationByPrefix('fakeNote'..i, 'confirm', arrowAnimations[i], 24, false)
    addAnimationByPrefix('fakeNote'..i, 'idle', arrowIdles[i], 24, false)
    scaleObject('fakeNote'..i, 0.7, 0.7)
    addLuaSprite('fakeNote'..i, true)
    playAnim('fakeNote'..i, 'idle', true)
    setProperty('fakeNote'..i..'.alpha', 0)
    end
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if getPropertyFromGroup('notes', membersIndex, 'gfNote') then
    local realND = (noteData + 1)
    playAnim('fakeNote'..realND, 'confirm', true)
    setProperty('fakeNote'..realND..'.offset.x', 64)
    setProperty('fakeNote'..realND..'.offset.y', 63)
    runTimer('returnIdle'..realND, 0.1 , 1)
    end
end

-- is there a easier way to do this?
function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'returnIdle1' then
        setProperty('fakeNote1.offset.x', 34.5)
        setProperty('fakeNote1.offset.y', 34.8)
        playAnim('fakeNote1', 'idle', true)
    end
    
    if tag == 'returnIdle2' then
        setProperty('fakeNote2.offset.x', 34.5)
        setProperty('fakeNote2.offset.y', 34.8)
        playAnim('fakeNote2', 'idle', true)
    end

    if tag == 'returnIdle3' then
        setProperty('fakeNote3.offset.x', 34.5)
        setProperty('fakeNote3.offset.y', 34.8)
        playAnim('fakeNote3', 'idle', true)
    end

    if tag == 'returnIdle4' then
        setProperty('fakeNote4.offset.x', 34.5)
        setProperty('fakeNote4.offset.y', 34.8)
        playAnim('fakeNote4', 'idle', true)
    end
end

function onUpdatePost(elapsed) -- ignore = note will not be hit, the fix is rewriting the hit
    if getSongPosition() > 0 then
    for waitisthis = 1, notes do -- Fake Notes share 'visible' and 'alpha' with GF
        setProperty('fakeNote'..waitisthis..'.visible', getProperty('gf.visible'))
        setProperty('fakeNote'..waitisthis..'.alpha', getProperty('gf.alpha'))
    end
    end

    for ii = 0, getProperty('notes.length')-1 do -- iterates over all- wait...

        if getPropertyFromGroup('notes', ii, 'gfNote') then -- check if it's a girlfriend note

            if not getPropertyFromGroup('notes', ii, 'mustPress') then

            setPropertyFromGroup('notes', ii, 'alpha', 0)
            setPropertyFromGroup('notes', ii, 'ignoreNote', true)

            if getPropertyFromGroup('notes', ii, 'strumTime') - getPropertyFromClass('Conductor', 'safeZoneOffset') * 0.2 < getSongPosition() then

                local realND = (getPropertyFromGroup('notes', ii, 'noteData') + 1)
                local singingAnims = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'}
                playAnim('fakeNote'..realND, 'confirm', true)
                setProperty('fakeNote'..realND..'.offset.x', 64)
                setProperty('fakeNote'..realND..'.offset.y', 63)
                runTimer('returnIdle'..realND, 0.1 , 1)
                setProperty('gf.holdTimer', 0)
                playAnim('gf', singingAnims[realND], true)
                setPropertyFromGroup('notes', ii, 'active', false)
                removeFromGroup('notes', ii, false)

            end
            setPropertyFromGroup('notes', ii, 'ignoreNote', false)
            end
        else

        end

    end
end

function onCountdownTick(swagCounter)
    if getProperty('gf.visible') == true then -- why...
    if swagCounter == 0 then
        doTweenAlpha('alphawolf1', 'fakeNote1', 1, 0.5, 'circInOut')
    elseif swagCounter == 1 then
        doTweenAlpha('alphawolf2', 'fakeNote2', 1, 0.5, 'circInOut')
    elseif swagCounter == 2 then
        doTweenAlpha('alphawolf3', 'fakeNote3', 1, 0.5, 'circInOut')
    elseif swagCounter == 3 then
        doTweenAlpha('alphawolf4', 'fakeNote4', 1, 0.5, 'circInOut')
    end   
    end
end

function onSongStart()
    if getProperty('gf.visible') == true then -- why... 2
    for i = 1, notes do
    setProperty('fakeNote'..i..'.alpha', 1)
    end
    end
end

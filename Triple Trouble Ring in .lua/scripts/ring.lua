
--[[Triple Trouble Ring in .lua]]--

-- Script and Pixel Ring Sprites by: n_bonnie2
-- Tails Get Trolled Crosshair Script (for template) by: heat_ on gamebanana
-- Mechanic and Regular Ring sprites from: The FNF: Vs Sonic.exe Mod 

-- USE WITH CREDIT, or if you choose to not to credit, keep the comments

-- use "triggerEvent('Toggle Ring Mechanic', true, nil)" in order to activated in a script
-- i dont blame you for not reading the README.txt lmao

-- i know this is messy, im a messy person

-- and yes, this is the ring used in THAT D-sides sonic.exe mod

-- THIS IS THE 0.7 REWRITE!

playbackRate = 1 -- ignore

---------------------------------------------------------------------------------------
--[[ RING CONFIG ]]--

ringRating = false -- ring notes give rating when hit if "true" (Judgements do not show up... unfortunately.)
ringMiss = false -- ring notes give misses if missed if "true"
ringMissDamage = false -- ring notes take damage when missed if "true"
rings = 0 -- how much rings do you start with.

---------------------------------------------------------------------------------------
HitRing = false
ringpos = {}
ringoffsets = {}
ringmechanic = false
swapped = false

function onCreatePost()
    --luaDebugMode = true 
    isPixel = getPropertyFromClass('states.PlayState', 'isPixelStage')
    
    if middlescroll and not downscroll then
        ringpos = {580, 50}
    end
    if middlescroll and downscroll then
        ringpos = {580, screenHeight - 150}
    end
    if not middlescroll and not downscroll then
        ringpos = {900, 50}
    end
    if not middlescroll and downscroll then
        ringpos = {900, screenHeight - 150}
    end

    ringoffsets = {0, 0}

    if not isPixel then 
    makeAnimatedLuaSprite('strumring', 'ring', ringpos[1], ringpos[2]);
    else
    makeAnimatedLuaSprite('strumring', 'pixelUI/ring', ringpos[1], ringpos[2]);
    end
    setObjectCamera('strumring', 'hud')

    if isPixel then 
    frames = 12
    setProperty('strumring.antialiasing', false)
    scaleObject('strumring', 0.7 * (1 / 0.7) * 6, 0.7 * (1 / 0.7) * 6); -- pixel flixel (haha rhymes)
    else
    frames = 24
	scaleObject('strumring', 0.7, 0.7);
    end

	addLuaSprite('strumring', false);

    addAnimationByPrefix('strumring', 'strum', 'arrowSPACE', frames, false) -- ring animations
    addAnimationByPrefix('strumring', 'press', 'space press', frames, false)
    addAnimationByPrefix('strumring', 'glow', 'space confirm', frames, false)

    setProperty('strumring.alpha', 0)
    playAnim('strumring', 'strum', true)
end

function onUpdate(elapsed)
    setTextString('rings', rings) -- updates ring count
    updateOffsets()
end

function onUpdatePost(elapsed)
	for i = 0, getProperty('notes.length')-1 do
		if getPropertyFromGroup('notes', i, 'noteType') == 'RingNote' then
            
            setPropertyFromGroup('notes', i, 'rgbShader.enabled', false) -- FUCK YOU NEW RGB NOTE SYETEM!
            Noffset1 = defaultOpponentStrumY0 - getPropertyFromGroup('strumLineNotes', getPropertyFromGroup('notes', i, 'noteData'), 'y') 
            Noffset2 = ringpos[2] - getProperty('strumring.y')
            setPropertyFromGroup('notes', i, 'blockHit', true)

            local hehe = Noffset1 - Noffset2 + getPropertyFromGroup('notes', i, 'y')
            setPropertyFromGroup('notes', i, 'y', hehe)

			if not getPropertyFromGroup('notes', i, 'isSustainNote') and getPropertyFromGroup('notes', i, 'strumTime') - getPropertyFromClass('backend.Conductor', 'safeZoneOffset') * 0.7 < getSongPosition() then
				if keyboardJustPressed('SPACE') and not getProperty('boyfriend.stunned')then 
					HitRing = true
					playAnim('strumring', 'glow', true)
                    updateOffsets()
					Hit(i, false);
				end
			end

            if not getPropertyFromGroup('notes', i, 'isSustainNote') and getPropertyFromGroup('notes', i, 'strumTime') - getPropertyFromClass('backend.Conductor', 'safeZoneOffset') * 0.2 < getSongPosition() then
				if botPlay then 
					HitRing = true
					playAnim('strumring', 'glow', true)
                    updateOffsets()
					Hit(i, false);
                    runTimer('botplay idle', 0.1)
				end
			end

            if getPropertyFromGroup('notes', i, 'isSustainNote') and getPropertyFromGroup('notes', i, 'strumTime') - getPropertyFromClass('backend.Conductor', 'safeZoneOffset') * 0.2 < getSongPosition() then
				if keyboardJustPressed('SPACE') and not getProperty('boyfriend.stunned') or botPlay then 
					HitRing = true
					playAnim('strumring', 'glow', true)
                    updateOffsets()
					Hit(i, true);
                    if botPlay then
                    runTimer('botplay idle', 0.1)
                    end
				end
			end

			if getSongPosition() > getPropertyFromGroup('notes', i, 'strumTime') + (300 / getProperty('songSpeed')) then -- miss
				Miss(i, getPropertyFromGroup('notes', i, 'isSustainNote'));
			end
            
            if not getPropertyFromGroup('notes', i, 'isSustainNote') then  -- "offset" shit
            setPropertyFromGroup('notes', i, 'x', getProperty('strumring.x'));
			setPropertyFromGroup('notes', i, 'alpha', getPropertyFromGroup('playerStrums', 0, 'alpha')); 
            else
            if isPixel then
            setPropertyFromGroup('notes', i, 'x', getProperty('strumring.x') + 28);                
            else
            setPropertyFromGroup('notes', i, 'x', getProperty('strumring.x') + 36);
            end
            setPropertyFromGroup('notes', i, 'alpha', 0.7); 
            end
        end
 	end

    if not botPlay then
    if keyboardJustPressed('SPACE') and ringmechanic and not HitRing then
        if not HitRing and not ghostTapping then
        RingGhostTap()
        end
        playAnim('strumring', 'press', true)
        HitRing = false
        updateOffsets()
    end

    if keyboardReleased('SPACE') then
        playAnim('strumring', 'strum', true)
        HitRing = false
        updateOffsets()
    end
end
end


-- Hit and miss ring functions
function Hit(id, issussy)
    if not issussy then
    rings = rings + 1
    playSound('Ring', 0.5);
    end
	--setPropertyFromGroup('notes', id, 'visible', false); 
	setPropertyFromGroup('notes', id, 'active', false); 
    if ringRating then
        strumTime = getPropertyFromGroup('notes', id, 'strumTime') -- haha
        songPos = getPropertyFromClass('backend.Conductor', 'songPosition')
        rOffset = getPropertyFromClass('backend.ClientPrefs','data.ratingOffset')

        if (strumTime - songPos + rOffset) < 0 then -- get ms
        msabsolute = (strumTime - songPos + rOffset) * -1
        else
        msabsolute = (strumTime - songPos + rOffset)
        end

        addHits(1)
        setProperty('combo', getProperty('combo') + 1)

        if msabsolute <= getPropertyFromClass('backend.ClientPrefs', 'data.sickWindow')*playbackRate then
        addScore(350)
        elseif msabsolute <= getPropertyFromClass('backend.ClientPrefs', 'data.goodWindow')*playbackRate then
        addScore(150)
        elseif msabsolute <= getPropertyFromClass('backend.ClientPrefs', 'data.badWindow')*playbackRate then
        addScore(100)
        else
        addScore(50)
        end
    end
	removeFromGroup('notes', id, false);
end

function Miss(id, issussy)
	--setPropertyFromGroup('notes', id, 'visible', false); 
	setPropertyFromGroup('notes', id, 'active', false); 
    if ringMiss then
        addMisses(1)
        setProperty('combo', 0)
        addScore(-10)
        if ringMissDamage then
        if issussy then
        setProperty('health', getProperty('health') - 0.004)
        else
        playSound('missnote'..math.random(1,3), 0.5)
        setProperty('health', getProperty('health') - getPropertyFromGroup('notes', id, 'missHealth'))
        end
        end
    end
	removeFromGroup('notes', id, false);
end

function noteMiss(id, noteData, noteType, sussy)
    if getPropertyFromGroup('notes', id, 'missHealth') > 0 then -- hurt notes no count B)
    misshp = getPropertyFromGroup('notes', id, 'missHealth')
    else
    misshp = 0
    end
    if rings > 0 and ringmechanic then
        if misses > 0 then
        addMisses(-1)
        setProperty('health', getProperty('health') + misshp)
        rings = rings -1
        end
    end
end


-- the thing.
function ringMech(bool)
    if bool and not ringmechanic then
    ringmechanic = true
    makeyStuff()
    -- tweens shitty
    doTweenAlpha('funny1', 'strumring', 1, 0.5, 'circInOut')
    for i = 4, 5 do
    noteTweenX('funnynote'..i..'', i, getPropertyFromGroup('strumLineNotes', i, 'x') - 56, 0.5, 'circInOut')
    end
    for i = 6, 7 do
    noteTweenX('funnynote'..i..'', i, getPropertyFromGroup('strumLineNotes', i, 'x') + 56, 0.5, 'circInOut')
    end
else
    if not bool and ringmechanic then
    ringmechanic = false
    doTweenAlpha('funny1', 'strumring', 0, 0.5, 'circInOut')
        for i = 4, 5 do
            noteTweenX('funnynote'..i..'', i, getPropertyFromGroup('strumLineNotes', i, 'x') + 56, 0.5, 'circInOut')
        end
        for i = 6, 7 do
           noteTweenX('funnynote'..i..'', i, getPropertyFromGroup('strumLineNotes', i, 'x') - 56 , 0.5, 'circInOut')
        end
        end
    end
end


-- EVENTS
function onEvent(n,i,ii)
    if n == 'Toggle Ring Mechanic' then
        if i == 'true' then
            ringMech(true)
        else if i == 'false' then
            ringMech(false)
        end
        end
    end
    if not middlescroll then
        if n == 'Swap Strums' then
        if not swapped then
            swapped = true
            for strums = 0,4 do
                setPropertyFromGroup('playerStrums', strums,'x',92 + (112 * strums))
                setPropertyFromGroup('opponentStrums', strums,'x',732 + (112 * strums))
            end
        if ringmechanic then
            for i = 4, 5 do
                noteTweenX('funnynote'..i..'', i, getPropertyFromGroup('strumLineNotes', i, 'x') - 56, 0.0001, 'circInOut')
            end
            for i = 6, 7 do
                noteTweenX('funnynote'..i..'', i, getPropertyFromGroup('strumLineNotes', i, 'x') + 56, 0.0001, 'circInOut')
            end
            setProperty('strumring.x', 260)
        end
        elseif swapped then
            swapped = false
            for strums = 0,4 do
                setPropertyFromGroup('playerStrums', strums,'x',732 + (112 * strums))
                setPropertyFromGroup('opponentStrums', strums,'x',92 + (112 * strums))
            end
            if ringmechanic then
            for i = 4, 5 do
                noteTweenX('funnynote'..i..'', i, getPropertyFromGroup('strumLineNotes', i, 'x') - 56, 0.0001, 'circInOut')
            end
            for i = 6, 7 do
                noteTweenX('funnynote'..i..'', i, getPropertyFromGroup('strumLineNotes', i, 'x') + 56, 0.0001, 'circInOut')
            end
            setProperty('strumring.x', 900)
               end
            end
        end
     end
end


function updateOffsets()
    if HitRing then
        if not isPixel then
        ringoffsets = {48, 45}
        else
        ringoffsets = {-42, -40}
        end
    else
        if not isPixel then
        ringoffsets = {22, 20}
        else
        ringoffsets = {-42, -40}
        end
    end
setProperty('strumring.offset.x', ringoffsets[1])
setProperty('strumring.offset.y', ringoffsets[2])
end

function onGhostTap(key)
    runTimer('PostGhostTap', 0.0001)
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'PostGhostTap' then
        if not ghostTapping then -- Gregly (Sonicgamer2000)#7209 on discord for making me remember them
        if ringmechanic then
            if rings > 0 then
                if misses > 0 then
                addMisses(-1)
                setProperty('health', getProperty('health') + 0.05)
                rings = rings -1
                end
            end
        end
    end
    end
    if tag == 'botplay idle' then
        playAnim('strumring', 'strum', true)
        HitRing = false
        updateOffsets()
    end
end

function RingGhostTap()
    playSound('missnote'..math.random(1,3), 0.5);
    addScore(-10)
    addMisses(1)
    setProperty('combo', 0)
    setProperty('health', getProperty('health') - 0.05)
    runTimer('PostGhostTap', 0.0001)
end

function makeyStuff()
    if not downscroll then
        makeLuaText("rings","0", 1000, 1200, 600)
        else
        makeLuaText("rings","0", 1000, 1200, 0)
    end
    if not downscroll then
        makeLuaSprite('counter', 'Counter', 1120, 610);
        else
        makeLuaSprite('counter', 'Counter', 1120, 10);
    end
    setTextSize("rings", 75)
    setTextAlignment("rings", "left")
    setObjectCamera("rings", "hud")
    setTextColor('rings', 'fbff00')
    setTextFont('rings', 'sonc.ttf')
    setTextBorder('rings', '4', 'ffbb00')
    addLuaText("rings")
    setObjectCamera('counter', 'hud')
    scaleObject('counter', 1, 1);
    addLuaSprite('counter', false);
end

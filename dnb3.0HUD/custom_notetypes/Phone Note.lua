function onCreate()
    for i = 0, getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Phone Note' then
            setPropertyFromGroup('unspawnNotes', i, 'texture', 'noteTypes/NOTE_phone'); --Change texture
            setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0.023'); --Default value is: 0.023, health gained on hit
            setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0.0475'); --Default value is: 0.0475, health lost on miss
            setPropertyFromGroup('unspawnNotes', i, 'noAnimation', true);
        end
    end
end

function noteMiss(id, noteData, noteType, isSustainNote)
    if noteType == 'Phone Note' then
        debugPrint('phoney missed', noteData)
        setPropertyFromGroup('playerStrums', noteData, 'alpha', 0)
        triggerEvent('Play Animation', 'hurt', 'bf')
        runTimer('phoneCooldown'..noteData, 5)
    end
end

function goodNoteHit(id, noteData, noteType, isSustainNote)
    if noteType == 'Phone Note' then
        triggerEvent('Play Animation', 'dodge', 'bf')
    end
end

function onUpdatePost(elapsed)
    for i = 0, getProperty('notes.length')-1 do
        if getPropertyFromGroup('notes', i, 'noteType') == 'Phone Note' then
            if not getPropertyFromGroup('notes', i, 'isSustainNote') then
            setPropertyFromGroup('notes', i, 'offset.x', -8);
            end
        end
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    for i = 0, 3 do 
        if tag == 'phoneCooldown'..i then
            noteTweenAlpha('theFadeBack'..i, i + 4, 1, 10, 'linear')
        end
    end
end
function onCreate()
    for i = 0, getProperty('unspawnNotes.length')-1 do
        if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Shape Note' then
            setPropertyFromGroup('unspawnNotes', i, 'texture', 'noteTypes/NOTE_assets_Shape'); --Change texture
            setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0.023'); --Default value is: 0.023, health gained on hit
            setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0.0475'); --Default value is: 0.0475, health lost on miss
        end
    end
end

function onUpdatePost(elapsed)
    for i = 0, getProperty('notes.length')-1 do
        if getPropertyFromGroup('notes', i, 'noteType') == 'Shape Note' then
            if keyPressed('space') then
                setPropertyFromGroup('notes', i, 'alpha', 1)
            else
                setPropertyFromGroup('notes', i, 'alpha', 0.4)
                if not getPropertyFromGroup('notes', i, 'isSustainNote') then
                setPropertyFromGroup('notes', i, 'canBeHit', false)
                end
            end
        end
    end
end

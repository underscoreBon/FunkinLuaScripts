hudFaded = false

function onEvent(eventName, value1, value2)
    if eventName == 'Fade HUD' then 
        if hudFaded then
            hudFaded = false
            doTweenAlpha('FADEHUD', 'camHUD', 1, value1, 'circInOut')
        else
            hudFaded = true
            doTweenAlpha('FADEHUD', 'camHUD', 0, value1, 'circInOut')
        end
    end
end
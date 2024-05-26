function onEvent(eventName, value1, value2)
    if eventName == 'Spin' then 
        for i = 0,7 do 
            noteTweenAngle('spinny'..i, i, 360, 0.4, 'circInOut')
        end
        doTweenAngle('spinnyring', 'strumring', 360, 0.4, 'circInOut')
    end
end
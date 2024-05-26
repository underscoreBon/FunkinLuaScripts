function onEvent(eventName, value1, value2)
    if eventName == 'CamZoom' then 
        if value1 == 'add' then 
            setProperty('defaultCamZoom', getProperty('defaultCamZoom') + tonumber(value2))
        else 
            setProperty('defaultCamZoom', tonumber(value2))
        end
    end
end
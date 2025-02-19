 specialPoints = 15
 maxSpecialPoints = 15

 maxVisualHP = 30


function onCreatePost()
    luaDebugMode = true

    makeLuaSprite('cardinside', 'FrameInside', (middlescroll and 220 or 550), (downscroll and 20 or 525))
    scaleObject('cardinside', 4, 4)
    setObjectCamera('cardinside', 'hud')
    setProperty('cardinside.antialiasing', false)
    addLuaSprite('cardinside', true)

    makeLuaSprite('cardoutline', 'FrameOutline', getProperty("cardinside.x"), getProperty("cardinside.y"))
    scaleObject('cardoutline', 4, 4)
    setObjectCamera('cardoutline', 'hud')
    setProperty('cardoutline.antialiasing', false)
    addLuaSprite('cardoutline', true)

    makeLuaText('namelabel', boyfriendName, 250, getProperty("cardinside.x") + 15 , getProperty("cardinside.y") + 20)
    setTextAlignment('namelabel', 'left')
    setTextFont('namelabel', 'PressStart2P.ttf')
    setTextSize('namelabel', 16)
    addLuaText('namelabel')
    setTextColor('namelabel', 'ffffff')

    makeLuaText('hplabel', 'HP', 200, getProperty("cardinside.x") + 15 , getProperty("cardinside.y") + 75)
    setTextAlignment('hplabel', 'left')
    setTextFont('hplabel', 'PressStart2P.ttf')
    setTextSize('hplabel', 26)
    addLuaText('hplabel')
    setTextColor('hplabel', 'ffffff')

    makeLuaText('splabel', 'SP', 200, getProperty("cardinside.x") + 15 , getProperty("cardinside.y") + 125)
    setTextAlignment('splabel', 'left')
    setTextFont('splabel', 'PressStart2P.ttf')
    setTextSize('splabel', 26)
    addLuaText('splabel')
    setTextColor('splabel', 'ffffff')

    makeLuaSprite('timecard', 'BTTimer', screenWidth - 165, (downscroll and 10 or screenHeight - 165))
    scaleObject('timecard', 4, 4)
    setObjectCamera('timecard', 'hud')
    setProperty('timecard.antialiasing', false)
    addLuaSprite('timecard', true)

    makeLuaText('timelabel', "", 265, getProperty("timecard.x") - 50 , getProperty("timecard.y") + 60)
    setTextAlignment('timelabel', 'center')
    setTextFont('timelabel', 'PressStart2P.ttf')
    setTextSize('timelabel', 48)
    setTextBorder("timelabel", 4, "000000")
    addLuaText('timelabel')
    setTextColor('timelabel', 'ffffff')

    makeLuaText('scorelabel', 'Score: 0\nAccuracy: 0% - ?\nMisses: 0', 500, getProperty("cardinside.x") + 190 , getProperty("cardinside.y") + (downscroll and 20 or 150))
    setTextAlignment('scorelabel', 'left')
    setTextFont('scorelabel', 'PressStart2P.ttf')
    setTextSize('scorelabel', 12)
    addLuaText('scorelabel')
    setTextColor('scorelabel', 'ffffff')

    setRatingFC("N/A")
end



function onUpdatePost(elapsed)
    setProperty('healthBar.visible', false)
    setProperty('healthBarBG.visible', false)
    setProperty('timeBar.visible', false)
    setProperty('timeBarBG.visible', false)
    setProperty('timeTxt.visible', false)
    setProperty('scoreTxt.visible', false)
    setProperty('iconP2.visible', false)

    setProperty('iconP1.x', getProperty("cardinside.x") - 30)
    setProperty('iconP1.y', getProperty("cardinside.y") - (downscroll and -150 or 120))

    setProperty('iconP1.flipX', true)

    if not inGameOver then 
        local hp = math.floor((getHealth()/2)*maxVisualHP)

        setTextString("timelabel", math.floor((songLength -  getSongPosition())/1000))

        setTextString("scorelabel", "Score: "..score.."\nAccuracy: "..math.floor(math.floor(rating * 10000) / 100).."% \nMisses: "..misses.." - "..ratingFC)

        for i = 1,3 do 
            removeLuaSprite('hphumber'..i, false)
            if i > string.len(hp) then 
                break
            end
            -- i love humbers
            makeLuaSprite('hphumber'..i, 'block_number/'..string.sub(hp, string.len(hp) - (i - 1), string.len(hp) - (i - 1)), getProperty("cardinside.x") + 137 - (27 * (i - 1)), getProperty("cardinside.y") + 73)
            scaleObject('hphumber'..i, 2.75, 2.75)
            setObjectCamera('hphumber'..i, 'hud')
            setProperty('hphumber'..i..'.antialiasing', false)
            addLuaSprite('hphumber'..i, true)
            setProperty('hphumber'..i..'.color', getColorFromHex(rgbToHex(hslToRgb(.5 * (getHealth()/2), .75, .5))))
        end
    
        local sp = math.floor(specialPoints)
        for i = 1,string.len(sp) do 
            removeLuaSprite('sphumber'..i, false)
            if i > string.len(sp) then 
                break
            end
            -- i love humbers
            makeLuaSprite('sphumber'..i, 'block_number/'..string.sub(sp, string.len(sp) - (i - 1), string.len(sp) - (i - 1)), getProperty("cardinside.x") + 137 - (27 * (i - 1)), getProperty("cardinside.y") + 125)
            scaleObject('sphumber'..i, 2.75, 2.75)
            setObjectCamera('sphumber'..i, 'hud')
            setProperty('sphumber'..i..'.antialiasing', false)
            addLuaSprite('sphumber'..i, true)
            setProperty('sphumber'..i..'.color', getColorFromHex(rgbToHex(hslToRgb(.5 * (specialPoints/maxSpecialPoints), .75, .5))))
        end

        local offset = 0
        for i = 1,3 do 
            -- render ATK (hp gain)
            if i == 1 then 
                local option = getPropertyFromClass("backend.ClientPrefs", "data.gameplaySettings.healthgain", true) - 1
                if not (option == 0) then
                    makeLuaSprite('atkicon', 'BTAttack', getProperty("cardinside.x") + 136 - offset, getProperty("cardinside.y") - (downscroll and -200 or 40))
                    scaleObject('atkicon', 2, 2)
                    setObjectCamera('atkicon', 'hud')
                    setProperty('atkicon.antialiasing', false)
                    addLuaSprite('atkicon', true)
            
                    makeLuaText('atklabel', "+ 0", 72, getProperty("atkicon.x") - 15, getProperty("atkicon.y") - 15)
                    setTextAlignment('atklabel', 'center')
                    setTextFont('atklabel', 'PressStart2P.ttf')
                    setTextSize('atklabel', 12)
                    addLuaText('atklabel')
                    setTextColor('atklabel', 'ffffff')

                    if option > 0 then
                        setTextString("atklabel", "+"..option)
                    else 
                        setTextString("atklabel", "-"..-option)
                    end

                    offset = offset + 40
                end
            end
            -- render DEF (health loss)
            if i == 2 then 
                local option = getPropertyFromClass("backend.ClientPrefs", "data.gameplaySettings.healthloss", true) - 1
                if not (option == 0) then
                    makeLuaSprite('deficon', 'BTDefense', getProperty("cardinside.x") + 136 - offset, getProperty("cardinside.y") - (downscroll and -200 or 40))
                    scaleObject('deficon', 2, 2)
                    setObjectCamera('deficon', 'hud')
                    setProperty('deficon.antialiasing', false)
                    addLuaSprite('deficon', true)
            
                    makeLuaText('deflabel', "+ 0", 72, getProperty("deficon.x") - 15, getProperty("deficon.y") - 15)
                    setTextAlignment('deflabel', 'center')
                    setTextFont('deflabel', 'PressStart2P.ttf')
                    setTextSize('deflabel', 12)
                    addLuaText('deflabel')
                    setTextColor('deflabel', 'ffffff')

                    if option > 0 then
                        setTextString("deflabel", "-"..option)
                    else 
                        setTextString("deflabel", "+"..-option)
                    end
                end
                
                offset = offset + 40
            end
        end

    end

    local color = rgbToHex(getProperty('boyfriend.healthColorArray'))
    setProperty('cardinside.color', getColorFromHex(color))
end

function rgbToHex(array)
	return string.format('%.2x%.2x%.2x', array[1], array[2], array[3])
end

function hslToRgb(h, s, l)
    local r, g, b
  
    if s == 0 then
      r, g, b = l, l, l -- achromatic
    else
      function hue2rgb(p, q, t)
        if t < 0   then t = t + 1 end
        if t > 1   then t = t - 1 end
        if t < 1/6 then return p + (q - p) * 6 * t end
        if t < 1/2 then return q end
        if t < 2/3 then return p + (q - p) * (2/3 - t) * 6 end
        return p
      end
  
      local q
      if l < 0.5 then q = l * (1 + s) else q = l + s - l * s end
      local p = 2 * l - q
  
      r = hue2rgb(p, q, h + 1/3)
      g = hue2rgb(p, q, h)
      b = hue2rgb(p, q, h - 1/3)
    end
  
    return {r * 255, g * 255, b * 255}
  end
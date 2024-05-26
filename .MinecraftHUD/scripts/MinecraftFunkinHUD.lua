healthSkin = 'normal' -- 'normal' or 'hardcore'
hunger = 1 -- JUST IN CASE IF YOU WANT IT! ( goes from 0 to 1 )
items = { -- you can add custom items here so yeah. {'item texture(in images/items)', 'Display Name', Is it Enchnated? (true/false), stack size}
  {'microphone', 'Microphone', false, 1}, -- 1
  {'empty', '', false, 1}, -- 2
  {'empty', '', false, 1}, -- 3
  {'empty', '', false, 1}, -- 4
  {'empty', '', false, 1}, -- 5
  {'empty', '', false, 1}, -- 6
  {'stick', 'Debug Mode', true, 1}, -- 7, Debug Menu
  {'armor_stand', 'Character Editor', true, 1}, -- 8, Character Editor
  {'empty', '', true, 1} -- 9
}

-- DONT MESS WITH UNLESS YOU KNOW WHAT YOU ARE DOING!!!!!
scalething = 3
curItem = 1
pastitems = {
  {'', '', false, 1},
  {'', '', false, 1},
  {'', '', false, 1},
  {'', '', false, 1},
  {'', '', false, 1},
  {'', '', false, 1},
  {'', '', false, 1},
  {'', '', false, 1},
  {'', '', false, 1},
}

function onCreatePost()
  luaDebugMode = true

  initSaveData('options', 'nb2MCHUD')
  if getDataFromSave('options', 'screenRotate', true) == nil then 
      setDataFromSave('options', 'screenRotate', true)
  end
  if getDataFromSave('options', 'hurtSound', true) == nil then 
      setDataFromSave('options', 'hurtSound', true)
  end
  flushSaveData('options')

  daddycolor = rgbToHex(getProperty('dad.healthColorArray'))

  if downscroll then
    baseCoords = {232, 30}
  else
    baseCoords = {232, 600}
  end

  precacheSound('hit1')
  precacheSound('hit2')
  precacheSound('hit3')

  setRatingFC('N/A')

  makeLuaSprite('hotbar', 'hotbar', 0, baseCoords[2] + 40)
  scaleObject('hotbar', scalething, scalething)
  setObjectCamera('hotbar', 'hud')
  setProperty('hotbar.antialiasing', false)
  addLuaSprite('hotbar', true)
  screenCenter('hotbar', 'x')

  for i = 1, 9 do
    makeLuaSprite('item'..i, 'items/'..items[i][1], getProperty('hotbar.x') - 50 + (20*scalething*(i)), getProperty('hotbar.y') + 8)
    scaleObject('item'..i, scalething, scalething)
    setObjectCamera('item'..i, 'hud')
    setProperty('item'..i..'.antialiasing', false)
    addLuaSprite('item'..i, true)
  end

  makeLuaSprite('hbSelect', 'selectedItem', 0, getProperty('hotbar.y') - 2)
  scaleObject('hbSelect', scalething, scalething)
  setObjectCamera('hbSelect', 'hud')
  setProperty('hbSelect.antialiasing', false)
  addLuaSprite('hbSelect', true)
  
  makeLuaSprite('bossbarempty', 'desatbar/empty', 0, (downscroll and screenHeight - 25 or 30))
  scaleObject('bossbarempty', scalething, scalething)
  setObjectCamera('bossbarempty', 'hud')
  setProperty('bossbarempty.antialiasing', false)
  addLuaSprite('bossbarempty', true)
  screenCenter('bossbarempty', 'x')
  setProperty('bossbarempty.visible', false)

  makeLuaSprite('bossbarfill', 'desatbar/full', 0, (downscroll and screenHeight - 25 or 30))
  scaleObject('bossbarfill', scalething, scalething)
  setObjectCamera('bossbarfill', 'hud')
  setProperty('bossbarfill.antialiasing', false)
  addLuaSprite('bossbarfill', true)
  screenCenter('bossbarfill', 'x')
  setProperty('bossbarfill.visible', false)

  makeLuaText('bossbarname', songName..' - ['..string.upper(difficultyName)..']', screenWidth, 0, (downscroll and screenHeight - 55 or -5))
  setTextFont('bossbarname', 'Minecraftia.ttf')
  setTextSize('bossbarname', 18)
  addLuaText('bossbarname')
  screenCenter('bossbarname', 'x')
  setProperty('bossbarname.visible', false)


  local heartoffset = 135
  basehearty = baseCoords[2] - 12
  for i = 1, 10 do
    makeLuaSprite('heartBG'..i, nil, baseCoords[1] + heartoffset + (i-1)*(8*scalething), basehearty)
    loadGraphic('heartBG'..i, 'mineIcons/healthIcons-'..healthSkin, 9, 9)
    addAnimation('heartBG'..i, '1', {0, 0}, 24, false)
    scaleObject('heartBG'..i, scalething, scalething)
    setObjectCamera('heartBG'..i, 'hud')
    setProperty('heartBG'..i..'.antialiasing', false)
    addLuaSprite('heartBG'..i, true)
    playAnim('heartBG'..i, '1')
  end
  
  for i = 1, 10 do
    makeLuaSprite('heart'..i, nil, baseCoords[1] + heartoffset + (i-1)*(8*scalething), basehearty)
    loadGraphic('heart'..i, 'mineIcons/healthIcons-'..healthSkin, 9, 9)
    addAnimation('heart'..i, 'full', {4, 1}, 0)
    addAnimation('heart'..i, 'half', {5, 1}, 0)
    addAnimation('heart'..i, 'empty', {0, 1}, 0)
    scaleObject('heart'..i, scalething, scalething)
    setObjectCamera('heart'..i, 'hud')
    setProperty('heart'..i..'.antialiasing', false)
    addLuaSprite('heart'..i, true)
    playAnim('heart'..i, 'full', true)
  end

  local hungeroffset = 650
  basehungery = baseCoords[2] - 12
  for i = 1, 10 do
    makeLuaSprite('hungerBG'..i, nil, baseCoords[1] + hungeroffset - (i-1)*(8*scalething), basehungery)
    loadGraphic('hungerBG'..i, 'mineIcons/hungerIcons', 9, 9)
    addAnimation('hungerBG'..i, 'full', {0, 1}, 0)
    
    scaleObject('hungerBG'..i, scalething, scalething)
    setObjectCamera('hungerBG'..i, 'hud')
    setProperty('hungerBG'..i..'.antialiasing', false)
    addLuaSprite('hungerBG'..i, true)
    playAnim('hungerBG'..i, 'full', true)
  end

  for i = 1, 10 do
    makeLuaSprite('hunger'..i, nil, baseCoords[1] + hungeroffset - (i-1)*(8*scalething), basehungery)
    loadGraphic('hunger'..i, 'mineIcons/hungerIcons', 9, 9)
    addAnimation('hunger'..i, 'full', {4, 3}, 0)
    addAnimation('hunger'..i, 'half', {5, 4}, 0)
    addAnimation('hunger'..i, 'empty', {0, 4}, 0)
    scaleObject('hunger'..i, scalething, scalething)
    setObjectCamera('hunger'..i, 'hud')
    setProperty('hunger'..i..'.antialiasing', false)
    addLuaSprite('hunger'..i, true)
    playAnim('hunger'..i, 'full', true)
  end

  makeLuaSprite('expempty', 'expbar/empty', 0, baseCoords[2] + 18)
  scaleObject('expempty', scalething, scalething)
  setObjectCamera('expempty', 'hud')
  setProperty('expempty.antialiasing', false)
  addLuaSprite('expempty', true)
  screenCenter('expempty', 'x')

  makeLuaSprite('expfill', 'expbar/full', 0, baseCoords[2] + 18)
  scaleObject('expfill', scalething, scalething)
  setObjectCamera('expfill', 'hud')
  setProperty('expfill.antialiasing', false)
  addLuaSprite('expfill', true)
  screenCenter('expfill', 'x')

  makeLuaText('exptext', '0', screenWidth, 0, baseCoords[2] - 8)
  setTextAlignment('exptext', 'center')
  setTextFont('exptext', 'Minecraftia.ttf')
  setTextSize('exptext', 20)
  addLuaText('exptext')
  screenCenter('exptext', 'x')
  setTextColor('exptext', 'b5fc7c')


  makeLuaText('shitscore', 'Score: 0 | Misses: 0 | Accuracy: ??.??% [?]', screenWidth, 0, baseCoords[2] + (downscroll and 130 or -120))
  setTextFont('shitscore', 'Minecraftia.ttf')
  setTextSize('shitscore', 18)
  setTextAlignment('shitscore', 'center')
  addLuaText('shitscore')
  screenCenter('shitscore', 'x')

  makeLuaText('itemname', '', screenWidth, 0, (downscroll and 220 or 520))
  setTextFont('itemname', 'Minecraftia.ttf')
  setTextSize('itemname', 18)
  addLuaText('itemname')
  screenCenter('itemname', 'x')
  setProperty('itemname.alpha', 0)

  totalNotes = 0
  for i = 1, getProperty('unspawnNotes.length')-1 do -- Counts the Total notes
    if not getPropertyFromGroup('unspawnNotes', i, 'isSustainNote') then 
      if not getPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss') then
        if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
          totalNotes = totalNotes + 1
        end
      end
    end
  end

end

function onSongStart()
  local barstuff = {'fill', 'empty', 'name'} 
  for i = 1,3 do 
    setProperty('bossbar'..barstuff[i]..'.visible', true)
  end
end

function onUpdate(elapsed)
  local keys = {'ONE', 'TWO', 'THREE', 'FOUR', 'FIVE', 'SIX', 'SEVEN', 'EIGHT', 'NINE'} -- i hate how this works
  for i = 1,9 do 
    if keyboardJustPressed(keys[i]) then
      callOnLuas('onSlotSwitch', {i}, true, false)
      curItem = i
    end
  end
  setProperty('hbSelect.x', getProperty('hotbar.x') - 62 + (20*scalething*(curItem)))
end

function onUpdatePost(elapsed)
  setProperty('healthBar.visible', false)
  setProperty('healthBarBG.visible', false)
  setProperty('timeBar.visible', false)
  setProperty('timeBarBG.visible', false)
  setProperty('timeTxt.visible', false)
  setProperty('scoreTxt.visible', false)
  setProperty('iconP1.x', screenWidth - 250)
  setProperty('iconP1.y', getProperty('hotbar.y') - 80)
  setProperty('iconP2.x', 100)
  setProperty('iconP2.y', getProperty('hotbar.y') - 80)
  setObjectOrder('iconP1', getObjectOrder('hotbar') + 1)
  setObjectOrder('iconP2', getObjectOrder('hotbar') + 1)

  daddycolor = rgbToHex(getProperty('dad.healthColorArray'))
  setProperty('bossbarfill.color', getColorFromHex(daddycolor))
  setProperty('bossbarempty.color', getColorFromHex(daddycolor))

  realRating = math.floor(rating * 10000) / 100
  setTextString('shitscore', 'Score: '..score..' | Misses : '..misses..' | Accuracy: '..realRating..'% ['..getProperty('ratingFC')..']')

  timey = getSongPosition() / songLength
  setProperty('bossbarfill._frame.frame.width', (math.lerp(0, 182, timey)))

  exp = hits / totalNotes
  if exp <= 0 then 
    exp = 0.0000000001 -- lerp hates zero
  end
  setProperty('expfill._frame.frame.width', (math.lerp(0, 182, exp)))

  setTextString('exptext', hits)

  for i = 1, 9 do -- enchant glint stuff,  I'm not exprienced with shaders so here is my makeshift one.
    if not pastitems[i][3] == items[i][3] then
      if items[i][3] then
        -- oops
        doTweenColor('enchantGlint'..i, 'item'..i, 'ff87ff', 2, 'linear')
      else
        cancelTween('enchantGlint'..i)
        setProperty('item'..i..'.color', getColorFromHex('FFFFFF'))
      end
    end
  end
  pastitems = items

  for i = 1, 10 do
    playAnim('heart'..i, 'empty', true)
    extraHealth = math.floor((getProperty('health')/2) * 10000 / 100)
    targetHealth = (i * 10)

    if targetHealth - 5 <= extraHealth then 
      playAnim('heart'..i, 'half', true)
    end

    if targetHealth <= extraHealth then 
      playAnim('heart'..i, 'full', true)
    end
  end

  for i = 1, 10 do
    playAnim('hunger'..i, 'empty', true)
    extraHealth = math.floor((hunger) * 10000 / 100)
    targetHealth = (i * 10)

    if targetHealth - 5 <= extraHealth then 
      playAnim('hunger'..i, 'half', true)
    end

    if targetHealth <= extraHealth then 
      playAnim('hunger'..i, 'full', true)
    end
  end

  for i = 1, 10 do -- 2 hearts and below shake
    if getProperty('health') < 0.4 then
      local randomy = math.random(-4, 4)
      setProperty('heart'..i..'.y', basehearty + randomy)
      setProperty('heartBG'..i..'.y', basehearty + randomy)
    else 
      setProperty('heart'..i..'.y', basehearty)
      setProperty('heartBG'..i..'.y', basehearty)
    end
  end

  for i = 1, 10 do -- 2 hunger and below shake
    if hunger < 0.2 then
      local randomy = math.random(-4, 4)
      setProperty('hunger'..i..'.y', basehungery + randomy)
      setProperty('hungerBG'..i..'.y', basehungery + randomy)
    else 
      setProperty('hunger'..i..'.y', basehungery)
      setProperty('hungerBG'..i..'.y', basehungery)
    end
  end
end

function onSlotSwitch(slot)
  setProperty('itemname.alpha', 1)
  cancelTween('fadeing')
  setTextString('itemname', items[slot][2])
  runTimer('fadetext1', 2)
end

function noteMiss(membersIndex, noteData, noteType, isSustainNote)
  if getDataFromSave('options', 'hurtSound', true) then
  playSound('hit'..math.random(1, 3), 1, 'minecraftHit')
  end
  if getDataFromSave('options', 'screenRotate', true) then
  setProperty('camGame.angle', 0)
  doTweenAngle('oof', 'camGame', 6, 0.05, 'linear')
  end 
  if flashingLights then 
  setProperty('boyfriend.color', getColorFromHex('FF0000'))
  end
  runTimer('oofie', 0.1)
end

function onTimerCompleted(tag, loops, loopsLeft)
   if tag == 'oofie' then
    if flashingLights then 
    setProperty('boyfriend.color', getColorFromHex('FFFFFF'))
    end
    if getDataFromSave('options', 'screenRotate', true) then
    doTweenAngle('oof', 'camGame', 0, 0.1, 'linear')
    end
   end
   if tag == 'fadetext1' then
    doTweenAlpha('fadeing', 'itemname', 0, 1, 'linear')
   end
end

function onTweenCompleted(tag)
  for i = 1,9 do -- enchant glint shit
    if tag == 'enchantGlint'..tostring(i) then
      doTweenColor('enchantGlintBack'..i, 'item'..i, 'ffffff', 2, 'linear')
    end
    if tag == 'enchantGlintBack'..tostring(i) then
      doTweenColor('enchantGlint'..i, 'item'..i, 'ff87ff', 2, 'linear')
    end
  end
end

function math.lerp(a, b, t)
	return a + t * (b - a);
end

function rgbToHex(array)
	return string.format('%.2x%.2x%.2x', array[1], array[2], array[3])
end
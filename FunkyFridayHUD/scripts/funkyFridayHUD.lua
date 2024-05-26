--[[Funky Friday HUD]]--
-- THIS HUD UTILIZES A PUR LUA LIBRARY CALLED 'json.lua' TO GET THE 'pack.json'
-----------------------------

mod = ""
enemyFakeScore = 0
enemyFakeCombo = 0
function onCreatePost()
    -- gets dad hp bar color
    daddyColor = getProperty('dad.healthColorArray')
    daddyColor = rgbToHex(daddyColor)
    
    -- oh yeah ha ha
    setProperty('timeBar.visible', false)
    setProperty('timeBarBG.visible', false)
    setProperty('timeTxt.visible', false)
    setProperty('scoreTxt.visible', false)

    configData = json.parse(getTextFromFile('FunkyFridayHUD/FunkyFridayCONFIG.json'))
    -- ANY EASIER WAY TO DO THIS WITHOUT LAYING OUT ALL THE VARS?!?!?!??!?!?
    botAccuracy = configData.botAccuracy
    showJudgements = configData.showJudgementCount
    animationsOnghostTap = configData.animationsOnghostTap


    -- JSON 
    --debugPrint('getting pack.json of: ', currentModDirectory)
    jsonData = json.parse(getTextFromFile(currentModDirectory..'/pack.json')) -- gets pack.json from the current mod
    mod = jsonData.name
    if mod == '' or mod == 'Funky Friday HUD' then -- otherwise it will get the name of the folder (IF ITS NOT THE HUD)
        mod = currentModDirectory
        if currentModDirectory == '' then
        mod = "Friday Night Funkin'" -- otherwise if it is not part of a modpack, it will default to " Friday Night Funkin' "
        end
    end

    -- SCORE SHIT
    makeLuaText('FakeScore', '', 1800, 0, 690)
    setTextAlignment('FakeScore', 'center')
    setTextSize('FakeScore', 12)
    setTextFont('FakeScore', 'PressStart2P.ttf')
    addLuaText('FakeScore')
    screenCenter('FakeScore', 'x')

    makeLuaText('FakeScore2', '', 1800, -550, 350)
    setTextAlignment('FakeScore2', 'right')
    setTextSize('FakeScore2', 12)
    setTextFont('FakeScore2', 'PressStart2P.ttf')
    addLuaText('FakeScore2')

    makeLuaText('P1Score', 'Score: 0', 1400, -180, (downscroll and 30 or 650))
    setTextAlignment('P1Score', 'right')
    setTextSize('P1Score', 30)
    setTextFont('P1Score', 'PermanentMarker.ttf')
    addLuaText('P1Score')

    makeLuaText('P2Score', 'Score: 0', 1400, 50, (downscroll and 30 or 650))
    setTextAlignment('P2Score', 'left')
    setTextSize('P2Score', 30)
    setTextFont('P2Score', 'PermanentMarker.ttf')
    addLuaText('P2Score')

    -- THESE ARE FOR SCORE TWEENS, NUMBERS DO NOT TWEEN
    makeLuaSprite('p1score', nil, 0, 0)
    addLuaSprite('p1score')
    setProperty('p1score.visible', false)

    makeLuaSprite('p2score', nil, 0, 0)
    addLuaSprite('p2score')
    setProperty('p2score.visible', false)

    isPixel = getPropertyFromClass('PlayState', 'isPixelStage') -- For Middlescroll notes, cannot be grabbed by getProperty() for some reason
    if middlescroll then
      for ii = 0,3 do 
        setPropertyFromGroup('strumLineNotes', ii, 'scale.x', 0.4*(isPixel and 8 or 1))
        setPropertyFromGroup('strumLineNotes', ii, 'scale.y', 0.4*(isPixel and 8 or 1))
        setPropertyFromGroup('strumLineNotes', ii, 'x', 80 + ((ii - 1)*65))
        setPropertyFromGroup('strumLineNotes', ii, 'y', (downscroll and screenHeight - 200 or 200))
        setPropertyFromGroup('strumLineNotes', ii, 'alpha', 1)
      end
    end
end

function opponentNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if not isSustainNote then
        enemyFakeCombo = enemyFakeCombo + 1
        if getRandomBool(botAccuracy) then -- simulates enemy ratings....
            makeEnemyRating('sick')
            enemyFakeScore = enemyFakeScore + 350
        elseif getRandomBool(botAccuracy/1.5) then
            makeEnemyRating('good')
            enemyFakeScore = enemyFakeScore + 200
        elseif getRandomBool(botAccuracy/2) then
            makeEnemyRating('bad')
            enemyFakeScore = enemyFakeScore + 100
        else
            makeEnemyRating('shit')
            enemyFakeScore = enemyFakeScore + 50
        end
    end
    doTweenX('funny1', 'p2score',  enemyFakeScore, 0.2, 'linear')
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if not isSustainNote then
    strumTime = getPropertyFromGroup('notes', membersIndex, 'strumTime')
    songPos = getPropertyFromClass('Conductor', 'songPosition')
    rOffset = getPropertyFromClass('ClientPrefs','ratingOffset')

    if (strumTime - songPos + rOffset) < 0 then
    msabsolute = (strumTime - songPos + rOffset) * -1
    else
    msabsolute = (strumTime - songPos + rOffset)
    end

    if msabsolute <= getPropertyFromClass('ClientPrefs', 'sickWindow') then
        makeRating('sick')
    elseif msabsolute <= getPropertyFromClass('ClientPrefs', 'goodWindow') then
        makeRating('good')
    elseif msabsolute <= getPropertyFromClass('ClientPrefs', 'badWindow') then
        makeRating('bad')
    else
        makeRating('shit')
    end
    doTweenX('funny2', 'p1score', score, 0.2, 'linear')
end
end

function onSongStart()
    -- Song Info
    makeLuaText('SongInfo', mod..' - '..songName..' ('..difficultyName..')', 800, 0, 5)
    setTextAlignment('SongInfo', 'center')
    setTextSize('SongInfo', 15)
    setTextFont('SongInfo', 'PermanentMarker.ttf')
    addLuaText('SongInfo')
    screenCenter('SongInfo', 'x')
    setTextColor('SongInfo', daddyColor)

    makeLuaText('SongInfo12', 'Funky Friday HUD By: n_bonnie2', 800, 0, 23)
    setTextAlignment('SongInfo12', 'center')
    setTextSize('SongInfo12', 15)
    setTextFont('SongInfo12', 'PermanentMarker.ttf')
    addLuaText('SongInfo12')
    screenCenter('SongInfo12', 'x')

    
    makeLuaText('SongInfo2', '00:00', 800, 0, 40)
    setTextAlignment('SongInfo2', 'center')
    setTextSize('SongInfo2', 15)
    setTextFont('SongInfo2', 'PermanentMarker.ttf')
    addLuaText('SongInfo2')
    screenCenter('SongInfo2', 'x')
end

function onUpdatePost(elapsed)
    setHealthBarColors('00eeff','00ff3c')
    local timeElapsed = math.floor(getProperty('songTime')/1000)
    local timeTotal = math.floor(getProperty('songLength')/1000)
    local PreConvert = timeTotal - timeElapsed
    local OMGTIME = string.format("%.2d:%.2d", PreConvert/60%60, PreConvert%60)
    local realRating = math.floor(rating * 10000) / 100
    setTextString('SongInfo2', OMGTIME)
    setTextString('FakeScore', 'Accuracy: '..realRating..'% | Misses: '..misses..' | Combo: '..getProperty('combo'))
    setTextString('P1Score', 'Score: '..math.floor(getProperty('p1score.x')))
    setTextString('P2Score', 'Score: '..math.floor(getProperty('p2score.x')))
    if showJudgements then 
    setTextString('FakeScore2', 'Sick!!: '..getProperty('sicks')..'\n\nGood!: '..getProperty('goods')..'\n\nBad: '..getProperty('bads')..'\n\nShit: '..getProperty('shits')..'\n\nMissed: '..misses)
    end
    -- Downscroll HP bar, they dont have that in FF
    if downscroll then
    setProperty('healthBar.y', 110)
    setProperty('iconP1.y', 50)
    setProperty('iconP2.y', 50)
    end

    setProperty('showCombo', false) -- unused but just in case
    setProperty('showRating', false)
    setProperty('showComboNum', false)

    if middlescroll then -- middlescroll notes
      for ii = 0,3 do 
        setPropertyFromGroup('strumLineNotes', ii, 'alpha', 1)
      end
      for i = 0, getProperty('notes.length')-1 do 
        if not getPropertyFromGroup('notes', i, 'mustPress') then
          if getPropertyFromGroup('notes', i, 'isSustainNote') then
            setPropertyFromGroup('notes', i, 'scale.x', 0.4 * (isPixel and 8 or 1))
            setPropertyFromGroup('notes', i, 'scale.y', (stepCrochet / 100 * 1.05)*scrollSpeed * (isPixel and 1.19 or 1) * (isPixel and 8 or 1)) -- source rules
          else
            setPropertyFromGroup('notes', ii, 'alpha', 1)
            setPropertyFromGroup('notes', i, 'scale.x', 0.4 * (isPixel and 8 or 1))
            setPropertyFromGroup('notes', i, 'scale.y', 0.4 * (isPixel and 8 or 1))
          end
        end
      end
    end

    if animationsOnghostTap then
      local pressyButtons = {'left', 'down', 'up', 'right'}
      local singAnims = {'singLEFT', 'singDOWN', 'singUP', 'singRIGHT'}    
      for keys = 1,4 do
      if keyPressed(pressyButtons[keys]) then
        setProperty('boyfriend.holdTimer', 0)
        playAnim('boyfriend',singAnims[keys],true)
      end
      end
      end
end

function onBeatHit()
    scaleObject('iconP1', 0.8, 0.8)
    scaleObject('iconP2', 0.8, 0.8)
end

function makeRating(combo)
    makeLuaSprite('judgement'..getProperty('combo'), combo, (middlescroll and 300 or 620), (downscroll and screenHeight - 100 or 100))
    setObjectCamera('judgement'..getProperty('combo'), 'hud')
    scaleObject('judgement'..getProperty('combo'), 0.3, 0.3)
    addLuaSprite('judgement'..getProperty('combo'), true)
    doTweenY('judgement'..getProperty('combo'), 'judgement'..getProperty('combo'), getProperty('judgement'..getProperty('combo')..'.y') - 30, 0.2, 'linear')
end

function makeEnemyRating(combobad)
    if middlescroll then -- had a brain fart
      makeLuaSprite('badjudgement'..enemyFakeCombo, combobad, 300, (downscroll and screenHeight - 250 or 250))
    else
    makeLuaSprite('badjudgement'..enemyFakeCombo, combobad, 520, (downscroll and screenHeight - 100 or 100))
    end
    setObjectCamera('badjudgement'..enemyFakeCombo, 'hud')
    scaleObject('badjudgement'..enemyFakeCombo, (middlescroll and 0.15 or 0.3), (middlescroll and 0.15 or 0.3))
    addLuaSprite('badjudgement'..enemyFakeCombo, true)
    doTweenY('badjudgement'..enemyFakeCombo, 'badjudgement'..enemyFakeCombo, getProperty('badjudgement'..enemyFakeCombo..'.y') - 30, 0.2, 'linear')
end

function onTweenCompleted(tag)
    if string.find(tag, 'judgement') then
        removeLuaSprite(tag, false)
    end
    if string.find(tag, 'badjudgement') then
        removeLuaSprite(tag, false)
    end
end


--[[ Stolen Code Corner ]]--

function rgbToHex(rgb) -- https://gist.github.com/marceloCodget/3862929 
	local hexadecimal = ''
	for key, value in pairs(rgb) do
		local hex = ''

		while(value > 0)do
			local index = math.fmod(value, 16) + 1
			value = math.floor(value / 16)
			hex = string.sub('0123456789ABCDEF', index, index) .. hex			
		end

		if(string.len(hex) == 0)then
			hex = '00'

		elseif(string.len(hex) == 1)then
			hex = '0' .. hex
		end

		hexadecimal = hexadecimal .. hex
	end

	return hexadecimal
end

--[[ json.lua
A compact pure-Lua JSON library.
The main functions are: json.stringify, json.parse.
## json.stringify:
This expects the following to be true of any tables being encoded:
 * They only have string or number keys. Number keys must be represented as
   strings in json; this is part of the json spec.
 * They are not recursive. Such a structure cannot be specified in json.
A Lua table is considered to be an array if and only if its set of keys is a
consecutive sequence of positive integers starting at 1. Arrays are encoded like
so: `[2, 3, false, "hi"]`. Any other type of Lua table is encoded as a json
object, encoded like so: `{"key1": 2, "key2": false}`.
Because the Lua nil value cannot be a key, and as a table value is considerd
equivalent to a missing key, there is no way to express the json "null" value in
a Lua table. The only way this will output "null" is if your entire input obj is
nil itself.
An empty Lua table, {}, could be considered either a json object or array -
it's an ambiguous edge case. We choose to treat this as an object as it is the
more general type.
To be clear, none of the above considerations is a limitation of this code.
Rather, it is what we get when we completely observe the json specification for
as arbitrary a Lua object as json is capable of expressing.
## json.parse:
This function parses json, with the exception that it does not pay attention to
\u-escaped unicode code points in strings.
It is difficult for Lua to return null as a value. In order to prevent the loss
of keys with a null value in a json string, this function uses the one-off
table value json.null (which is just an empty table) to indicate null values.
This way you can check if a value is null with the conditional
`val == json.null`.
If you have control over the data and are using Lua, I would recommend just
avoiding null values in your data to begin with.
--]]


json = {}


-- Internal functions.

local function kind_of(obj)
  if type(obj) ~= 'table' then return type(obj) end
  local i = 1
  for _ in pairs(obj) do
    if obj[i] ~= nil then i = i + 1 else return 'table' end
  end
  if i == 1 then return 'table' else return 'array' end
end

local function escape_str(s)
  local in_char  = {'\\', '"', '/', '\b', '\f', '\n', '\r', '\t'}
  local out_char = {'\\', '"', '/',  'b',  'f',  'n',  'r',  't'}
  for i, c in ipairs(in_char) do
    s = s:gsub(c, '\\' .. out_char[i])
  end
  return s
end

-- Returns pos, did_find; there are two cases:
-- 1. Delimiter found: pos = pos after leading space + delim; did_find = true.
-- 2. Delimiter not found: pos = pos after leading space;     did_find = false.
-- This throws an error if err_if_missing is true and the delim is not found.
local function skip_delim(str, pos, delim, err_if_missing)
  pos = pos + #str:match('^%s*', pos)
  if str:sub(pos, pos) ~= delim then
    if err_if_missing then
      error('Expected ' .. delim .. ' near position ' .. pos)
    end
    return pos, false
  end
  return pos + 1, true
end

-- Expects the given pos to be the first character after the opening quote.
-- Returns val, pos; the returned pos is after the closing quote character.
local function parse_str_val(str, pos, val)
  val = val or ''
  local early_end_error = 'End of input found while parsing string.'
  if pos > #str then error(early_end_error) end
  local c = str:sub(pos, pos)
  if c == '"'  then return val, pos + 1 end
  if c ~= '\\' then return parse_str_val(str, pos + 1, val .. c) end
  -- We must have a \ character.
  local esc_map = {b = '\b', f = '\f', n = '\n', r = '\r', t = '\t'}
  local nextc = str:sub(pos + 1, pos + 1)
  if not nextc then error(early_end_error) end
  return parse_str_val(str, pos + 2, val .. (esc_map[nextc] or nextc))
end

-- Returns val, pos; the returned pos is after the number's final character.
local function parse_num_val(str, pos)
  local num_str = str:match('^-?%d+%.?%d*[eE]?[+-]?%d*', pos)
  local val = tonumber(num_str)
  if not val then error('Error parsing number at position ' .. pos .. '.') end
  return val, pos + #num_str
end


-- Public values and functions.

function json.stringify(obj, as_key)
  local s = {}  -- We'll build the string as an array of strings to be concatenated.
  local kind = kind_of(obj)  -- This is 'array' if it's an array or type(obj) otherwise.
  if kind == 'array' then
    if as_key then error('Can\'t encode array as key.') end
    s[#s + 1] = '['
    for i, val in ipairs(obj) do
      if i > 1 then s[#s + 1] = ', ' end
      s[#s + 1] = json.stringify(val)
    end
    s[#s + 1] = ']'
  elseif kind == 'table' then
    if as_key then error('Can\'t encode table as key.') end
    s[#s + 1] = '{'
    for k, v in pairs(obj) do
      if #s > 1 then s[#s + 1] = ', ' end
      s[#s + 1] = json.stringify(k, true)
      s[#s + 1] = ':'
      s[#s + 1] = json.stringify(v)
    end
    s[#s + 1] = '}'
  elseif kind == 'string' then
    return '"' .. escape_str(obj) .. '"'
  elseif kind == 'number' then
    if as_key then return '"' .. tostring(obj) .. '"' end
    return tostring(obj)
  elseif kind == 'boolean' then
    return tostring(obj)
  elseif kind == 'nil' then
    return 'null'
  else
    error('Unjsonifiable type: ' .. kind .. '.')
  end
  return table.concat(s)
end

json.null = {}  -- This is a one-off table to represent the null value.

function json.parse(str, pos, end_delim)
  pos = pos or 1
  if pos > #str then error('Reached unexpected end of input.') end
  local pos = pos + #str:match('^%s*', pos)  -- Skip whitespace.
  local first = str:sub(pos, pos)
  if first == '{' then  -- Parse an object.
    local obj, key, delim_found = {}, true, true
    pos = pos + 1
    while true do
      key, pos = json.parse(str, pos, '}')
      if key == nil then return obj, pos end
      if not delim_found then error('Comma missing between object items.') end
      pos = skip_delim(str, pos, ':', true)  -- true -> error if missing.
      obj[key], pos = json.parse(str, pos)
      pos, delim_found = skip_delim(str, pos, ',')
    end
  elseif first == '[' then  -- Parse an array.
    local arr, val, delim_found = {}, true, true
    pos = pos + 1
    while true do
      val, pos = json.parse(str, pos, ']')
      if val == nil then return arr, pos end
      if not delim_found then error('Comma missing between array items.') end
      arr[#arr + 1] = val
      pos, delim_found = skip_delim(str, pos, ',')
    end
  elseif first == '"' then  -- Parse a string.
    return parse_str_val(str, pos + 1)
  elseif first == '-' or first:match('%d') then  -- Parse a number.
    return parse_num_val(str, pos)
  elseif first == end_delim then  -- End of an object or array.
    return nil, pos + 1
  else  -- Parse true, false, or null.
    local literals = {['true'] = true, ['false'] = false, ['null'] = json.null}
    for lit_str, lit_val in pairs(literals) do
      local lit_end = pos + #lit_str - 1
      if str:sub(pos, lit_end) == lit_str then return lit_val, lit_end + 1 end
    end
    local pos_info_str = 'position ' .. pos .. ': ' .. str:sub(pos, pos + 10)
    error('Invalid json syntax starting at ' .. pos_info_str)
  end
end

return json

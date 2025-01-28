allowCD = false
selectedBoyfriend = 'bf'
defaultBoyfriend = 'bf'
selectedgf = 'bf'
defaultgf = 'gf'
inScreen = false
charData = {}
characters = {}
curSelected = 1
luaDebugMode = true

defaultSyntax = "[default]"

-- DISABLE THIS IF YOURE HAVING LAG ISSUES!
precacheCharacters = true 
function onCreatePost()
    local oldLuaVersions = {'0.3', '0.4', '0.5', '0.6'}
    compatMode = false
    for i = 1, #oldLuaVersions do 
      if stringStartsWith(version, oldLuaVersions[i]) then -- detect lower vers
        compatMode = true
        break
      end
    end

    if compatMode then
      isPixel = getPropertyFromClass('PlayState', 'isPixelStage')
    else
      isPixel = getPropertyFromClass('states.PlayState', 'isPixelStage')
    end

    if isPixel then
      charList = string.split(getTextFromFile('characters-pixel.txt'), '\n')
    else
      charList = string.split(getTextFromFile('characters-normal.txt'), '\n')
    end
    characters = {}
    for i = 1, #charList do -- somewhat fixes the line break problem
      if i == #charList then 
        table.insert(characters, string.split(charList[i], '::'))
      else
        table.insert(characters, string.split(string.sub(charList[i], 0, string.len(charList[i]) - 1), '::'))
      end
    end

    defaultBoyfriend = boyfriendName
    defaultgf = gfName

    -- replaces "[default]" tag with default characters
    for i = 1, #characters do 
      if characters[i][2] == defaultSyntax then 
        characters[i][2] = boyfriendName
      end
      if characters[i][3] == defaultSyntax then 
        characters[i][3] = gfName
      end
    end

    if precacheCharacters then
      for i = 1, #characters do 
        addCharacterToList(characters[i][2], 'boyfriend') -- laggy as fuck
        addCharacterToList(characters[i][3], 'girlfriend')
      end
    end
end

function onStartCountdown()
  if (allowCD == false) and (isStoryMode == false) then
    setProperty('inCutscene', true)
    inScreen = true

    playMusic('charSelect', 0.7, true)

    makeLuaSprite('menuBG', 'menuDesat', 0, 0)
    setObjectCamera('menuBG', 'other')
    addLuaSprite('menuBG', false)
    
    makeAnimatedLuaSprite('leftArrow', 'legacyNOTES', 50, 300)
    addAnimationByPrefix('leftArrow', 'idle', 'arrowLEFT', 24, true)
    addAnimationByPrefix('leftArrow', 'press', 'left confirm', 24, false)
    setObjectCamera('leftArrow', 'other')
    scaleObject('leftArrow', 0.7, 0.7)
    addLuaSprite('leftArrow', true)
    playAnim('leftArrow', 'idle', true)
    

    makeAnimatedLuaSprite('rightArrow', 'legacyNOTES', 1100, 300)
    addAnimationByPrefix('rightArrow', 'idle', 'arrowRIGHT', 24, true)
    addAnimationByPrefix('rightArrow', 'press', 'right confirm', 24, false)
    setObjectCamera('rightArrow', 'other')
    scaleObject('rightArrow', 0.7, 0.7)
    addLuaSprite('rightArrow', true)
    playAnim('rightArrow', 'idle', true)

    
    makeLuaText('charName', 'Default Character', screenWidth, 350, 635)
    setTextAlignment('charName', 'left')
    setTextSize('charName', 35)
    setObjectCamera('charName', 'other')
    addLuaText('charName')
    
    makeLuaText('instr', "Funkin' Character Select by: n_bonnie2 - Current Song: "..songName, screenWidth, 0, 700)
    setTextAlignment('instr', 'left')
    setTextSize('instr', 18)
    setObjectCamera('instr', 'other')
    addLuaText('instr')
    
    makeLuaText('SELECT', 'Select Character: ', screenWidth, 120, 45)
    setTextAlignment('SELECT', 'left')
    setTextSize('SELECT', 55)
    setObjectCamera('SELECT', 'other')
    addLuaText('SELECT')
    return Function_Stop
  end
  return Function_Continue
end


function onUpdate()
  if inScreen then
    refreshCharacter()
        if keyJustPressed('left') then
            setProperty('leftArrow.x', 30)
            doTweenX('leftTween', 'leftArrow', 50, 1, 'circOut')
            playSound('scrollMenu', 0.7)
            if curSelected == 1 then
                curSelected = #characters
            else
                curSelected = curSelected - 1
            end
            --debugPrint('<', curSelected)
        end

        if keyJustPressed('right') then
          setProperty('rightArrow.x', 1120)
          doTweenX('rightTween', 'rightArrow', 1100, 1, 'circOut')
            playSound('scrollMenu', 0.7)
            if curSelected == #characters then
                curSelected = 1   
            else 
                curSelected = curSelected + 1
            end
            --debugPrint('>', curSelected)
        end

        if keyJustPressed('accept') then
            inScreen = false

            selectedBoyfriend = characters[curSelected][2]
            selectedgf = characters[curSelected][3]

            replaceEventSwap() -- replaces character switch event, see below functions
            playSound('confirmMenu', 0.7)
            soundFadeOut('', 1, 0)
            tweenScreen()
            runTimer('theThing', 1)
          end
          if keyJustPressed('back') then
            exitSong()
          end

    end
end

function tweenScreen()
  doTweenAlpha('T1', 'leftArrow', 0, 0.8, 'linear')
  doTweenAlpha('T2', 'rightArrow', 0, 0.8, 'linear')
  doTweenAlpha('T3', 'charName', 0, 0.8, 'linear')
  --doTweenX('T3.1', 'charName', -200, 1, 'circInOut')
  doTweenAlpha('tBG', 'menuBG', 0, 0.8, 'linear')
  --doTweenX('tBG2', 'menuBG', -1200, 1, 'circInOut')
  doTweenAlpha('T4', 'ico1', 0, 0.8, 'linear')
  --doTweenX('T4.1', 'ico1', -150, 1, 'circInOut')
  doTweenAlpha('T5', 'char', 0, 0.8, 'linear')
  doTweenY('T5.1', 'char', -1000, 1, 'circInOut')
  doTweenAlpha('T5', 'SELECT', 0, 0.8, 'linear')
  doTweenAlpha('T7', 'instr', 0, 0.8, 'linear')
  --doTweenX('T7.1', 'instr', -1000, 1, 'circInOut')
end

function killScreen()
    removeLuaSprite('leftArrow', false)
    removeLuaSprite('rightArrow', false)
    removeLuaSprite('menuBG', false)
    removeLuaSprite('char', false)
    removeLuaSprite('ico1', false)
    removeLuaText('charName', false)
    removeLuaText('SELECT', false)
    removeLuaText('pixelNotice', false)
    allowCD = true
    startCountdown()
end

function refreshCharacter() 
    charData = json.parse(getTextFromFile('characters/'..characters[curSelected][2]..'.json', false)) -- MANUALLY read the file
    triggerEvent('Change Character', 'bf', characters[curSelected][2])
    triggerEvent('Change Character', 'gf', characters[curSelected][3])
    hpIco = charData.healthicon

    setTextString('charName', characters[curSelected][1])
    doTweenColor('colored', 'menuBG', rgbToHex(charData.healthbar_colors), 0.7, 'linear')

    makeAnimatedLuaSprite('ico1', nil, 200, 580)
    loadGraphic('ico1', 'icons/icon-'..hpIco, 150)
    addAnimation('ico1', 'neutral', {0, 1}, 0, true)
    addAnimation('ico1', 'lose', {1, 1}, 0, true)
    setObjectCamera('ico1', 'other')
    addLuaSprite('ico1', true)
    playAnim('ico1', 'neutral', true)

    if checkFileExists("images/"..charData.image.."/Animation.json") then 
      makeFlxAnimateSprite("char", 200, 580)
      loadAnimateAtlas("char", charData.image)
      addAnimationBySymbol("char", "idle", getProperty('boyfriend.animation'))
      scaleObject('char', charData.scale * 0.8, charData.scale * 0.8)
    else
        -- multiple spritesheet support introduced in 1.0... i hope it does not break in earlier versions
        local forgor = true
        local imagearray = string.split(charData.image, ',')
        for i = 1, #imagearray do 
          makeAnimatedLuaSprite('char', imagearray[i], 200, 580)
          addAnimationByPrefix('char', 'idle', getProperty('boyfriend.animation.frameName'))
          scaleObject('char', charData.scale * 0.8, charData.scale * 0.8)
          if not (getProperty("char.pixels") == nil) then  
            forgor = false
            break
          end
        end
        if forgor then 
          makeLuaSprite("char", "no_character_found")
        end
    end
    setObjectCamera('char', 'other')
    addLuaSprite('char', true)
    screenCenter('char')
    setProperty('char.antialiasing', not charData.no_antialiasing)
    playAnim('char', 'idle', true)
    
end

function replaceEventSwap()
  local eventsLength = getProperty('eventNotes.length')
  for i = 0,eventsLength-1 do 
    if getPropertyFromGroup('eventNotes', i, 'event') == 'Change Character' then -- this is how i do this
      val1 = getPropertyFromGroup('eventNotes', i, 'value1')

      -- check if default BF
      if val1 == '2' or val1 == 'boyfriend' or val1 == 'bf' then
        if getPropertyFromGroup('eventNotes', i, 'value2') == defaultBoyfriend then
          setPropertyFromGroup('eventNotes', i, 'value2', selectedBoyfriend)
        end
      end
      --check if default GF
      if val1 == '1' or val1 == 'girlfriend' or val1 == 'gf' then
        if getPropertyFromGroup('eventNotes', i, 'value2') == defaultgf then
          setPropertyFromGroup('eventNotes', i, 'value2', selectedgf)
        end
      end

    end
  end
end

function onTimerCompleted(tag, loops, loopsLeft)
  if tag == 'theThing' then
    killScreen()
  end
end

--[[ Stolen Code Corner ]]--

function rgbToHex(rgb)
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

function string.split(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t={}
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    table.insert(t, str)
  end
  return t
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

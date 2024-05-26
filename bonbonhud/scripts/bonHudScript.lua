local rateName = ''
local trueMisses = 0
local MSaverage = 0
local songStarted = false
local amountOfCombos = 0
local highestCombo = 0
local newCombo = 0
local msArray = {}
local npsPeak = 0
local nps = 0
local reduce = true

function onCreatePost()
    setRatingFC('N/A')
    luaDebugMode = true
   
    configData = json.parse(getTextFromFile('bonbonOPTIONS.json'))

    local oldLuaVersions = {'0.3', '0.4', '0.5', '0.6'}
    compatMode = false
      for i = 1, #oldLuaVersions do 
        if stringStartsWith(version, oldLuaVersions[i]) then -- backwards compbat for lower vers
          compatMode = true
          debugPrint('[BonbonHUD] Compatibility Mode Enabled since this is running on a older version of Psych Engine\nThat does not support the 0.7+ Lua System')
          break
        end
     end

    if not compatMode and configData.forceCompatMode then
      compatMode = true
      debugPrint('[BonbonHUD] Compatibility Mode Force-Enabled')
    end

    playbackRate = getProperty('playbackRate') --  i hate this
    if playbackRate == nil then 
      playbackRate = 1 -- backwards compbat
    end

    if compatMode then
      playAsOpponentEnabled = false -- not compat
      isPixel = getPropertyFromClass('PlayState', 'isPixelStage')
    else
      playAsOpponentEnabled = (getVar('PlayAsOpponent_Enabled') == true) -- compat with the OFFICAL play as opp
      isPixel = getPropertyFromClass('states.PlayState', 'isPixelStage')
    end

      for i = 0, 8 do -- just in case
        makeLuaText("stats-"..i, "", 500, (playAsOpponentEnabled and 765 or 15), 250 + (i * 25))
        setTextSize("stats-"..i, 18)
        setTextAlignment("stats-"..i, (playAsOpponentEnabled and "right" or "left"))
        setObjectCamera("stats-"..i, "hud")
        addLuaText("stats-"..i)
      end

    for i = 0, getProperty('strumLineNotes.length')-1 do -- fuck it.
      makeLuaSprite('noteunderlay-'..i, nil, 0, 0)
      makeGraphic('noteunderlay-'..i, 112, screenHeight, '000000')
      setObjectCamera('noteunderlay-'..i, 'hud')
      addLuaSprite('noteunderlay-'..i, false)
      setProperty('noteunderlay-'..i..'.alpha', configData.underlayAlpha)
    end

    ratingXoff = 0 -- rating offsets or smth
    charAnchor = 'gf'
    if playAsOpponentEnabled then
      ratingXoff = 550
      charAnchor = 'dad'
    else
      ratingXoff = 0
      charAnchor = 'boyfriend'
    end

    makeLuaText('ms', '', 120, getCharacterX(charAnchor) - 60 + ratingXoff, getCharacterY(charAnchor) + 380)
    setTextSize('ms', 24)
    setTextAlignment("ms", "left")
    setObjectCamera('ms', 'game')
    addLuaText('ms')
    enableTextMove('ms')
    setScrollFactor('ms', 1, 1)
end

function onUpdate(elapsed)
  --debugPrint(newCombo)
  if compatMode then
    isPixel = getPropertyFromClass('PlayState', 'isPixelStage')
  else
    isPixel = getPropertyFromClass('states.PlayState', 'isPixelStage')
  end

  if nps > 0 and reduce == true then     --NPS logic made by beihu(北狐丶逐梦) https://b23.tv/gxqO0GH, thanks fellow asian.
    reduce = false
    runTimer('reduce nps', 1/nps , 1)	
  end
  if nps == 0 then
    reduce = true
  end
end

function onUpdatePost()
    -- time stuff
    updateTextPos('ms', 1)

    setTimeBarColors(configData.timeBarColors[1], configData.timeBarColors[2])

    if compatMode then
      setProperty('timeBarBG.scale.x', configData.timeBarScaleX) -- stupid BG shit
      setProperty('healthBarBG.scale.x', configData.healthBarScaleX)
    else
      setProperty('timeBar.scale.x', configData.timeBarScaleX)
      setProperty('healthBar.scale.x', configData.healthBarScaleX)
    end

    if songStarted then
      timeElapsed = math.floor(getSongPosition()/1000)
      timeTotal = math.floor(songLength/1000)
      realTime = string.format("%.2d:%.2d", timeElapsed/60%60, timeElapsed%60)
      realFullTime = string.format("%.2d:%.2d", timeTotal/60%60, timeTotal%60)

      setTextString('timeTxt', songName..' - ('..string.upper(getProperty('storyDifficultyText'))..' - '..playbackRate..'x)'..'\n'..realTime.. ' / ' ..realFullTime)
    end
    if not inGameOver then
        if songStarted then
          setPropertyFromClass("openfl.Lib", "application.window.title", 'Friday Night Funkin\': Psych Engine - '..songName..' - ('..string.upper(getProperty('storyDifficultyText'))..' - '..playbackRate..'x) - [ '..realTime.. ' / ' ..realFullTime..' ]')
        else
          setPropertyFromClass("openfl.Lib", "application.window.title", 'Friday Night Funkin\': Psych Engine - '..songName..' - ('..string.upper(getProperty('storyDifficultyText'))..' - '..playbackRate..'x)')
        end
      else
      setPropertyFromClass("openfl.Lib", "application.window.title", 'Friday Night Funkin\': Psych Engine - Game Over - '..songName)
    end

    realRating = math.floor(rating * 10000) / 100

    -- get average of ms
    if #msArray == 0 then
      MSaverage = 0
    else
      preaverage = 0
      for i = 1, #msArray do 
        preaverage = preaverage + msArray[i]
      end
      MSaverage = math.floor(preaverage / #msArray) -- Mean/Average Calculation
    end

    -- 3 lines does this bitch.
    if getProperty('combo') > highestCombo then
      highestCombo = getProperty('combo')
    end
    if nps > npsPeak then
      npsPeak = nps
    end 


    -- hell naw, score text
    if botPlay then
      setTextString('scoreTxt', '')
    else
      setTextString('scoreTxt', 'Score: '..score..' | Misses: '..misses..' - '..getProperty('ratingFC')..' | Rank: '..ratingName..' ('..realRating..'%)')
    end

    -- stats
    realHEALTH = math.floor((getHealth()/2)*100)
    if configData.showBasicStats then
      setTextString('stats-0', 'Hits: '..hits..' / '..hits + trueMisses)
      setTextString('stats-1', 'Best Combo: '..highestCombo)
      if compatMode then 
        setTextString('stats-2', ' Sick!!: '..getProperty('sicks'))
        setTextString('stats-3', ' Good!: '..getProperty('goods'))
        setTextString('stats-4', ' Bad: '..getProperty('bads'))
        setTextString('stats-5', ' Shit: '..getProperty('shits'))
      else
        setTextString('stats-2', ' Sick!!: '..getProperty('ratingsData[0].hits'))
        setTextString('stats-3', ' Good!: '..getProperty('ratingsData[1].hits'))
        setTextString('stats-4', ' Bad: '..getProperty('ratingsData[2].hits'))
        setTextString('stats-5', ' Shit: '..getProperty('ratingsData[3].hits'))
      end
      setTextString('stats-6', 'Health: '..realHEALTH..'%')
    end
    if configData.showAdvancedStats then
      setTextString('stats-7', ' Mean: '..MSaverage..' ms')
      setTextString('stats-8', ' NPS: '..nps..' ('..npsPeak..')')
    end

    setTextColor('stats-2', configData.sickColor)
    setTextColor('stats-3', configData.goodColor)
    setTextColor('stats-4', configData.badColor)
    setTextColor('stats-5', configData.shitColor)

    if realHEALTH < 20 then
      setTextColor('stats-6', 'FF0000')
    elseif realHEALTH > 80 then
      setTextColor('stats-6', '04FF00')
    else 
      setTextColor('stats-6', 'FFFFFF')
    end


    setProperty('showCombo', false) -- hide hud ratings
    setProperty('showComboNum', false)
    setProperty('showRating', false)

    setTextSize('timeTxt', 16.5) -- adjust existing elements
    setTextSize('scoreTxt', 18)

    allTextStuffs = {'stats', 'side', 'scoreTxt', 'timeTxt', 'ms'} -- font changer
    if isPixel then
      for i = 1, #allTextStuffs do
        if luaTextExists(allTextStuffs[i]) then
        setTextFont(allTextStuffs[i], configData.pixelFont)
        end
      end
    else
      for i = 1, #allTextStuffs do
        if luaTextExists(allTextStuffs[i]) then
        setTextFont(allTextStuffs[i], configData.font)
        end
      end
    end

    for i = 0, getProperty('strumLineNotes.length')-1 do -- underlay sync
      setProperty('noteunderlay-'..i..'.x', getPropertyFromGroup('strumLineNotes', i, 'x') - 2)
      setProperty('noteunderlay-'..i..'.alpha', configData.underlayAlpha * getPropertyFromGroup('strumLineNotes', i, 'alpha'))
    end

    -- vanilla aspects
    if configData.vanillaMode then
      setHealthBarColors('FF0000', '66FF33')
      setProperty('scoreTxt.scale.x', 1)
      setProperty('scoreTxt.scale.y', 1)

      setProperty('iconP1.origin.y', 0)
      setProperty('iconP2.origin.y', 0)
      setGraphicSize('iconP1', math.lerp(150, getProperty('iconP1.width'), 0.85))
      setGraphicSize('iconP2', math.lerp(150, getProperty('iconP2.width'), 0.85))
      updateHitbox('iconP1')
      updateHitbox('iconP2')
    
      setTextAlignment('scoreTxt', 'left')
      setProperty('scoreTxt.x', getProperty('healthBar.x') + getProperty('healthBar.width') - 190)
      setProperty('scoreTxt.y', getProperty('healthBar.y') + 30)
      setTextSize('scoreTxt', 16)
    end
end

function goodNoteHit(id, direction, noteType, isSustainNote) -- ratings
    if newCombo < getProperty('combo')then -- play as oppoment safeguard
    newCombo = getProperty('combo')
    if not isSustainNote then
      nps = nps + 1
      strumTime = getPropertyFromGroup('notes', id, 'strumTime')
      if compatMode then
        songPos = getPropertyFromClass('Conductor', 'songPosition')
        rOffset = getPropertyFromClass('ClientPrefs','ratingOffset')
      else
        songPos = getPropertyFromClass('backend.Conductor', 'songPosition')
        rOffset = getPropertyFromClass('backend.ClientPrefs','data.ratingOffset')
      end

      msactual = (strumTime - songPos + rOffset)

      noteRate = getPropertyFromGroup('notes', id, 'rating')
        if noteRate == 'sick' then
          showRate(math.floor(msactual), configData.sickColor, 'sick', 2)
        elseif noteRate == 'good' then
          showRate(math.floor(msactual), configData.goodColor , 'good', 3)
        elseif noteRate == 'bad' then
          showRate(math.floor(msactual), configData.badColor, 'bad', 4)
        else
          showRate(math.floor(msactual), configData.shitColor, 'shit', 5)
        end

      if #msArray == 0 then
          msArray[1] = msactual
          else
          msArray[#msArray + 1] = msactual
      end
    end
  end
end

function onGhostTap(key)
  if compatMode then
    local gtap = getPropertyFromClass('ClientPrefs', 'ghostTapping')
  else
    local gtap = getPropertyFromClass('backend.ClientPrefs', 'data.ghostTapping')
  end
  if not gtap then
    newCombo = getProperty('combo')
  end 
end

function onDestroy() -- restore app name
    setPropertyFromClass("openfl.Lib", "application.window.title", 'Friday Night Funkin\': Psych Engine')
end

function onTimerCompleted(tag, loops, loopsLeft)
    if string.find(tag, 'fakeRating') or string.find(tag, 'fakeNumber') or string.find(tag, 'fakeCombo') then
      doTweenAlpha(tag, tag, 0, 0.2 / playbackRate, 'linear')
    end
    if tag == 'ms' then
		  doTweenAlpha('ms', 'ms', 0, 0.2 / playbackRate, 'linear')
	  end
    if tag == 'reduce nps'  and nps > 0 then
      runTimer('reduce nps', 1/nps, 1)
      nps = nps - 1
  end
end

function onTweenCompleted(tag)
  if string.find(tag, 'fakeRating') or string.find(tag, 'fakeNumber')  then
    removeLuaSprite(tag, false)
  end
end

function noteMiss(membersIndex, noteData, noteType, isSustainNote)
  newCombo = getProperty('combo')
    if not isSustainNote then -- shows non-sustain misses
        trueMisses = trueMisses + 1
    end
end

function onSongStart()
  songStarted = true
end

function onBeatHit()
  if configData.vanillaMode then
    setGraphicSize('iconP1', getProperty('iconP1.width') + 30)
    setGraphicSize('iconP2', getProperty('iconP2.width') + 30)
  end
end

function showRate(ms,color,rate,bop) -- code 100 %  by me lmao
    amountOfCombos = amountOfCombos + 1
    ratePrefixs = {'',''}
    if isPixel then
      ratePrefixs = {'pixelUI/','-pixel'}
    end

    if configData.scoreTextCustomColor then
    setTextColor('scoreTxt', color)
    doTweenColor('hahaSCORE', 'scoreTxt', 0xFFFFFFF, 1, 'circInOut')
    end

    if configData.showNoteMsOffset then
      ratingContext = ''
      if not (rate == 'sick') then
        if tonumber(ms) >= 0 then
          ratingContext = 'EARLY'
        else
          ratingContext = 'LATE'
        end
      end
      setProperty('ms.x', getCharacterX(charAnchor) - 60 + ratingXoff)
      setProperty('ms.y', getCharacterY(charAnchor) + 380)
      enableTextMove('ms') -- update that
      setProperty('ms.alpha', 1)
      setTextColor('ms', color)
      setTextString('ms', ms..'ms')
      runTimer('ms', crochet * 0.002)
    end

    makeLuaSprite('fakeRating'..amountOfCombos, ratePrefixs[1]..''..rate..''..ratePrefixs[2], getCharacterX(charAnchor) - 210 + ratingXoff, getCharacterY(charAnchor) + 180)
    setObjectCamera('fakeRating'..amountOfCombos, 'game')
    addLuaSprite('fakeRating'..amountOfCombos, true)

    if configData.ratingCustomColor then
    setProperty('fakeRating'..amountOfCombos..'.color', getColorFromHex(color))
    end
    
    makeLuaSprite('fakeCombo'..amountOfCombos, ratePrefixs[1]..'combo'..ratePrefixs[2], getCharacterX(charAnchor) - 135 + ratingXoff, getCharacterY(charAnchor) + 285)
    setObjectCamera('fakeCombo'..amountOfCombos, 'game')
    addLuaSprite('fakeCombo'..amountOfCombos, true)

    if configData.ratingCustomColor then
    setProperty('fakeCombo'..amountOfCombos..'.color', getColorFromHex(color))
    end

    if getProperty('combo') < 9 then
      setProperty('fakeCombo'..amountOfCombos..'.visible', false)
    end

    setProperty('fakeCombo'..amountOfCombos..'.acceleration.y', 550 * playbackRate * playbackRate)
    setProperty('fakeCombo'..amountOfCombos..'.velocity.y', getRandomInt(-175, -140) * playbackRate)
    setProperty('fakeCombo'..amountOfCombos..'.velocity.x', getRandomInt(0, 10) * playbackRate)

    setProperty('fakeRating'..amountOfCombos..'.acceleration.y', 550 * playbackRate * playbackRate)
    setProperty('fakeRating'..amountOfCombos..'.velocity.y', getRandomInt(-175, -140) * playbackRate)
    setProperty('fakeRating'..amountOfCombos..'.velocity.x', getRandomInt(0, 10) * playbackRate)

    runTimer('fakeRating'..amountOfCombos, (0.001*crochet)/playbackRate, 1)
    runTimer('fakeCombo'..amountOfCombos, (0.001*crochet)/playbackRate, 1)

    extraNumbers = 0
    if string.len(getProperty('combo')) < 3 then -- doing the numbers MY WAY!
      if string.len(getProperty('combo')) == 1 then
        comboThing = '00'..tostring(getProperty('combo'))
      elseif string.len(getProperty('combo')) == 2 then
        comboThing = '0'..tostring(getProperty('combo'))
      end
    else
      extraNumbers = string.len(getProperty('combo')) - 3
      comboThing = tostring(getProperty('combo'))
    end

    --debugPrint(comboThing)
    numXPos = (getCharacterX(charAnchor) - 270) - (43 * extraNumbers) + ratingXoff
    for i = 1, string.len(comboThing) do
      makeLuaSprite('fakeNumber'..amountOfCombos..'-'..i, ratePrefixs[1]..'num'..string.sub(comboThing, i, i)..''..ratePrefixs[2], numXPos, getCharacterY(charAnchor) + 340)
      addLuaSprite('fakeNumber'..amountOfCombos..'-'..i, true)
      if isPixel then
        scaleObject('fakeNumber'..amountOfCombos..'-'..i, 0.9*6*0.85, 0.9*6*0.85)
        setProperty('fakeNumber'..amountOfCombos..'-'..i..'.antialiasing', false)
      else
        scaleObject('fakeNumber'..amountOfCombos..'-'..i, 0.5, 0.5)
        if compatMode then
          setProperty('fakeNumber'..amountOfCombos..'-'..i..'.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
        else
          setProperty('fakeNumber'..amountOfCombos..'-'..i..'.antialiasing', getPropertyFromClass('backend.ClientPrefs', 'data.globalAntialiasing'))
        end
      end
      setProperty('fakeNumber'..amountOfCombos..'-'..i..'.acceleration.y', getRandomInt(200, 300) * playbackRate * playbackRate)
      setProperty('fakeNumber'..amountOfCombos..'-'..i..'.velocity.y', getRandomInt(-160, -140) * playbackRate)
      setProperty('fakeNumber'..amountOfCombos..'-'..i..'.velocity.x', getRandomInt(-5, 5) * playbackRate)
      runTimer('fakeNumber'..amountOfCombos..'-'..i, (0.002*crochet)/playbackRate, 1)
      numXPos = numXPos + 43
    end

    if isPixel then
    scaleObject('fakeRating'..amountOfCombos, 0.7*6, 0.7*6)
    setProperty('fakeRating'..amountOfCombos..'.antialiasing', false)
    scaleObject('fakeCombo'..amountOfCombos, 0.7*6, 0.7*6)
    setProperty('fakeCombo'..amountOfCombos..'.antialiasing', false)
    else
      scaleObject('fakeRating'..amountOfCombos, 0.7, 0.7)
      if compatMode then
        setProperty('fakeRating'..amountOfCombos..'.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
      else
        setProperty('fakeRating'..amountOfCombos..'.antialiasing', getPropertyFromClass('backend.ClientPrefs', 'data.globalAntialiasing'))
      end
      scaleObject('fakeCombo'..amountOfCombos, 0.7, 0.7)
      if compatMode then
        setProperty('fakeCombo'..amountOfCombos..'.antialiasing', getPropertyFromClass('ClientPrefs', 'globalAntialiasing'))
      else
        setProperty('fakeCombo'..amountOfCombos..'.antialiasing', getPropertyFromClass('backend.ClientPrefs', 'data.globalAntialiasing'))
      end
    end
end


function onGameOverStart()
  if configData.gameOverResults then
    makeLuaText("side1", 'Game Over - '..songName..' - ('..playbackRate..'x)\nScore: '..score..' | Misses: '..misses..' | Accuracy: '..realRating..'%', 1200, 30, 140)
    setTextSize("side1", 20)
    setTextAlignment("side1", "center")
    setObjectCamera("side1", "hud")
    addLuaText("side1")
    setProperty('side1.alpha', 0)
    doTweenAlpha('skillissue', 'side1', 1, 1, 'circOutIn')
  end
end

function onGameOverConfirm(isNotGoingToMenu)
  if configData.gameOverResults then
    doTweenAlpha('skillissue', 'side1', 1, 0, 'circInOut')
  end
end

--[[ Stolen Code Corner ]]--


function math.lerp(a,b,t) return a * (1-t) + b * t end -- l e r p

local textX={} -- thanks sir_top_hat on discord
local textY={}

function enableTextMove(var)
	textX[var] = getProperty(var..'.x')
	textY[var] = getProperty(var..'.y')
end

function updateTextPos(var, scroll)
	setProperty(var..'.x', (textX[var]-getProperty('camGame.scroll.x'))*scroll )
	setProperty(var..'.y', (textY[var]-getProperty('camGame.scroll.y'))*scroll )
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

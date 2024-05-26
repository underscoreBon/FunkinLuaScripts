--[[Friday Night Bloxxin' HUD]]--
-- This is a mess
enemyFakeScore = 0
enemyFakeCombo = 0
marvs = 0
playbackRate = 1 -- THIS IS FOR BACKWARDS COMPATIBILTY
allowending = false
bestCombo = 0
function onCreatePost()
    setRatingFC('?')
    -- oh yeah ha ha
    setProperty('timeBar.visible', false)
    setProperty('timeBarBG.visible', false)
    setProperty('timeTxt.visible', false)
    setProperty('scoreTxt.visible', false)

    --luaDebugMode = true
    configData = json.parse(getTextFromFile('BloxxinHUD/BloxxinCONFIG.json'))
    -- ANY EASIER WAY TO DO THIS WITHOUT LAYING OUT ALL THE VARS?!?!?!??!?!?
    botAccuracy = configData.botAccuracy
    verticalHealthBar = configData.verticalHealthBar
    marvRating = configData.marvRating
    ratingBopwhenAppear = configData.ratingBopwhenAppear
    resultsScreen = configData.resultsScreen
    centerRatings = configData.centerRatings
    ShowMSoffset = configData.ShowMSoffset
    ForeverStyle = configData.ForeverStyle
    showJudgements = configData.showJudgementCount
    animationsOnghostTap = configData.animationsOnghostTap


    -- Shaming Users Part 1 & 2
    bit = string.gsub(version,"%.","")
    bit2 = string.gsub('0.6.3',"%.","")
    curentVersion = tonumber(bit)
    targetVersion = tonumber(bit2)
    if curentVersion < targetVersion  then
      debugPrint('version checker from the holiday mod by bbpanzu')
      debugPrint('but if this shows up in the correct version, contact n_bonnie2 because i stole this')
      debugPrint('BloxxinHUD requires Psych Engine 0.6.3+, SOME ASPECTS MAY NOTY WORK PROPERLY!')
    end
    if buildTarget == 'android' then 
      debugPrint('GO PLAY ON A PC YOU IDIOT, you are gonna now be softlocked...')
      debugPrint('You are currently playing an unoffical mobile port of Psych Engine')
    end

    -- SCORE SHIT
    makeLuaText('FakeScore', '', 1800, 0, 690)
    setTextAlignment('FakeScore', 'center')
    if ForeverStyle then
    setTextSize('FakeScore', 18)
    setTextFont('FakeScore', 'Gotham.otf')
    else
      setTextSize('FakeScore', 12)
      setTextFont('FakeScore', 'PressStart2P.ttf')
    end
    addLuaText('FakeScore')
    screenCenter('FakeScore', 'x')
    setTextBorder('FakeScore', 2, '000000')

    if showJudgements then
    makeLuaText('FakeScore2', '', 1800, 0, (verticalHealthBar and 290 or 340))
    setTextAlignment('FakeScore2', 'left')
    if ForeverStyle then
    setTextSize('FakeScore2', 18)
    setTextFont('FakeScore2', 'Gotham.otf')
    else
      setTextSize('FakeScore2', 12)
      setTextFont('FakeScore2', 'PressStart2P.ttf')
    end
    addLuaText('FakeScore2')
    setTextBorder('FakeScore2', 2, '000000')
    end

    makeLuaText('P1Score', '', 1400, -180, (downscroll and 30 or 650))
    setTextAlignment('P1Score', 'right')
    setTextSize('P1Score', 60)
    setTextFont('P1Score', 'Gotham Bold.otf')
    addLuaText('P1Score')


    makeLuaText('P2Score', '', 1400, 50, (downscroll and 30 or 650))
    setTextAlignment('P2Score', 'left')
    setTextSize('P2Score', 60)
    setTextFont('P2Score', 'Gotham Bold.otf')
    addLuaText('P2Score')

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
          if getRandomBool(botAccuracy) and marvRating then
            makeEnemyRating('marv')
            enemyFakeScore = enemyFakeScore + 350
          else
              makeEnemyRating('sick')
              enemyFakeScore = enemyFakeScore + 350
          end
        elseif getRandomBool(botAccuracy/1.5) then
            makeEnemyRating('good')
            enemyFakeScore = enemyFakeScore + 200
        elseif getRandomBool(botAccuracy/1.8) then
            makeEnemyRating('bad')
            enemyFakeScore = enemyFakeScore + 100
        else
            makeEnemyRating('shit')
            enemyFakeScore = enemyFakeScore + 50
        end
    end
end

function goodNoteHit(membersIndex, noteData, noteType, isSustainNote)
    if not isSustainNote then
    strumTime = getPropertyFromGroup('notes', membersIndex, 'strumTime')
    songPos = getPropertyFromClass('Conductor', 'songPosition')
    rOffset = getPropertyFromClass('ClientPrefs','ratingOffset')

    msabsolute = math.abs(strumTime - songPos + rOffset)
    msactual = (strumTime - songPos + rOffset)

    if msabsolute <= 15*playbackRate and marvRating then
      marvs = marvs + 1
      makeRating('marv')
    elseif msabsolute <= getPropertyFromClass('ClientPrefs', 'sickWindow')*playbackRate then
        makeRating('sick')
    elseif msabsolute <= getPropertyFromClass('ClientPrefs', 'goodWindow')*playbackRate then
        makeRating('good')
    elseif msabsolute <= getPropertyFromClass('ClientPrefs', 'badWindow')*playbackRate then
        makeRating('bad')
    else
        makeRating('shit')
    end
    mscreate(msactual)
end
end

function onSongStart()
    -- Song Info
    if ForeverStyle then
    makeLuaText('SongInfo', ' - '..songName..' ['..string.upper(difficultyName)..' - '..playbackRate..'x] -', 800, 0, 5)
    else
      makeLuaText('SongInfo', songName..' - ('..string.upper(difficultyName)..') ('..playbackRate..'x)', 800, 0, 5)
    end
    setTextAlignment('SongInfo', 'center')
    setTextSize('SongInfo', 15)
    setTextFont('SongInfo', 'Gotham.otf')
    addLuaText('SongInfo')
    screenCenter('SongInfo', 'x')
    setTextBorder('SongInfo', 2, '000000')

    makeLuaText('SongInfo12', 'Friday Night Bloxxin\' HUD By: n_bonnie2', 800, 0, 23)
    setTextAlignment('SongInfo12', 'center')
    setTextSize('SongInfo12', 15)
    setTextFont('SongInfo12', 'Gotham.otf')
    addLuaText('SongInfo12')
    screenCenter('SongInfo12', 'x')
    setTextBorder('SongInfo12', 2, '000000')

    
    makeLuaText('SongInfo2', '00:00', 800, 0, 40)
    setTextAlignment('SongInfo2', 'center')
    setTextSize('SongInfo2', 15)
    setTextFont('SongInfo2', 'Gotham.otf')
    addLuaText('SongInfo2')
    screenCenter('SongInfo2', 'x')
    setTextBorder('SongInfo2', 2, '000000')
end


function onUpdatePost(elapsed)
    local timeElapsed = math.floor(getProperty('songTime')/1000)
    local timeTotal = math.floor(getProperty('songLength')/1000)
    local PreConvert = timeTotal - timeElapsed
    local OMGTIME = string.format("%.2d:%.2d", PreConvert/60%60, PreConvert%60)
    realRating = math.floor(rating * 10000) / 100 -- its also used in the results screen, so its not local

    if ForeverStyle then
      setTextString('SongInfo2', '['..OMGTIME..']')
    else 
      setTextString('SongInfo2',OMGTIME)
    end

    if not verticalHealthBar then
      if ForeverStyle then
        setTextString('FakeScore', 'Score: '..score..' • Accuracy: '..realRating..'% ['..ratingFC..'] • Combo Breaks: '..misses..' • Combo: '..getProperty('combo'))
      else
        setTextString('FakeScore', 'Accuracy: '..realRating..'% | Combo: '..getProperty('combo')..' | Misses: '..misses)
      end
    else
      setTextString('FakeScore', '')
    end

    setTextString('P1Score', score)
    setTextString('P2Score', enemyFakeScore)

    if verticalHealthBar then -- I hate this.

      if ForeverStyle then
        if marvRating then
          --debugPrint('Non Vertical, forever Style')
          setTextString('FakeScore2', 'Score: '..score..'\n Accuracy: '..realRating..'% ['..ratingFC..']\n Misses: '..misses..'\n Combo: '..getProperty('combo')..'\n\nMarvelous: '..marvs..'\n Sick: '..getProperty('sicks') - marvs..'\n Good: '..getProperty('goods')..'\n Bad: '..getProperty('bads')..'\n Shit: '..getProperty('shits'))
        else
          setTextString('FakeScore2', 'Score: '..score..'\n Accuracy: '..realRating..'% ['..ratingFC..']\n Misses: '..misses..'\n Combo: '..getProperty('combo')..'\n\nSick: '..getProperty('sicks')..'\n Good: '..getProperty('goods')..'\n Bad: '..getProperty('bads')..'\n Shit: '..getProperty('shits'))
        end

      else
        --debugPrint('Vertical, normal Style')
        if marvRating then
          setTextString('FakeScore2', 'Accuracy: '..realRating..'%\n\n Misses: '..misses..'\n\n Combo: '..getProperty('combo')..'\n\n\nMarvelous: '..marvs..'\n\n Sick: '..getProperty('sicks') - marvs..'\n\n Good: '..getProperty('goods')..'\n\n Bad: '..getProperty('bads')..'\n\n Shit: '..getProperty('shits'))
        else
          setTextString('FakeScore2', 'Accuracy: '..realRating..'%\n\n Misses: '..misses..'\n\n Combo: '..getProperty('combo')..'\n\n\nSick: '..getProperty('sicks')..'\n\n Good: '..getProperty('goods')..'\n\n Bad: '..getProperty('bads')..'\n\n Shit: '..getProperty('shits'))
        end

      end

    else
      if ForeverStyle then
        --debugPrint('Non Vertical, forever Style')
        if marvRating then
          setTextString('FakeScore2',  'Marvelous: '..marvs..'\n Sick: '..getProperty('sicks') - marvs..'\n Good: '..getProperty('goods')..'\n Bad: '..getProperty('bads')..'\n Shit: '..getProperty('shits'))
        else
          setTextString('FakeScore2',  'Sick: '..getProperty('sicks')..'\n Good: '..getProperty('goods')..'\n Bad: '..getProperty('bads')..'\n Shit: '..getProperty('shits'))
        end

      else
        --debugPrint('Non Vertical, normal Style')
        if marvRating then
          setTextString('FakeScore2',  'Marvelous: '..marvs..'\n\n Sick: '..getProperty('sicks') - marvs..'\n\n Good: '..getProperty('goods')..'\n\n Bad: '..getProperty('bads')..'\n\n Shit: '..getProperty('shits'))
        else
          setTextString('FakeScore2',  'Sick: '..getProperty('sicks')..'\n\n Good: '..getProperty('goods')..'\n\n Bad: '..getProperty('bads')..'\n\n Shit: '..getProperty('shits'))
        end
      end
    end

    if downscroll then
    setProperty('healthBar.y', 110)
    setProperty('iconP1.y', 50)
    setProperty('iconP2.y', 50)
    end

    setProperty('showCombo', false) -- unused but just in case
    setProperty('showRating', false)
    setProperty('showComboNum', false)
    setProperty('timeBar.visible', false)
    setProperty('timeBarBG.visible', false)
    setProperty('timeTxt.visible', false)
    setProperty('scoreTxt.visible', false)
    
    if verticalHealthBar then
      setProperty('healthBar.x', 910)
      setProperty('healthBar.angle', 90)
      screenCenter('healthBar', 'y')
      setProperty('iconP2.x', (getProperty('healthBar.x') + 220))
      setProperty('iconP1.x', (getProperty('healthBar.x') + 220))
      setProperty('iconP1.y', ((-getProperty('healthBar.percent')/100)*getProperty('healthBar.width')) + getProperty('healthBar.width') + 40)
      setProperty('iconP2.y', ((-getProperty('healthBar.percent')/100)*getProperty('healthBar.width')) + getProperty('healthBar.width') - 40)
    end

    if bestCombo < getProperty('combo') then -- best combo calculator real no fake
      bestCombo = getProperty('combo')
    end

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


function makeRating(combo)
    removeLuaSprite('judgement'..getProperty('combo')-1, false)
    makeLuaSprite('judgement'..getProperty('combo'), combo, (centerRatings and (middlescroll and 600 or 900) or (middlescroll and 300 or 620)), 340)
    setObjectCamera('judgement'..getProperty('combo'), 'hud')
    scaleObject('judgement'..getProperty('combo'), 0.3, 0.3)
    addLuaSprite('judgement'..getProperty('combo'), false)
    doTweenAlpha('judgement'..getProperty('combo'), 'judgement'..getProperty('combo'), 0, 1, 'quadOut')
    if ratingBopwhenAppear then
      scaleObject('judgement'..getProperty('combo'), 0.35, 0.35)
      doTweenX('funnyXbump1', 'judgement'..getProperty('combo')..'.scale', 0.3, 0.3, 'linear')
      doTweenY('funnyYbump1', 'judgement'..getProperty('combo')..'.scale', 0.3, 0.3, 'linear')
    end
end

function mscreate(vlaue)
  if ShowMSoffset then
  local relvalue = math.floor(vlaue*100)/100
  makeLuaText('msR', relvalue..'ms', 150, (centerRatings and (middlescroll and 600 or 900) or (middlescroll and 300 or 620)), 400)
  setTextSize('msR', 15)
  setTextBorder('SongInfo2', 2, '000000')
  setTextAlignment('msR', 'center')
  setTextFont('msR','PressStart2P.ttf')
  setObjectCamera('msR', 'hud')
  addLuaText('msR')
  if vlaue > 0 then
    setTextColor('msR', 'a3ffa8')
  else
    setTextColor('msR', 'ff9999')
  end
  doTweenAlpha('msR', 'msR', 0, 1, 'quadOut')
end
end

function makeEnemyRating(combobad)
    removeLuaSprite('badjudgement'..enemyFakeCombo-1, false)
    makeLuaSprite('badjudgement'..enemyFakeCombo, combobad,  (middlescroll and 25 or 50),  (middlescroll and 400 or 340))
    setObjectCamera('badjudgement'..enemyFakeCombo, 'hud')
    scaleObject('badjudgement'..enemyFakeCombo, (middlescroll and 0.2 or 0.3), (middlescroll and 0.2 or 0.3))
    addLuaSprite('badjudgement'..enemyFakeCombo, false)
    doTweenAlpha('badjudgement'..enemyFakeCombo, 'badjudgement'..enemyFakeCombo, 0, 1, 'quadOut')
    if ratingBopwhenAppear then
      scaleObject('badjudgement'..enemyFakeCombo, (middlescroll and 0.25 or 0.35), (middlescroll and 0.25 or 0.35))
      doTweenX('funnyXbump', 'badjudgement'..enemyFakeCombo..'.scale',(middlescroll and 0.2 or 0.3),0.3, 'linear')
      doTweenY('funnyYbump', 'badjudgement'..enemyFakeCombo..'.scale',(middlescroll and 0.2 or 0.3),0.3, 'linear')
    end
end

function onTweenCompleted(tag)
    if string.find(tag, 'judgement') then
        removeLuaSprite(tag, false)
    end
    if string.find(tag, 'badjudgement') then
        removeLuaSprite(tag, false)
    end
end


-- Results Screen
function onEndSong()
  removeLuaText('SongInfo', false)
  removeLuaText('SongInfo12', false)
  removeLuaText('SongInfo2', false)
  removeLuaText('P1Score', false)
  removeLuaText('P2Score', false)
  removeLuaText('FakeScore', false)
  removeLuaText('FakeScore2', false)
  if not allowending and resultsScreen then
  openCustomSubstate('resultsScreen', true)
  return Function_Stop
  end
  return Function_Continue
end

function onCustomSubstateCreate(name)
  if name == 'resultsScreen' then 
    setProperty('camHUD.alpha', 1)
    setProperty('healthBar.visible', false)
    setProperty('healthBarBG.visible', false) -- idk 
    setProperty('iconP1.visible', false)
    setProperty('iconP2.visible', false)

    makeLuaSprite('edgyteen', nil, 0,0)
    makeGraphic('edgyteen', screenWidth, screenHeight, '000000')
    addLuaSprite('edgyteen', false)
    setProperty('edgyteen.alpha', 0.5)
    setObjectCamera('edgyteen', 'other')

    -- shaming part 3
    if buildTarget == 'android' then
    makeLuaText('WHAT', 'go get an offical build you r*tard.', 1800, 0, 680)
    else
    makeLuaText('WHAT', 'Press [ENTER] to Continue', 1800, 0, 680)
    end
    setTextAlignment('WHAT', 'center')
    setTextSize('WHAT', 28)
    setTextFont('WHAT', 'PressStart2P.ttf')
    addLuaText('WHAT')
    screenCenter('WHAT', 'x')
    setTextColor('WHAT', '82ffb8')
    setObjectCamera('WHAT', 'other')

    makeLuaText('clearText2', songName..'\n\nCleared!\n\n'..ratingFC, 800, 10, 50)
    setTextAlignment('clearText2', 'left')
    setTextSize('clearText2', 35)
    setTextFont('clearText2', 'PressStart2P.ttf')
    addLuaText('clearText2')
    setObjectCamera('clearText2', 'other')
    
    makeLuaText('inputiused', 'Input Used: PsychEngine V.'..version, 1800, 10, screenHeight - 70)
    setTextAlignment('inputiused', 'left')
    setTextSize('inputiused', 15)
    setTextFont('inputiused', 'PressStart2P.ttf')
    addLuaText('inputiused')
    setTextColor('inputiused', 'ff425b')
    setObjectCamera('inputiused', 'other')

    if marvRating then
    makeLuaText('clearText3', 'Judgements:\n\nMarvelous - '..marvs..'\n\nSick - '..getProperty('sicks') - marvs..'\n\nGood - '..getProperty('goods')..'\n\nBad - '..getProperty('bads')..'\n\nShit - '..getProperty('shits')..'\n\n\nScore - '..score..'\n\nAccuracy - '..realRating..'%\n\nMisses - '..misses..'\n\nBest Combo - '..bestCombo, 800, 10, 280)
    else
      makeLuaText('clearText3', 'Judgements:\n\nSick - '..getProperty('sicks') - marvs..'\n\nGood - '..getProperty('goods')..'\n\nBad - '..getProperty('bads')..'\n\nShit - '..getProperty('shits')..'\n\n\nScore - '..score..'\n\nAccuracy - '..realRating..'%\n\nMisses - '..misses..'\n\nBest Combo - '..bestCombo, 800, 10, 280)
    end
    setTextAlignment('clearText3', 'left')
    setTextSize('clearText3', 14)
    setTextFont('clearText3', 'PressStart2P.ttf')
    addLuaText('clearText3')
    setObjectCamera('clearText3', 'other')

    if realRating == 100 then -- https://osu.ppy.sh/wiki/en/Gameplay/Grade 
      grade = 'SS'
    elseif realRating > 95 then
      grade = 'S'
    elseif realRating > 90 then
      grade = 'A'
    elseif realRating > 80 then
      grade = 'B'
    elseif realRating > 70 then
      grade = 'C'
    else
      grade = 'D'
    end
    makeAnimatedLuaSprite('grade', 'OSUMANIArate', 750, 0)
    addAnimationByPrefix('grade', 'SS', 'OSUMANIArate ss', 24, true)
    addAnimationByPrefix('grade', 'S', 'OSUMANIArate s', 24, true)
    addAnimationByPrefix('grade', 'A', 'OSUMANIArate a', 24, true)
    addAnimationByPrefix('grade', 'B', 'OSUMANIArate b', 24, true)
    addAnimationByPrefix('grade', 'C', 'OSUMANIArate c', 24, true)
    addAnimationByPrefix('grade', 'D', 'OSUMANIArate d', 24, true)
    addLuaSprite('grade')
    scaleObject('grade', 2.25,2.25)
    screenCenter('grade', 'y')
    setObjectCamera('grade', 'other')
    playAnim('grade', grade, true)

  end
end

function onCustomSubstateUpdate(name, elapsed)
  if name == 'resultsScreen' then
    if keyboardJustPressed('ENTER') then
      allowending = true
      endSong()
    end
  end
end

function onCustomSubstateDestroy(name)
  if name == 'resultsScreen' then
    removeLuaSprite('edgyteen', false)
    removeLuaText('WHAT', false)
    removeLuaText('clearText2', false)
    removeLuaText('clearText3', false)
    removeLuaText('inputiused', false)
    removeLuaSprite('grade', false)
  end
end

--[[ Stolen Code Corner ]]--


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

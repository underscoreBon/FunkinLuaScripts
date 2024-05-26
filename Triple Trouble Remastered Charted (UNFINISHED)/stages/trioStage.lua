function onCreate()
    
    makeLuaSprite('TrioGlitch','Phase3/Normal/glitch',-600,-500)
    makeLuaSprite('TrioBG','Phase3/Normal/BackBush',-600,-500)
    scaleObject('TrioBG',1.2,1.2)
    setScrollFactor('TrioBG',0.9,0.9)
    makeLuaSprite('TrioTTTrees','Phase3/Normal/TTTrees',-600,-500)
    setScrollFactor('TrioTTTrees',0.8,0.8)
    scaleObject('TrioTTTrees',1.2,1.2)
    makeLuaSprite('TrioTree','Phase3/Normal/FGTree1',-720,-500)
    setScrollFactor('TrioTree',1.1,1)
    makeLuaSprite('TrioTree2','Phase3/Normal/FGTree2',-400,-500)
    setScrollFactor('TrioTree2',1.1,1)
    makeLuaSprite('TrioGround','Phase3/Normal/TopBushes',-600,-600)
    scaleObject('TrioGround',1.2,1.2)

        makeAnimatedLuaSprite('XenoGlitch','Phase3/NewTitleMenuBG',-450,-250)
        scaleObject('XenoGlitch',4.2,4.2)
        setProperty('XenoGlitch.antialiasing',false)
        addAnimationByPrefix('XenoGlitch','WowSky','TitleMenuSSBG',24,true)
        addLuaSprite('XenoGlitch',false)
        setProperty('XenoGlitch.visible',false)

        makeLuaSprite('XenoBackTrees','Phase3/xeno/BackTrees',-600,-500)
        setScrollFactor('XenoBackTrees',0.8,0.8)
        scaleObject('XenoBackTrees',1.2,1.2)
        setProperty('XenoBackTrees.visible',false)
        
        makeLuaSprite('XenoGround','Phase3/xeno/Grass',-600,-600)
        scaleObject('XenoGround',1.2,1.2)
        setProperty('XenoGround.visible',false)

        addLuaSprite('XenoGlitch')
        addLuaSprite('XenoBackTrees')
        addLuaSprite('XenoGround')

        makeAnimatedLuaSprite('Phase3Static', 'Phase3Static', 0,0)
        addAnimationByPrefix('Phase3Static', 'funny', 'Phase3Static instance 1', 24, false)
        scaleObject('Phase3Static',4, 4)
        setObjectCamera('Phase3Static', 'other')
        addLuaSprite('Phase3Static', false)
        setProperty('Phase3Static.visible',false)


    addLuaSprite('TrioGlitch')
    addLuaSprite('TrioTTTrees',false)
    addLuaSprite('TrioBG',false)
    addLuaSprite('TrioGround',false)
    addLuaSprite('TrioTree',true)
    addLuaSprite('TrioTree2',true)
end

function switchStage(num)
    if num == '1' then
            setProperty('defaultCamZoom',0.65)
            setProperty('TrioGlitch.visible',true)
            setProperty('TrioGround.visible',true)
            setProperty('TrioBG.visible',true)
            setProperty('TrioTree.visible',true)
            setProperty('TrioTree2.visible',true)
            setProperty('TrioTTTrees.visible',true)

            setProperty('XenoGlitch.visible',false)
            setProperty('XenoBackTrees.visible',false)
            setProperty('XenoGround.visible',false)
    end
    if num == '2' then
        setProperty('defaultCamZoom',0.9)
        setProperty('TrioGlitch.visible',false)
        setProperty('TrioGround.visible',false)
        setProperty('TrioBG.visible',false)
        setProperty('TrioTree.visible',false)
        setProperty('TrioTree2.visible',false)
        setProperty('TrioTTTrees.visible',false)

        setProperty('XenoGlitch.visible',true)
        setProperty('XenoBackTrees.visible',true)
        setProperty('XenoGround.visible',true)
    end
end

function onEvent(eventName, value1, value2)
    if eventName == 'stagechange' then
    switchStage(value1)
    end
    if eventName == 'funnystatic' then
        setProperty('Phase3Static.visible', true)
        playAnim('Phase3Static', 'funny', true)
        runTimer('hideyourself', 1.5)
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
    if tag == 'hideyourself' then
        setProperty('Phase3Static.visible',false)
    end
end
local funnyJumpersAllowed = false
local buildermanStop = false

function onCreatePost()
	-- SOUNDS.
	precacheSound('rocketlaunch')
	precacheSound('guestDies')
	precacheImage('GuestDeath')
	precacheImage('GuestDeath2P1')
	precacheImage('GuestDeath2P2')

	makeLuaSprite('cmrbg', 'sky', -249, 202)
	setScrollFactor('cmrbg', 1.9, 1.9)
	addLuaSprite('cmrbg')

	makeLuaSprite('SpotlightSpr1', 'Spotlight_asset', -1900, -1100)
	addLuaSprite('SpotlightSpr1', true)
	makeLuaSprite('SpotlightSpr2', 'Spotlight_asset', 2800, -1100)
	addLuaSprite('SpotlightSpr2', true)
	setProperty('SpotlightSpr2.flipX', true)
	setProperty('SpotlightSpr2.flipX', false)

	makeAnimatedLuaSprite('Bgfight1', 'bggamers', 116, 378)
	addAnimationByPrefix('Bgfight1', 'bop' ,"Background Bois (toadver) BGChar", 54, false)
	setScrollFactor('Bgfight1', 1.9, 1.9)
	addLuaSprite('Bgfight1')

	makeLuaSprite('shedletsky', 'shedletsky', -280, 720)
	setScrollFactor('shedletsky', 1.9, 1.9)
	addLuaSprite('shedletsky')

	makeLuaSprite('dodgeball', 'dodgeball', -280, 720)
	setScrollFactor('dodgeball', 1.9, 1.9)
	addLuaSprite('dodgeball')

	makeLuaSprite('snyfort', 'snyfort', 1200, 720)
	setScrollFactor('snyfort', 1.9, 1.9)
	addLuaSprite('snyfort')
	doTweenAngle('spinny', 'snyfort', -360, 1.2, 'linear')

	makeLuaSprite('merely', 'merely', 500, 720)
	setScrollFactor('merely', 1.9, 1.9)
	addLuaSprite('merely')

	makeLuaSprite('rocketblock', 'rocket', 270, 470)
	setScrollFactor('rocketblock', 1.9, 1.9)
	setGraphicSize('rocketblock', getProperty('rocketblock.width') * 0.1)
	addLuaSprite('rocketblock')
	setProperty('rocketblock.visible', false)

	-- GUETS!
	if not lowQuality then
		makeAnimatedLuaSprite('GuestDeadLayer1', 'GuestDeath', 602, 505)
		addAnimationByPrefix('GuestDeadLayer1', 'yes', "GuestDeath idle", 42, false)
		setGraphicSize('GuestDeadLayer1', getProperty('GuestDeadLayer1.width') * 0.7)
		addLuaSprite('GuestDeadLayer1')
	end

	makeLuaSprite('cmrfloor', 'floor', -250, 14)
	addLuaSprite('cmrfloor')

	if not lowQuality then
		makeAnimatedLuaSprite('Nooblingsspr', 'Nooblings', 30, 256)
		addAnimationByPrefix('Nooblingsspr', 'bop', "Nooblings Idle", 42, false)
		setGraphicSize('Nooblingsspr', getProperty('Nooblingsspr.width') * 0.7)
		addLuaSprite('Nooblingsspr')
		setProperty('Nooblingsspr.color', getColorFromHex('000000'))

		makeAnimatedLuaSprite('Guestspr', 'Guest', 695, 139)
		addAnimationByPrefix('Guestspr', 'bop2', "GuestDead Limbs", 42, false)
		addAnimationByPrefix('Guestspr', 'bop', "Guest Idle", 42, true)
		setGraphicSize('Guestspr', getProperty('Guestspr.width') * 0.7)
		addLuaSprite('Guestspr')
		setProperty('Guestspr.color', getColorFromHex('000000'))
		playAnim('Guestspr', 'bop', true)

		makeAnimatedLuaSprite('GuestDeadLayer2P1', 'GuestDeath2P1', 84, 1055)
		addAnimationByPrefix('GuestDeadLayer2P1', 'yes', "GuestDeath2P1 idle", 42, false)
		setGraphicSize('GuestDeadLayer2P1', getProperty('GuestDeadLayer2P1.width') * 0.7)
		addLuaSprite('GuestDeadLayer2P1')

		makeAnimatedLuaSprite('GuestDeadLayer2P2', 'GuestDeath2P2', 30, 256)
		addAnimationByPrefix('GuestDeadLayer2P2', 'yes', "GuestDeath2P2 idle", 42, false)
		setGraphicSize('GuestDeadLayer2P2', getProperty('GuestDeadLayer2P2.width') * 0.7)
		addLuaSprite('GuestDeadLayer2P2')

		makeAnimatedLuaSprite('Buildermanspr', 'Builderman', 1032, 191)
		addAnimationByPrefix('Buildermanspr', 'uhoh', "Builderman Shock", 42, false)
		addAnimationByPrefix('Buildermanspr', 'bop', "Builderman Idle", 42, false)
		setGraphicSize('Buildermanspr', getProperty('Buildermanspr.width') * 0.7)
		addLuaSprite('Buildermanspr')
		setProperty('Buildermanspr.color', getColorFromHex('000000'))
	end
	setProperty('dad.color', getColorFromHex('000000'))
end

function onTweenCompleted(tag)
	if tag == 'spinny' then
		doTweenAngle('spinny2', 'snyfort', 0, 1.2, 'linear')
	end
	if tag == 'spinny2' then
		doTweenAngle('spinny2', 'snyfort', -360, 1.2, 'linear')
	end
	if tag == 'tween2' then
		runTimer('tween2after', 0.2)
	end
	if tag == 'rocket1' then
		cancelTween('sussytween')
	end
end

function onEvent(eventName, value1, value2)
	if eventName == 'Spotlight Transition 1' then
		if dadName == 'noob' then
		addAnimationByPrefix('dad', 'singLEFT', 'Noob Get Down', 24)
		addAnimationByPrefix('dad', 'singDOWN', 'Noob Get Down2', 24)
	end
		runTimer('tweeny', 0.06)
		doTweenAngle('tween1', 'SpotlightSpr1', 24, 0.1, 'linear')
		doTweenX('tween2', 'SpotlightSpr1', -2450, 0.1, 'quadInOut')
	end
	if eventName == 'Spotlight Transition 2' then
		if dadName == 'noob' then
		addAnimationByPrefix('dad', 'singLEFT', 'Noob Right', 24)
		addAnimationByPrefix('dad', 'singDOWN', 'Noob Down', 24)
		end
		doTweenX('swat', 'SpotlightSpr1', -4000, 1.9, 'cubeIn')
		doTweenX('swat2', 'SpotlightSpr2', 1300, 1.8, 'cubeIn')
		runTimer('jumpers', 2)
	end
	if eventName == 'Shoot Rocket Launcher' then
		setProperty('rocketblock.visible', true)
		doTweenX('rocket1', 'rocketblock', 830, 1.6, 'linear')
		doTweenX('rocket2', 'rocketblock.scale', 0.8, 1.6, 'linear')
		doTweenY('rocket3', 'rocketblock.scale', 0.8, 1.6, 'linear')
		doTweenY('sussytween', 'rocketblock', -0.1, 5.8, 'linear')
		playSound('rocketLaunch', 0.6)
	end
	if eventName == 'Kill Guest' then
		buildermanStop = true
		playAnim('GuestDeadLayer1', 'yes', true)
		playAnim('GuestDeadLayer2', 'yes', true)
		playAnim('Buildermanspr', 'uhoh', true)
		setProperty('GuestDeadLayer1.y', 80)
		setProperty('GuestDeadLayer2P1.y', -70)
		runTimer('backatit', 0.1)
		runTimer('corpse', 0.8)
		runTimer('gone', 1)
		playSound('guestDies', 0.6)
		removeLuaSprite('Guestspr')
		removeLuaSprite('rocketblock')
	end
	if eventName == 'Noob Up Alt Anim 1' then -- Very clever devs.
		if dadName == 'noob' then
		addAnimationByPrefix('dad', 'singUP', 'Noob NotUp', 24)
	end
	end
	if eventName == 'Noob Up Alt Anim 2' then
		if dadName == 'noob' then
		addAnimationByPrefix('dad', 'singUP', 'Noob NotNotUp', 24)
	end
	end
	if eventName == 'Noob Up Alt Anim Reset' then
		if dadName == 'noob' then
			addAnimationByPrefix('dad', 'singUP', 'Noob Up', 24)
		end
	end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'tweeny' then
		doTweenColor('unracist', 'Buildermanspr', getColorFromHex('FFFFFF'), 0.2, 'linear')
	end
	if tag == 'jumpers' then
		removeLuaSprite('SpotlightSpr1')
		removeLuaSprite('SpotlightSpr2')
		funnyJumpersAllowed = true
	end
	if tag == 'tween2after' then
		doTweenAngle('tweenie1', 'SpotlightSpr1', 24, 0.15, 'quadInOut')
		doTweenX('tweenie2', 'SpotlightSpr1', -3520, 0.15, 'quadInOut')
		doTweenAngle('atweenie1', 'SpotlightSpr2', 1, 0.15, 'quadInOut')
		doTweenX('atweenie2', 'SpotlightSpr2', 370, 0.15, 'quadInOut')
		doTweenColor('unracist2', 'Guestspr', getColorFromHex('FFFFFF'), 0.2, 'linear')
		doTweenColor('unracist3', 'Nooblingsspr', getColorFromHex('FFFFFF'), 0.2, 'linear')
		doTweenColor('unracist4', 'dad', getColorFromHex('FFFFFF'), 0.25, 'linear')
	end
	if tag == 'backatit' then
		buildermanStop = false
	end
	if tag == 'corpse' then
		setProperty('GuestDeadLayer2P2.y', -70)
		playAnim('GuestDeadLayer2P2', 'yes')
		removeLuaSprite('GuestDeadLayer2P1')
	end
	if tag == 'gone' then
		removeLuaSprite('GuestDeadLayer1')
	end
end

function onBeatHit()
	playAnim('Nooblingsspr', 'bop', true)
	playAnim('Guestspr', 'bop', true)
	if not buildermanStop then
		playAnim('Buildermanspr', 'bop', true)
	end
	playAnim('Bgfight1', 'bop', true)
end
function onCreate()
	makeLuaSprite('IMG_3090', 'stages/stabbable/IMG_3090', -1740, -1090);
	scaleObject('IMG_3090', 1.2, 1.2);
	setScrollFactor('IMG_3090', 1, 1);
	setProperty('IMG_3090.antialiasing', true);
	setObjectOrder('IMG_3090', 0);

	makeLuaSprite('IMG_3088', 'stages/stabbable/IMG_3088', -340, 620);
	scaleObject('IMG_3088', 1.7, 1.7);
	setScrollFactor('IMG_3088', 1, 1);
	setProperty('IMG_3088.antialiasing', true);
	setObjectOrder('IMG_3088', 1);

	makeAnimatedLuaSprite('glitch', 'stages/stabbable/glitch', -630, 80);
	scaleObject('glitch', 1, 1);
	addAnimationByPrefix('glitch', '', '', 5, true);
	setScrollFactor('glitch', 1, 1);
	setProperty('glitch.antialiasing', true);
	setObjectOrder('glitch', 2);

	setScrollFactor('gfGroup', 0.95, 0.95);
	setProperty('gfGroup.antialiasing', true);
	setObjectOrder('gfGroup', 3);

	makeAnimatedLuaSprite('bfbotherglitch', 'stages/stabbable/bfbotherglitch', -330, 370);
	scaleObject('bfbotherglitch', 1, 1);
	addAnimationByPrefix('bfbotherglitch', '', '', 4, true);
	setScrollFactor('bfbotherglitch', 1, 1);
	setProperty('bfbotherglitch.antialiasing', true);
	setObjectOrder('bfbotherglitch', 4);

	setScrollFactor('dadGroup', 1, 1);
	setProperty('dadGroup.antialiasing', true);
	setObjectOrder('dadGroup', 5);

	setScrollFactor('boyfriendGroup', 1, 1);
	setProperty('boyfriendGroup.antialiasing', true);
	setObjectOrder('boyfriendGroup', 6);

	makeAnimatedLuaSprite('pibby', 'stages/stabbable/pibby', 880, 390);
	scaleObject('pibby', 0.7, 0.7);
	addAnimationByPrefix('pibby', '', '', 20, false);
	setScrollFactor('pibby', 1, 1);
	setProperty('pibby.antialiasing', true);
	setObjectOrder('pibby', 7);

end
function onCreate()
	makeLuaSprite('IMG_4039', 'stages/crossed/IMG_4039', -640, -180);
	scaleObject('IMG_4039', 1, 1);
	setScrollFactor('IMG_4039', 1, 1);
	setProperty('IMG_4039.antialiasing', true);
	setObjectOrder('IMG_4039', 0);

	makeAnimatedLuaSprite('glitch', 'stages/crossed/glitch', -1010, -300);
	scaleObject('glitch', 1.2, 1.2);
	addAnimationByPrefix('glitch', '', '', 9, true);
	setScrollFactor('glitch', 1, 1);
	setProperty('glitch.antialiasing', true);
	setObjectOrder('glitch', 1);

	makeAnimatedLuaSprite('bfbotherglitch', 'stages/crossed/bfbotherglitch', -580, 60);
	scaleObject('bfbotherglitch', 1, 1);
	addAnimationByPrefix('bfbotherglitch', '', '', 5, true);
	setScrollFactor('bfbotherglitch', 1, 1);
	setProperty('bfbotherglitch.antialiasing', true);
	setObjectOrder('bfbotherglitch', 2);

	setScrollFactor('gfGroup', 0.95, 0.95);
	setProperty('gfGroup.antialiasing', true);
	setObjectOrder('gfGroup', 3);

	setScrollFactor('dadGroup', 1, 1);
	setProperty('dadGroup.antialiasing', true);
	setObjectOrder('dadGroup', 4);

	setScrollFactor('boyfriendGroup', 1, 1);
	setProperty('boyfriendGroup.antialiasing', true);
	setObjectOrder('boyfriendGroup', 5);

	makeAnimatedLuaSprite('pibby', 'stages/crossed/pibby', 710, 390);
	scaleObject('pibby', 0.7, 0.7);
	addAnimationByPrefix('pibby', '', '', 20, false);
	setScrollFactor('pibby', 1, 1);
	setProperty('pibby.antialiasing', true);
	setObjectOrder('pibby', 6);

end
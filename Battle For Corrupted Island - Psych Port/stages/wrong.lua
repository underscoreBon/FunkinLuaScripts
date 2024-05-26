function onCreate()
	makeLuaSprite('IMG_0488', 'stages/wrong/IMG_0488', -970, -560);
	scaleObject('IMG_0488', 1, 1);
	setScrollFactor('IMG_0488', 1, 1);
	setProperty('IMG_0488.antialiasing', true);
	setObjectOrder('IMG_0488', 0);

	makeAnimatedLuaSprite('bfbotherglitch', 'stages/wrong/bfbotherglitch', -1220, 230);
	scaleObject('bfbotherglitch', 1, 1);
	addAnimationByPrefix('bfbotherglitch', '', '', 5, true);
	setScrollFactor('bfbotherglitch', 1, 1);
	setProperty('bfbotherglitch.antialiasing', true);
	setObjectOrder('bfbotherglitch', 1);

	setScrollFactor('gfGroup', 0.95, 0.95);
	setProperty('gfGroup.antialiasing', true);
	setObjectOrder('gfGroup', 2);

	setScrollFactor('dadGroup', 1, 1);
	setProperty('dadGroup.antialiasing', true);
	setObjectOrder('dadGroup', 3);

	setScrollFactor('boyfriendGroup', 1, 1);
	setProperty('boyfriendGroup.antialiasing', true);
	setObjectOrder('boyfriendGroup', 4);

	makeAnimatedLuaSprite('pibby', 'stages/wrong/pibby', 790, 380);
	scaleObject('pibby', 0.7, 0.7);
	addAnimationByPrefix('pibby', '', '', 20, false);
	setScrollFactor('pibby', 1, 1);
	setProperty('pibby.antialiasing', true);
	setObjectOrder('pibby', 5);

	makeAnimatedLuaSprite('pes', 'stages/wrong/pes', -290, 260);
	scaleObject('pes', 1.9, 1.9);
	addAnimationByPrefix('pes', '', '', 20, false);
	setScrollFactor('pes', 1, 1);
	setProperty('pes.antialiasing', true);
	setObjectOrder('pes', 6);

end
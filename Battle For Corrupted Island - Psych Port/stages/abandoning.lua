function onCreate()
	makeLuaSprite('TACO', 'stages/abandoning/TACO', -250, -140);
	scaleObject('TACO', 1.5, 1.5);
	setScrollFactor('TACO', 1, 1);
	setProperty('TACO.antialiasing', true);
	setObjectOrder('TACO', 0);

	makeAnimatedLuaSprite('glitch', 'stages/abandoning/glitch', -1240, -40);
	scaleObject('glitch', 1.2, 1.2);
	addAnimationByPrefix('glitch', '', '', 5, true);
	setScrollFactor('glitch', 1, 1);
	setProperty('glitch.antialiasing', true);
	setObjectOrder('glitch', 1);

	makeAnimatedLuaSprite('gelatear', 'stages/abandoning/gelatear', 620, 240);
	scaleObject('gelatear', 0.9, 0.9);
	addAnimationByPrefix('gelatear', '', '', 16, true);
	setScrollFactor('gelatear', 1, 1);
	setProperty('gelatear.antialiasing', true);
	setObjectOrder('gelatear', 2);

	makeAnimatedLuaSprite('bfbotherglitch', 'stages/abandoning/bfbotherglitch', -520, 270);
	scaleObject('bfbotherglitch', 1, 1);
	addAnimationByPrefix('bfbotherglitch', '', '', 4, true);
	setScrollFactor('bfbotherglitch', 1, 1);
	setProperty('bfbotherglitch.antialiasing', true);
	setObjectOrder('bfbotherglitch', 3);

	setScrollFactor('gfGroup', 0.95, 0.95);
	setProperty('gfGroup.antialiasing', true);
	setObjectOrder('gfGroup', 4);

	setScrollFactor('dadGroup', 1, 1);
	setProperty('dadGroup.antialiasing', true);
	setObjectOrder('dadGroup', 5);

	setScrollFactor('boyfriendGroup', 1, 1);
	setProperty('boyfriendGroup.antialiasing', true);
	setObjectOrder('boyfriendGroup', 6);
end
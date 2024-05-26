function onCreate()
	makeLuaSprite('corruptedflower', 'stages/petals/corruptedflower', -220, -300);
	scaleObject('corruptedflower', 2.1, 2.1);
	setScrollFactor('corruptedflower', 1, 1);
	setProperty('corruptedflower.antialiasing', true);
	setObjectOrder('corruptedflower', 0);

	makeLuaSprite('IMG_0627', 'stages/petals/IMG_0627', 60, 0);
	scaleObject('IMG_0627', 1.4, 1.4);
	setScrollFactor('IMG_0627', 1, 1);
	setProperty('IMG_0627.antialiasing', true);
	setObjectOrder('IMG_0627', 1);

	makeAnimatedLuaSprite('pibbyfly', 'stages/petals/pibbyfly', 1100, 160);
	scaleObject('pibbyfly', 0.4, 0.4);
	addAnimationByPrefix('pibbyfly', '', '', 20, false);
	setScrollFactor('pibbyfly', 1, 1);
	setProperty('pibbyfly.antialiasing', true);
	setObjectOrder('pibbyfly', 2);

	makeAnimatedLuaSprite('glitch', 'stages/petals/glitch', -580, 0);
	scaleObject('glitch', 0.7, 0.7);
	addAnimationByPrefix('glitch', '', '', 6, true);
	setScrollFactor('glitch', 1, 1);
	setProperty('glitch.antialiasing', true);
	setObjectOrder('glitch', 3);

	makeAnimatedLuaSprite('morecorruptedbfb', 'stages/petals/morecorruptedbfb', -210, 10);
	scaleObject('morecorruptedbfb', 1.6, 1.6);
	addAnimationByPrefix('morecorruptedbfb', '', '', 20, false);
	setScrollFactor('morecorruptedbfb', 1, 1);
	setProperty('morecorruptedbfb.antialiasing', true);
	setObjectOrder('morecorruptedbfb', 4);

	makeAnimatedLuaSprite('bfbotherglitch', 'stages/petals/bfbotherglitch', -650, 100);
	scaleObject('bfbotherglitch', 1.3, 1.3);
	addAnimationByPrefix('bfbotherglitch', '', '', 9, true);
	setScrollFactor('bfbotherglitch', 1, 1);
	setProperty('bfbotherglitch.antialiasing', true);
	setObjectOrder('bfbotherglitch', 5);

	setScrollFactor('gfGroup', 0.95, 0.95);
	setProperty('gfGroup.antialiasing', true);
	setObjectOrder('gfGroup', 6);

	setScrollFactor('dadGroup', 1, 1);
	setProperty('dadGroup.antialiasing', true);
	setObjectOrder('dadGroup', 7);

	setScrollFactor('boyfriendGroup', 1, 1);
	setProperty('boyfriendGroup.antialiasing', true);
	setObjectOrder('boyfriendGroup', 8);
end
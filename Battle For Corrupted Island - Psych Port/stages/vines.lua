function onCreate()
	makeLuaSprite('corruptedflower', 'stages/vines/corruptedflower', -250, -260);
	scaleObject('corruptedflower', 2.4, 2.4);
	setScrollFactor('corruptedflower', 1, 1);
	setProperty('corruptedflower.antialiasing', true);
	setObjectOrder('corruptedflower', 0);

	makeLuaSprite('IMG_0627', 'stages/vines/IMG_0627', 60, 0);
	scaleObject('IMG_0627', 1.4, 1.4);
	setScrollFactor('IMG_0627', 1, 1);
	setProperty('IMG_0627.antialiasing', true);
	setObjectOrder('IMG_0627', 1);

	makeAnimatedLuaSprite('glitch', 'stages/vines/glitch', -580, 0);
	scaleObject('glitch', 0.8, 0.8);
	addAnimationByPrefix('glitch', '', '', 6, true);
	setScrollFactor('glitch', 1, 1);
	setProperty('glitch.antialiasing', true);
	setObjectOrder('glitch', 2);

	makeAnimatedLuaSprite('bfbcorrupted', 'stages/vines/bfbcorrupted', -270, -70);
	scaleObject('bfbcorrupted', 1.6, 1.6);
	addAnimationByPrefix('bfbcorrupted', '', '', 20, false);
	setScrollFactor('bfbcorrupted', 1, 1);
	setProperty('bfbcorrupted.antialiasing', true);
	setObjectOrder('bfbcorrupted', 3);

	makeAnimatedLuaSprite('bfbotherglitch', 'stages/vines/bfbotherglitch', -100, 40);
	scaleObject('bfbotherglitch', 1, 1);
	addAnimationByPrefix('bfbotherglitch', '', '', 6, true);
	setScrollFactor('bfbotherglitch', 1, 1);
	setProperty('bfbotherglitch.antialiasing', true);
	setObjectOrder('bfbotherglitch', 4);

	setScrollFactor('gfGroup', 0.95, 0.95);
	setProperty('gfGroup.antialiasing', true);
	setObjectOrder('gfGroup', 5);

	setScrollFactor('dadGroup', 1, 1);
	setProperty('dadGroup.antialiasing', true);
	setObjectOrder('dadGroup', 6);

	setScrollFactor('boyfriendGroup', 1, 1);
	setProperty('boyfriendGroup.antialiasing', true);
	setObjectOrder('boyfriendGroup', 7);

	makeAnimatedLuaSprite('pibby', 'stages/vines/pibby', 790, 410);
	scaleObject('pibby', 0.7, 0.7);
	addAnimationByPrefix('pibby', '', '', 20, false);
	setScrollFactor('pibby', 1, 1);
	setProperty('pibby.antialiasing', true);
	setObjectOrder('pibby', 8);

end
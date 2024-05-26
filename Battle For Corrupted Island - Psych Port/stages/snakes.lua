function onCreate()
	makeLuaSprite('corruptedflower', 'stages/snakes/corruptedflower', 0, -250);
	scaleObject('corruptedflower', 2.1, 2.1);
	setScrollFactor('corruptedflower', 1, 1);
	setProperty('corruptedflower.antialiasing', true);
	setObjectOrder('corruptedflower', 0);

	makeLuaSprite('IMG_0627', 'stages/snakes/IMG_0627', 60, 0);
	scaleObject('IMG_0627', 1.4, 1.4);
	setScrollFactor('IMG_0627', 1, 1);
	setProperty('IMG_0627.antialiasing', true);
	setObjectOrder('IMG_0627', 1);

	makeAnimatedLuaSprite('bfbotherglitch', 'stages/snakes/bfbotherglitch', -140, 40);
	scaleObject('bfbotherglitch', 1, 1);
	addAnimationByPrefix('bfbotherglitch', '', '', 5, true);
	setScrollFactor('bfbotherglitch', 1, 1);
	setProperty('bfbotherglitch.antialiasing', true);
	setObjectOrder('bfbotherglitch', 2);

	makeAnimatedLuaSprite('bfbcharacters', 'stages/snakes/bfbcharacters', -270, -70);
	scaleObject('bfbcharacters', 1.6, 1.6);
	addAnimationByPrefix('bfbcharacters', '', '', 20, false);
	setScrollFactor('bfbcharacters', 1, 1);
	setProperty('bfbcharacters.antialiasing', true);
	setObjectOrder('bfbcharacters', 3);

	makeAnimatedLuaSprite('glitch', 'stages/snakes/glitch', -580, 0);
	scaleObject('glitch', 0.8, 0.8);
	addAnimationByPrefix('glitch', '', '', 6, true);
	setScrollFactor('glitch', 1, 1);
	setProperty('glitch.antialiasing', true);
	setObjectOrder('glitch', 4);

	setScrollFactor('gfGroup', 0.95, 0.95);
	setProperty('gfGroup.antialiasing', true);
	setObjectOrder('gfGroup', 5);

	setScrollFactor('dadGroup', 1, 1);
	setProperty('dadGroup.antialiasing', true);
	setObjectOrder('dadGroup', 6);

	setScrollFactor('boyfriendGroup', 1, 1);
	setProperty('boyfriendGroup.antialiasing', true);
	setObjectOrder('boyfriendGroup', 7);

	makeAnimatedLuaSprite('pibby', 'stages/snakes/pibby', 720, 410);
	scaleObject('pibby', 0.7, 0.7);
	addAnimationByPrefix('pibby', '', '', 20, false);
	setScrollFactor('pibby', 1, 1);
	setProperty('pibby.antialiasing', true);
	setObjectOrder('pibby', 8);

end
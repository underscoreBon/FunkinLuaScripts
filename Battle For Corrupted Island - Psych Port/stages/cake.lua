function onCreate()
	makeLuaSprite('IMG_3079', 'stages/cake/IMG_3079', -30, -600);
	scaleObject('IMG_3079', 1.1, 1.1);
	setScrollFactor('IMG_3079', 1, 1);
	setProperty('IMG_3079.antialiasing', true);
	setObjectOrder('IMG_3079', 0);

	makeAnimatedLuaSprite('glitch', 'stages/cake/glitch', -1310, -240);
	scaleObject('glitch', 1.4, 1.4);
	addAnimationByPrefix('glitch', '', '', 11, true);
	setScrollFactor('glitch', 1, 1);
	setProperty('glitch.antialiasing', true);
	setObjectOrder('glitch', 1);

	makeLuaSprite('IMG_4062', 'stages/cake/IMG_4062', -90, 430);
	scaleObject('IMG_4062', 1.5, 1.5);
	setScrollFactor('IMG_4062', 1, 1);
	setProperty('IMG_4062.antialiasing', true);
	setObjectOrder('IMG_4062', 2);

	makeLuaSprite('IMG_3085', 'stages/cake/IMG_3085', -20, 640);
	scaleObject('IMG_3085', 0.7, 0.7);
	setScrollFactor('IMG_3085', 1, 1);
	setProperty('IMG_3085.antialiasing', true);
	setObjectOrder('IMG_3085', 3);

	makeAnimatedLuaSprite('bfdiglitch', 'stages/cake/bfdiglitch', -110, 140);
	scaleObject('bfdiglitch', 1.2, 1.2);
	addAnimationByPrefix('bfdiglitch', '', '', 20, false);
	setScrollFactor('bfdiglitch', 1, 1);
	setProperty('bfdiglitch.antialiasing', true);
	setObjectOrder('bfdiglitch', 4);

	makeAnimatedLuaSprite('bfbotherglitch', 'stages/cake/bfbotherglitch', -370, 260);
	scaleObject('bfbotherglitch', 0.9, 0.9);
	addAnimationByPrefix('bfbotherglitch', '', '', 8, true);
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

	makeAnimatedLuaSprite('pibby', 'stages/cake/pibby', 800, 400);
	scaleObject('pibby', 0.7, 0.7);
	addAnimationByPrefix('pibby', '', '', 20, false);
	setScrollFactor('pibby', 1, 1);
	setProperty('pibby.antialiasing', true);
	setObjectOrder('pibby', 9);
end
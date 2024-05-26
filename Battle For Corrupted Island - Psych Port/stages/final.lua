function onCreate()
	makeLuaSprite('evill', 'stages/final/evill', -380, 100);
	scaleObject('evill', 2.4, 2.4);
	setScrollFactor('evill', 1, 1);
	setProperty('evill.antialiasing', true);
	setObjectOrder('evill', 0);

	makeAnimatedLuaSprite('glitch', 'stages/final/glitch', -1840, 170);
	scaleObject('glitch', 1.6, 1.6);
	addAnimationByPrefix('glitch', '', '', 4, true);
	setScrollFactor('glitch', 1, 1);
	setProperty('glitch.antialiasing', true);
	setObjectOrder('glitch', 1);

	setScrollFactor('gfGroup', 0.95, 0.95);
	setProperty('gfGroup.antialiasing', true);
	setObjectOrder('gfGroup', 2);

	setScrollFactor('dadGroup', 1, 1);
	setProperty('dadGroup.antialiasing', true);
	setObjectOrder('dadGroup', 3);

	setScrollFactor('boyfriendGroup', 1, 1);
	setProperty('boyfriendGroup.antialiasing', true);
	setObjectOrder('boyfriendGroup', 4);

	makeLuaSprite('livee', 'stages/final/livee', 1680, 100);
	scaleObject('livee', 2.4, 2.4);
	setScrollFactor('livee', 1, 1);
	setProperty('livee.antialiasing', true);
	setObjectOrder('livee', 5);

end
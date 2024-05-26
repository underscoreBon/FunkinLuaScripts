function onCreate()
	makeLuaSprite('TACO ABONDONING', 'stages/flesh/TACO ABONDONING', -1340, -270);
	scaleObject('TACO ABONDONING', 6.69999999999999, 6.69999999999999);
	setScrollFactor('TACO ABONDONING', 1, 1);
	setProperty('TACO ABONDONING.antialiasing', true);
	setObjectOrder('TACO ABONDONING', 0);

	setScrollFactor('gfGroup', 0.95, 0.95);
	setProperty('gfGroup.antialiasing', true);
	setObjectOrder('gfGroup', 1);

	setScrollFactor('dadGroup', 1, 1);
	setProperty('dadGroup.antialiasing', true);
	setObjectOrder('dadGroup', 2);

	setScrollFactor('boyfriendGroup', 1, 1);
	setProperty('boyfriendGroup.antialiasing', true);
	setObjectOrder('boyfriendGroup', 3);

	makeAnimatedLuaSprite('pibby', 'stages/flesh/pibby', 6390, 250);
	scaleObject('pibby', 0.7, 0.7);
	addAnimationByPrefix('pibby', '', '', 20, false);
	setScrollFactor('pibby', 1, 1);
	setProperty('pibby.antialiasing', true);
	setObjectOrder('pibby', 4);

	makeAnimatedLuaSprite('glitch', 'stages/flesh/glitch', -1510, -220);
	scaleObject('glitch', 1.8, 1.8);
	addAnimationByPrefix('glitch', '', '', 5, true);
	setScrollFactor('glitch', 1, 1);
	setProperty('glitch.antialiasing', true);
	setObjectOrder('glitch', 5);

end
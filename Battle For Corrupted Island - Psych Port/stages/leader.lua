function onCreate()
	makeLuaSprite('TACO ABONDONING', 'stages/leader/TACO ABONDONING', -5920, -720);
	scaleObject('TACO ABONDONING', 8.89999999999999, 8.89999999999999);
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

	makeAnimatedLuaSprite('skyrays', 'stages/leader/skyrays', 670, 5120);
	scaleObject('skyrays', 1.6, 1.6);
	addAnimationByPrefix('skyrays', '', '', 20, true);
	setScrollFactor('skyrays', 1, 1);
	setProperty('skyrays.antialiasing', true);
	setObjectOrder('skyrays', 4);

	makeAnimatedLuaSprite('cloudmoving', 'stages/leader/cloudmoving', 990, 5120);
	scaleObject('cloudmoving', 1.9, 1.9);
	addAnimationByPrefix('cloudmoving', '', '', 14, true);
	setScrollFactor('cloudmoving', 1, 1);
	setProperty('cloudmoving.antialiasing', true);
	setObjectOrder('cloudmoving', 5);

	makeAnimatedLuaSprite('pibbyfly', 'stages/leader/pibbyfly', 1620, 150);
	scaleObject('pibbyfly', 0.7, 0.7);
	addAnimationByPrefix('pibbyfly', '', '', 20, false);
	setScrollFactor('pibbyfly', 1, 1);
	setProperty('pibbyfly.antialiasing', true);
	setObjectOrder('pibbyfly', 6);

end
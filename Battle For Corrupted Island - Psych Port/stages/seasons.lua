function onCreate()
	makeLuaSprite('IMG_3089', 'stages/seasons/IMG_3089', -1500, -640);
	scaleObject('IMG_3089', 4.8, 4.8);
	setScrollFactor('IMG_3089', 1, 1);
	setProperty('IMG_3089.antialiasing', true);
	setObjectOrder('IMG_3089', 0);

	makeAnimatedLuaSprite('gc', 'stages/seasons/gc', 1850, 110);
	scaleObject('gc', 1.3, 1.3);
	addAnimationByPrefix('gc', '', '', 20, true);
	setScrollFactor('gc', 1, 1);
	setProperty('gc.antialiasing', true);
	setObjectOrder('gc', 1);

	makeAnimatedLuaSprite('grassc', 'stages/seasons/grassc', -920, 0);
	scaleObject('grassc', 1, 1);
	addAnimationByPrefix('grassc', '', '', 20, true);
	setScrollFactor('grassc', 1, 1);
	setProperty('grassc.antialiasing', true);
	setObjectOrder('grassc', 2);

	makeAnimatedLuaSprite('grasschase', 'stages/seasons/grasschase', 550, -20);
	scaleObject('grasschase', 0.8, 0.8);
	addAnimationByPrefix('grasschase', '', '', 20, true);
	setScrollFactor('grasschase', 1, 1);
	setProperty('grasschase.antialiasing', true);
	setObjectOrder('grasschase', 3);

	makeAnimatedLuaSprite('globbehind', 'stages/seasons/globbehind', 720, 10);
	scaleObject('globbehind', 0.6, 0.6);
	addAnimationByPrefix('globbehind', '', '', 8, true);
	setScrollFactor('globbehind', 1, 1);
	setProperty('globbehind.antialiasing', true);
	setObjectOrder('globbehind', 4);

	makeAnimatedLuaSprite('fssv', 'stages/seasons/fssv', -1040, -600);
	scaleObject('fssv', 1, 1);
	addAnimationByPrefix('fssv', '', '', 20, true);
	setScrollFactor('fssv', 1, 1);
	setProperty('fssv.antialiasing', true);
	setObjectOrder('fssv', 5);

	setScrollFactor('gfGroup', 0.95, 0.95);
	setProperty('gfGroup.antialiasing', true);
	setObjectOrder('gfGroup', 6);

	setScrollFactor('boyfriendGroup', 1, 1);
	setProperty('boyfriendGroup.antialiasing', true);
	setObjectOrder('boyfriendGroup', 7);

	setScrollFactor('dadGroup', 1, 1);
	setProperty('dadGroup.antialiasing', true);
	setObjectOrder('dadGroup', 8);

end
function onCreate()
	makeLuaSprite('IMG_3089 - Copy', 'stages/pibbychase/IMG_3089 - Copy', -900, -690);
	scaleObject('IMG_3089 - Copy', 7.39999999999999, 7.39999999999999);
	setScrollFactor('IMG_3089 - Copy', 1, 1);
	setProperty('IMG_3089 - Copy.antialiasing', true);
	setObjectOrder('IMG_3089 - Copy', 0);

	makeLuaSprite('IMG_3090', 'stages/pibbychase/IMG_3090', -3240, -2150);
	scaleObject('IMG_3090', 2.4, 2.4);
	setScrollFactor('IMG_3090', 1.4, 1);
	setProperty('IMG_3090.antialiasing', true);
	setObjectOrder('IMG_3090', 1);

	makeAnimatedLuaSprite('grasspibby0', 'stages/pibbychase/grasspibby0', -1090, -1040);
	scaleObject('grasspibby0', 3.2, 3.2);
	addAnimationByPrefix('grasspibby0', '', '', 24, true);
	setScrollFactor('grasspibby0', 1, 1);
	setProperty('grasspibby0.antialiasing', true);
	setObjectOrder('grasspibby0', 2);

	makeAnimatedLuaSprite('corruptionface', 'stages/pibbychase/corruptionface', -680, -90);
	scaleObject('corruptionface', 1.4, 1.4);
	addAnimationByPrefix('corruptionface', '', '', 24, true);
	setScrollFactor('corruptionface', 1, 1);
	setProperty('corruptionface.antialiasing', true);
	setObjectOrder('corruptionface', 3);

	setScrollFactor('gfGroup', 0.95, 0.95);
	setProperty('gfGroup.antialiasing', true);
	setObjectOrder('gfGroup', 4);

	setScrollFactor('dadGroup', 1, 1);
	setProperty('dadGroup.antialiasing', true);
	setObjectOrder('dadGroup', 5);

	setScrollFactor('boyfriendGroup', 1, 1);
	setProperty('boyfriendGroup.antialiasing', true);
	setObjectOrder('boyfriendGroup', 6);

	makeAnimatedLuaSprite('treecover', 'stages/pibbychase/treecover', -540, -1200);
	scaleObject('treecover', 4.9, 4.9);
	addAnimationByPrefix('treecover', '', '', 20, true);
	setScrollFactor('treecover', 1, 1);
	setProperty('treecover.antialiasing', true);
	setObjectOrder('treecover', 7);

end
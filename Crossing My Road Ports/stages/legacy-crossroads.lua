-- Code by Shadow Mario
function onCreate()
	makeLuaSprite('sky', 'legacyCrossroads/sky', -100, 0);
	setScrollFactor('sky', 0.1, 0.1);

	makeLuaSprite('city', 'legacyCrossroads/city', -10, 0);
	setScrollFactor('city', 0.3, 0.3);
	scaleObject('city', 0.85, 0.85);
	
	makeLuaSprite('street', 'legacyCrossroads/street', -40, 50);
	
	addLuaSprite('sky', false);
	addLuaSprite('city', false);
	addLuaSprite('street', false);
end
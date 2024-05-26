function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'RingNote' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'ring'); -- texture path
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashData.disabled', true); --no note splashes
			setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true);
			setPropertyFromGroup('unspawnNotes', i, 'copyAlpha', false); 
			setPropertyFromGroup('unspawnNotes', i, 'copyX', false);  
		end
	end
end

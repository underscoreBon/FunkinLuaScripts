function onCreate()
	setPropertyFromClass('GameOverSubstate', 'characterName', 'bfo'); --Character json file for the death animation
	setPropertyFromClass('GameOverSubstate', 'loopSoundName', 'gameOver'); --put in mods/music/
	setPropertyFromClass('GameOverSubstate', 'endSoundName', 'gameOverEnd'); --put in mods/music/
end

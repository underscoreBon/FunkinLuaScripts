function onCreatePost()
	--luaDebugMode = true;
	runHaxeCode([[
		game.dadGroup.y += 40;
		for (dad in game.dadGroup)
		{
			dad.cameraPosition[1] -= 40;
		}
		bfX = game.dadGroup.x;
		bfY = game.dadGroup.y;

		fakeMom = new Character(bfX - 800, bfY, 'tails');
		fakeMom.scrollFactor.set(0.97, 0.97);
		fakeMom.y += fakeMom.positionArray[1] - 50;
		game.addBehindDad(fakeMom);

		fakeDad = new Character(bfX + 255, bfY, 'knux');
		fakeDad.scrollFactor.set(0.97, 0.97);
		fakeDad.y += fakeDad.positionArray[1] - 30;
		game.addBehindDad(fakeDad);

        fakeMom.alpha = 0;
        fakeDad.alpha = 0;
	]]);
end

function onCountdownTick(counter)
	runHaxeCode([[
		if (]]..counter..[[ % fakeMom.danceEveryNumBeats == 0 && fakeMom.animation.curAnim != null && !StringTools.startsWith(fakeMom.animation.curAnim.name, 'sing') && !fakeMom.stunned)
		{
			fakeMom.dance();
		}
		if (]]..counter..[[ % fakeDad.danceEveryNumBeats == 0 && fakeDad.animation.curAnim != null && !StringTools.startsWith(fakeDad.animation.curAnim.name, 'sing') && !fakeDad.stunned)
		{
			fakeDad.dance();
		}
	]]);
end

function onBeatHit()
	runHaxeCode([[
		if (]]..curBeat..[[ % fakeMom.danceEveryNumBeats == 0 && fakeMom.animation.curAnim != null && !StringTools.startsWith(fakeMom.animation.curAnim.name, 'sing') && !fakeMom.stunned)
		{
			fakeMom.dance();
		}
		if (]]..curBeat..[[ % fakeDad.danceEveryNumBeats == 0 && fakeDad.animation.curAnim != null && !StringTools.startsWith(fakeDad.animation.curAnim.name, 'sing') && !fakeDad.stunned)
		{
			fakeDad.dance();
		}
	]]);
end

function onUpdate(elapsed)
	runHaxeCode([[
		if (game.startedCountdown && game.generatedMusic)
		{
			if (!fakeMom.stunned && fakeMom.holdTimer > Conductor.stepCrochet * 0.0011 * fakeMom.singDuration && StringTools.startsWith(fakeMom.animation.curAnim.name, 'sing') && !StringTools.endsWith(fakeMom.animation.curAnim.name, 'miss'))
			{
				fakeMom.dance();
			}
			if (!fakeDad.stunned && fakeDad.holdTimer > Conductor.stepCrochet * 0.0011 * fakeDad.singDuration && StringTools.startsWith(fakeDad.animation.curAnim.name, 'sing') && !StringTools.endsWith(fakeDad.animation.curAnim.name, 'miss'))
			{
				fakeDad.dance();
			}
		}
	]]);
end

function opponentNoteHit(id, direction, noteType, isSustainNote)
    if noteType == 'Knuckles' then
	runHaxeCode([[
		fakeDad.playAnim(game.singAnimations[]]..direction..[[], true);
		fakeDad.holdTimer = 0;
	]]);
    end
    if noteType == 'Tails' then
    runHaxeCode([[
		fakeMom.playAnim(game.singAnimations[]]..direction..[[], true);
		fakeMom.holdTimer = 0;
	]]);
    end
end

function onEvent(eventName, value1, value2)
    if eventName == 'charfadein' then
        if value1 == 'tails' then
    runHaxeCode([[
		fakeMom.alpha = 0.5;
	]]);
        end
        if value1 == 'knux' then
    runHaxeCode([[
		fakeDad.alpha = 0.5;
	]]);
        end
    end
end
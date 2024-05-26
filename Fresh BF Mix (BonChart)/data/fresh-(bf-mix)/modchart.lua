function onSongStart()
  setProperty('camZooming', true)
    for i=0,3 do
    noteTweenAlpha('yes2'..i, i ,0, 0.6, 'circInOut')
    if not middlescroll then
    noteTweenX('noaaaaa'..i, i, getPropertyFromGroup('strumLineNotes', i, 'x') - 325, 0.6, 'circInOut')
    end
    end
    for i = 4, 7 do
      if not middlescroll then
      noteTweenX('no'..i, i, getPropertyFromGroup('strumLineNotes', i, 'x') - 325, 0.6, 'circInOut')
      noteTweenAngle('no2'..i, i, 360, 0.6, 'circInOut')
      end
    end
end

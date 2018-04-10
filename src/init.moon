module = game\getModule("core")

module.draw = => lg.print("hi")

module.keyPressed = (key, scancode, isRepeat) =>
	if key == "escape"
		le.quit!
	elseif key == "f5"
		lw.setFullscreen(not lw.getFullscreen!)

print("core loaded", module)

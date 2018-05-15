module = game\getModule("core")

module.start = =>
	game\setScene(Core.Scene.MainMenu!)

module.keyPressed = (key, scancode, isRepeat) =>
	if key == "escape"
		le.quit!
	elseif key == "f5"
		lw.setFullscreen(not lw.getFullscreen!)
	elseif key == "1"
		le.quit("restart")

export Core = {
	Scene: require "module.core.scene"
	World: require "module.core.world"
}

module.log\info("core loaded")

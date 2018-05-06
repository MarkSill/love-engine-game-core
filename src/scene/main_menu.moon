class MainMenu extends Scene
	update: (dt) =>
		super(dt)
		ui.beginContainer(l("core.title.mainMenu"), 200, 200)
		ui.label(l("core.label.welcome"))
		game\setScene(Core.Scene.Singleplayer!) if ui.button(l("core.action.singleplayer"))
		game\setScene(Core.Scene.Multiplayer!) if ui.button(l("core.action.multiplayer"))
		game\setScene(Core.Scene.Settings!) if ui.button(l("core.action.settings"))
		game\setScene(Core.Scene.Mods!) if ui.button(l("core.action.mods"))
		le.quit! if ui.button(l("core.action.exit"))
		ui.endContainer!

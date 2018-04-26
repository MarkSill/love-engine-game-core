class GameSelect extends Scene
	new: (@which) =>

	update: (dt) =>
		ui.beginContainer(l("core.title.gameSelect.#{@which}"), 200, 200)
		game\back! if ui.button(l("core.action.back"))
		ui.label(l("core.label.startGame"))
		game\setScene(Core.Scene.NewGame(@which)) if ui.button(l("core.action.newGame"))
		game\setScene(Core.Scene.LoadGame(@which)) if ui.button(l("core.action.loadGame"))
		if @which == "multiplayer"
			game\setScene(Core.Scene.JoinGame!) if ui.button(l("core.action.joinGame"))
		ui.endContainer!

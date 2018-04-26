class NewGame extends Scene
	new: (@which) =>

	update: (dt) =>
		ui.beginContainer(l("core.title.newGame"), 200, 200)
		game\back! if ui.button(l("core.action.back"))
		ui.label(l("core.label.notImplemented"))
		ui.endContainer!

class LoadGame extends Scene
	new: (@which) =>
		super!

	update: (dt) =>
		super(dt)
		ui.beginContainer(l("core.title.loadGame"), 200, 200)
		game\back! if ui.button(l("core.action.back"))
		ui.label(l("core.label.notImplemented"))
		ui.endContainer!

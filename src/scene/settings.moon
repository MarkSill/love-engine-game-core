class Settings extends Scene
	update: (dt) =>
		ui.beginContainer(l("core.title.settings"), 200, 200)
		game\back! if ui.button(l("core.action.back"))
		ui.label(l("core.label.notImplemented"))
		ui.endContainer!

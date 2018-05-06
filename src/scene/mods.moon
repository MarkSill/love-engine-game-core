class Mods extends Scene
	update: (dt) =>
		super(dt)
		ui.beginContainer(l("core.title.mods"), 200, 200)
		game\back! if ui.button(l("core.action.back"))
		for module in *game.modules
			ui.label(l("core.label.mod", name:module\getName!, id:module\getID!, version:module\getVersion!))
			ui.pad(10)
			ui.label(module\getDesc!)
		ui.endContainer!

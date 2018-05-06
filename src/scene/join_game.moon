class JoinGame extends Scene
	new: =>
		super!
		@ip = "localhost"
		@port = 4242
		@name = "Player"
		@password = ""

	update: (dt) =>
		super(dt)
		ui.beginContainer(l("core.title.joinGame"), 200, 200)
		game\back! if ui.button(l("core.action.back"))
		ui.label(l("core.label.notImplemented"))
		@ip = ui.input(l("core.input.ip"), @ip)
		@port = ui.inputInt(l("core.input.port"), @port)
		@name = ui.input(l("core.input.name"), @name)
		@password = ui.input(l("core.input.password"), @password)
		ui.endContainer!

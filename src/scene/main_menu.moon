cpml = require "cpml"

class MainMenu extends Scene
	new: =>
		super!
		@sensitivity = 0.5
		helper = Core3D.VertexHelper!
		helper\addCube(0, 0, 0, 1)
		@model = Core3D.Model(helper.vertices)
		helper = Core3D.VertexHelper!
		helper\addCube(0, 0, 0, .5)
		@model2 = Core3D.Model(helper.vertices)

		@instance = Core3D.Instance(@model)
		@instance.position = cpml.vec3(0, 1, 0)
		@instance.rotation = cpml.vec3(math.rad(45))
		@instance2 = Core3D.Instance(@model2)
		@instance2.shader = Resource.Shader.create("engine/data/shaders/bright")
		@dragging = false
		@following = true

		@sun = Core3D.DirectionalLight(cpml.vec3(-0.2, -1, -0.3), cpml.vec3(0.3, 0.3, 0.3), cpml.vec3(0.4, 0.4, 0.4), cpml.vec3(0.5, 0.5, 0.5))
		@light = Core3D.PointLight(cpml.vec3(1, 1, 2), cpml.vec3(0.05, 0.05, 0.05), cpml.vec3(0.8, 0.8, 0.8), cpml.vec3(1, 1, 1), 1, 0.09, 0.032)
		@spot = Core3D.SpotLight(cpml.vec3!, cpml.vec3!, cpml.vec3(0.2), cpml.vec3(1), cpml.vec3(1), 1, 0.09, 0.032, math.cos(math.rad(12.5)), math.cos(math.rad(15)))

		helper = Core3D.VertexHelper!
		helper\addQuadY(-10, -10, 10, 10, 0, cull:false, color:{1, 1, 1}, up:true)
		floorModel = Core3D.Model(helper.vertices)
		@floor = Core3D.Instance(floorModel)
		@floor.position = cpml.vec3(0, -0.5001, 0)

		table.insert(@instances, @instance)
		table.insert(@instances, @instance2)
		table.insert(@instances, @floor)

		@skybox = Resource.Core3D.Cubemap.create("engine/data/textures/skybox", "jpg")

		game.dev = true

	update: (dt) =>
		ui.beginContainer(l("core.title.mainMenu"), 200, 200)
		ui.label(l("core.label.welcome"))
		game\setScene(Core.Scene.Singleplayer!) if ui.button(l("core.action.singleplayer"))
		game\setScene(Core.Scene.Multiplayer!) if ui.button(l("core.action.multiplayer"))
		game\setScene(Core.Scene.Settings!) if ui.button(l("core.action.settings"))
		game\setScene(Core.Scene.Mods!) if ui.button(l("core.action.mods"))
		le.quit! if ui.button(l("core.action.exit"))
		ui.endContainer!

		speed = dt * 3
		if lk.isDown("w", "up")
			@camera.position += @camera.front * speed
		elseif lk.isDown("s", "down")
			@camera.position -= @camera.front * speed
		if lk.isDown("a", "left")
			@camera.position -= @camera.right * speed
		elseif lk.isDown("d", "right")
			@camera.position += @camera.right * speed
		if lk.isDown("e")
			@camera.position += @camera.up * speed
		elseif lk.isDown("q")
			@camera.position -= @camera.up * speed

		t = lt.getTime!
		@light.position.x = 1 + math.sin(t * 2)
		@light.position.y = math.sin(t / 2) * 1

		@instance.rotation += cpml.vec3(math.rad(1), math.rad(2), math.rad(1.5)) * dt * 50
		-- @instance.rotation = cpml.vec3(0)
		-- @instance.position = cpml.vec3(0, 0, 0)

		@instance2.position = @light.position\clone!
		@instance2.shader\get!\send("lightColor", cpml.vec3.table(@light.specular))

		if @following
			@spot.position = -@camera.position
			@spot.direction = @camera.front

		super(dt)

	draw: =>
		super!
		lg.print("#{@camera.position.x}, #{@camera.position.y}, #{@camera.position.z}\nFPS: #{lt.getFPS!}")

	keyPressed: (key, scancode, isRepeat) =>
		if key == "space"
			@following = not @following

	mousePressed: (x, y, button) =>
		if button == 1
			@dragging = true
			lmo.setRelativeMode(true)

	mouseReleased: (x, y, button) =>
		if button == 1
			@dragging = false
			lmo.setRelativeMode(false)

	mouseMoved: (x, y, dx, dy) =>
		if @dragging
			@camera.angle.x += dx * @sensitivity
			@camera.angle.y -= dy * @sensitivity

debug = false

require('splash')
require('game')
require('credits')

function love.load()
	states = {"game", "credits", "splash"}

	-- Load images (global assets)
	img_fn = {"title"}
	imgs = {}
	for _,v in ipairs(img_fn) do
		imgs[v] = love.graphics.newImage("assets/"..v..".png")
		-- Set filter to nearest
		imgs[v]:setFilter("nearest", "nearest")
	end

	-- Play music and loop it
	music = love.audio.newSource("assets/day.ogg", "stream")
	music:setLooping(true)
	love.audio.play(music)

	-- Load eat fruit sound
	-- eat = love.audio.newSource("assets/shoot.ogg", "static")

	-- Initialize font, and set it
	font = love.graphics.newFont("assets/fonts/BitDaylong11.TTF", 11*scale)
	font_big = love.graphics.newFont("assets/fonts/BitDaylong11.TTF", 15*scale)
	love.graphics.setFont(font)

	-- Set background color
	love.graphics.setBackgroundColor(255,255,255)
	-- love.graphics.setFontColor(0,0,0)

	-- Set initial state
	state = "splash"

	-- Load splash and game
	splash.show_intro = true -- title scrolls in from top
	splash.load()
	credits.load()
	game.load()
end

function love.draw()
	-- Call the state's draw function
	for _,st in pairs(states) do
		if state == st then
			-- call the appropriate state function
			_G[state].draw()
		end
	end
end

function love.update(dt)
	-- Call the state's update function
	for _,st in pairs(states) do
		if state == st then
			-- call the appropriate state function
			_G[state].update(dt)
		end
	end
end

function love.keypressed(key)
	-- Quit if the escape key is pressed
	if key == 'escape' then
		love.event.push('quit')
	end
	-- Call the state's keypressed function
	for _,st in pairs(states) do
		if state == st then
			-- call the appropriate state function
			_G[state].keypressed(key)
		end
	end
	if key == "`" then
		debug = not debug
	end
end
game = {}

function game.load()
	-- Background init
	game.clock = 0
	-- Draw game background
	-- grass block comes here
end

function game.draw()
	-- Draw moving game background
	-- not applicable to me, i guess
end

function game.update(dt)
	game.clock = game.clock + dt
end

function game.keypressed(key)
end
game = {}
snake = {}

-- called once, in the beginning
function game.load()
	game.dir = 1
	-- 0 up, 1 right, 2 down, 3 left
	game.tile_len = 15
	game.spacing = 1
	game.tile_coord = game.tile_len + game.spacing
	game.x_offset = (love.graphics.getWidth() - game.tile_coord*41)/2
	game.y_offset = (love.graphics.getHeight() - game.tile_coord*31)/2

	snake.coords = {{10,15}, {11,15}, {12,15}, {13,15}, {14,15}, {15,15}}
	-- snake.coords = {{10,15}, {11,15}, {12,15}}
	snake.length = 6

	game.score = 0
	game.clock = 0
	game.stalled = false
	game.over = false
	game.paused = false
	game.ignore_keypress = false

	walls.setup()

	apple.spawn()
	apple.eaten = false
end

-- called after each update
function game.draw()
	-- draw the grid
	love.graphics.setColor(200,200,200)
	love.graphics.setLineStyle('smooth')
	for i = 0, 40 do
		for j = 0, 30 do
			love.graphics.rectangle("fill",
				game.x_offset + i*game.tile_coord,
				game.y_offset + j*game.tile_coord,
				game.tile_len, game.tile_len)
		end
	end

	-- draw the walls
	love.graphics.setColor(0,0,255)
	for i = 0, 40 do
		for j = 0, 30 do
			if walls[i][j] == true then
				love.graphics.rectangle("fill",
					game.x_offset + i*game.tile_coord,
					game.y_offset + j*game.tile_coord,
					game.tile_len, game.tile_len)
			end
		end
	end

	-- draw the snake
	love.graphics.setColor(0,0,0)
	for _, v in pairs(snake.coords) do
		love.graphics.rectangle("fill",
				game.x_offset + v[1]*game.tile_coord,
				game.y_offset + v[2]*game.tile_coord,
				game.tile_len, game.tile_len)
	end

	-- display the score
	if not game.stalled then
		love.graphics.printf("Score: " .. game.score,
		    0,280*scale,love.graphics.getWidth(),"center")
	elseif game.over then
		love.graphics.printf("Score: " .. game.score,
		    0,280*scale,love.graphics.getWidth(),"center")
		love.graphics.printf("Game over!",
		    0,10*scale,love.graphics.getWidth(),"center")
	else
		love.graphics.printf("Paused",
		    0,280*scale,love.graphics.getWidth(),"center")
	end

	-- draw the apple
	if not apple.eaten then
		love.graphics.setColor(255,0,0)
		love.graphics.rectangle("fill",
			game.x_offset + apple.pos[1]*game.tile_coord,
			game.y_offset + apple.pos[2]*game.tile_coord,
			game.tile_len, game.tile_len)
	end
end

-- called after a small, fixed interval
function game.update(dt)
	-- advance the game clock if the game isn't stalled
	if not game.stalled then
		game.clock = game.clock + 1
	end

	-- check if it's time to advance the game itself
	if game.clock == 10 then
		-- reset clock
		game.clock = 0

		-- start accepting keypresses again
		game.ignore_keypress = false

		-- find the next cell to move to
		local new_coord = {}
		new_coord[1] = snake.coords[snake.length][1]
		new_coord[2] = snake.coords[snake.length][2]
		if game.dir == 0 then
			new_coord[2] = (new_coord[2] - 1) % 31
		elseif game.dir == 1 then
			new_coord[1] = (new_coord[1] + 1) % 41
		elseif game.dir == 2 then
			new_coord[2] = (new_coord[2] + 1) % 31
		elseif game.dir == 3 then
			new_coord[1] = (new_coord[1] - 1) % 41
		end

		-- check for a self-collision
		-- however, ignore it if it is the tail
		-- since in the next move the tail moves forward
		for _, v in pairs(snake.coords) do
			if (v[1] == new_coord[1] and v[2] == new_coord[2]) and
				(v[1] ~= snake.coords[1][1] or
				 v[2] ~= snake.coords[1][2]) then
				game.end_game()
				return
			end
		end

		-- check for a collision with a wall
		if walls[new_coord[1]][new_coord[2]] == true then
			game.end_game()
			return
		end

		-- check if the apple is being eaten
		if new_coord[1] == apple.pos[1] and
			new_coord[2] == apple.pos[2] then
			apple.eaten = true
			-- increment the score
			game.score = game.score + 1
		end


		if not apple.eaten then
			-- pop the first element and add the new position
			table.remove(snake.coords, 1)
			table.insert(snake.coords, snake.length, new_coord)
		else
			-- elongate the snake
			snake.length = snake.length + 1
			table.insert(snake.coords, snake.length, new_coord)
			-- spawn a new apple
			apple.spawn()
			apple.eaten = false
		end
	end
end

function game.keypressed(key)
	-- exit to splash if esc is pressed
	if key == 'escape' then
		state = 'splash'
		splash.load()
		return
	elseif key == 'r' then
		game.load()
		return
	end

	if not game.paused then
		if not game.ignore_keypress then
			-- now ignore all keypresses until the next move
			game.ignore_keypress = true

			if key == 'up' then
				if (game.dir % 2) == 1 then
					game.dir = 0
				end
			elseif key == 'down' then
				if (game.dir % 2) == 1 then
					game.dir = 2
				end
			elseif key == 'right' then
				if (game.dir % 2) == 0 then
					game.dir = 1
				end
			elseif key == 'left' then
				if (game.dir % 2) == 0 then
					game.dir = 3
				end
			elseif key == 'p' then
				game.stalled = true
				game.paused = true
			end
		end
	else
		if key == 'p' then
			game.stalled = false
			game.paused = false
		end
	end
end

function game.end_game()
	game.stalled = true
	game.over = true
	game.ignore_keypress = false
end

function game.keyreleased(key)
end
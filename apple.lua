apple = {}

-- spawn the apple in a valid location
-- for a location to be valid, the tile
-- must not be under the snake and
-- must not have a wall there
function apple.spawn()
	local valid_apple_pos = false
	while not valid_apple_pos do
		-- spawn the apple
		apple.pos = { math.random(0,40), math.random(0,30) }
		-- check for clash with a wall
		if walls[apple.pos[1]][apple.pos[2]] ~= true then
			-- set to true if no wall there
			valid_apple_pos = true
		end
		-- check for clash with the snake
		for _, v in pairs(snake.coords) do
			if apple.pos[1] == v[1] and apple.pos[2] == v[2] then
				-- set to false if clash with snake occurs
				valid_apple_pos = false
			end
		end
	end
end
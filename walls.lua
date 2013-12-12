walls = {}

-- setup the walls
function walls.setup()
	-- top and bottom walls
	for i = 0, 40 do
		walls[i] = {}
		walls[i][0] = true
		walls[i][30] = true
	end
	-- left and right walls
	for j = 0, 10 do
		walls[0][j] = true
		walls[40][j] = true
	end
	for j = 20, 30 do
		walls[0][j] = true
		walls[40][j] = true
	end
end
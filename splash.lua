splash = {}

function splash.load()
	splash.num_items = 3 -- how many menu items?

	splash.item = 0 -- which menu item is currently selected?
	splash.item_interp = 0 -- interpolating value for the menu item

	if splash.show_intro then
		splash.dt_temp = 0
	else
		splash.dt_temp = splash.clamp_time
	end
	splash.clamp_time = 1.1

	splash.alpha =  0
	splash.alpha_dir = 0
	-- 0 means increasing
	-- 1 means decreasing
	splash.alpha_increment = 0.1
	splash.clock = 0

	love.graphics.setBackgroundColor(255,255,255)
end

function splash.draw()
	-- Game title animation
	splash.draw_title(7*splash.dt_temp*32)
	-- Show 'start' after clamp_time seconds
	if splash.dt_temp >= splash.clamp_time then
		splash.draw_selected_box(splash.item_interp)
		splash.draw_main_menu()
  end
		
	-- If previous game
	
	-- Reset the color
	love.graphics.setColor(255,255,255)
end

function splash.update(dt)
	-- Update dt_temp
	splash.dt_temp = splash.dt_temp + dt

	-- Wait clamp_time seconds, then stop in place
	if splash.dt_temp > splash.clamp_time then
		splash.dt_temp = splash.clamp_time
		splash.item_interp = splash.item_interp - ((splash.item_interp - splash.item) * 20 * dt)
	end

	splash.clock = splash.clock + 1
	if splash.clock == 1000 then
		splash.clock = 0
	end
	if splash.clock % 100 == 0 then
		splash.update_alpha(splash.clock)
	end
end

function splash.keyreleased(key)
	if splash.dt_temp < splash.clamp_time
		and (key == 'return' or key == ' ') then
		-- skip splash intro animation by pressing space
		splash.dt_temp = splash.clamp_time
		return
	end
	if splash.dt_temp == splash.clamp_time then
		if key == 'return' or key == ' ' then
			-- start the game
			if splash.item == 0 then
				state = 'game'
				game.load()
			-- show help screen
			elseif splash.item == 1 then
				-- to add
			-- quit the game
			elseif splash.item == 2 then
				love.event.quit()
			end
		end
		return
	end
end

function splash.keypressed(key)
	if splash.dt_temp >= splash.clamp_time then
		if key == 'down' then
			splash.item = (splash.item + 1) % splash.num_items
		elseif key == 'up' then
			splash.item = (splash.item - 1) % splash.num_items
		end
	end
end

-- Draw the main menu
function splash.draw_main_menu()
	love.graphics.setColor(0,0,0)
	love.graphics.printf("Play",
		0,142*scale,love.graphics.getWidth(),"center")
	love.graphics.printf("Help",
		0,162*scale,love.graphics.getWidth(),"center")
	love.graphics.printf("Quit",
		0,182*scale,love.graphics.getWidth(),"center")
end

-- Highlight the selected item
function splash.draw_selected_box(item)
	local alpha = 255*splash.alpha + 100*(1-splash.alpha)
	love.graphics.setColor(255,255,0,alpha)
	local box_width = 150
	local box_height = 40
	local y_offset = item*40
	love.graphics.rectangle("fill", 400-(box_width/2),
		270+y_offset, box_width, box_height)
end

-- Draw the title
function splash.draw_title(y)
	love.graphics.draw(imgs["title"],239,y-90,0,2,2)
end

-- Update the menu alpha
function splash.update_alpha(clock)
	-- alpha value should go from 0 to 1 and then back to 0 again
	if splash.alpha_dir == 0 then
		splash.alpha = splash.alpha + splash.alpha_increment
		if splash.alpha > 1 then
			splash.alpha = 2 - splash.alpha
			splash.alpha_dir = 1
		end
	else
		splash.alpha = splash.alpha - splash.alpha_increment
		if splash.alpha < 0 then
			splash.alpha = -1*splash.alpha
			splash.alpha_dir = 0
		end
	end
end
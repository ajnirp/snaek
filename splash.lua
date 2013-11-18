splash = {}

function splash.load()
	splash.num_items = 4 -- how many menu items?
	splash.item = 0 -- which menu item is currently selected?
	splash.item_interp = 0 -- interpolating value for the menu item
	if splash.show_intro then
		splash.dt_temp = 0
	else
		splash.dt_temp = splash.clamp_time
	end
	splash.clamp_time = 1.1
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
end

function splash.keypressed(key)
	-- Change to game state, and init game.
	if splash.dt_temp >= splash.clamp_time then
		if key == 'return' then
			if splash.item == 2 then
				-- show credits screen
				state = 'credits'
				credits.load()
			elseif splash.item == 3 then
				-- quit
				love.event.push('quit')
			end
		end
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
    0,140*scale,love.graphics.getWidth(),"center")
  love.graphics.printf("Scores",
    0,160*scale,love.graphics.getWidth(),"center")
  love.graphics.printf("Credits",
    0,180*scale,love.graphics.getWidth(),"center")
  love.graphics.printf("Quit",
    0,200*scale,love.graphics.getWidth(),"center")
end

-- Draw a red box around the selected item
function splash.draw_selected_box(item)
	love.graphics.setColor(255,255,0,140)
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
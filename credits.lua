credits = {}

function credits.load()
  love.graphics.setBackgroundColor(255,255,255)
end

function credits.draw()
  -- credits.draw_title()
  credits.show_credits()
  credits.show_back_item()
end

function credits.update(dt)
end

function credits.keyreleased(key)
  if key == 'return' then
    state = 'splash'
    splash.show_intro = false
    splash.load()
  end
end

function credits.keypressed(key)
end

-- Draw the title
function credits.draw_title()
  love.graphics.setColor(255,255,255)
  love.graphics.draw(imgs["title"],239,156.4,0,2,2)
end

-- Show credits
function credits.show_credits()
  love.graphics.setColor(0,0,0)
  -- love.graphics.setFont(font_big)
  love.graphics.printf("Credits",
    0,100*scale,love.graphics.getWidth(),"center")
  -- love.graphics.setFont(font)
  love.graphics.printf("Rohan Prinja",
    0,140*scale,love.graphics.getWidth(),"center")

  love.graphics.setColor(255,255,255)
end

-- Show back menu item
function credits.show_back_item()
  local box_width = 150
  local box_height = 40
  
  love.graphics.setColor(255,255,0,140)
  love.graphics.rectangle("fill", 400-(box_width/2),
    390, box_width, box_height)

  love.graphics.setColor(0,0,0)
  love.graphics.printf("Back",
    0,200*scale,love.graphics.getWidth(),"center")
end
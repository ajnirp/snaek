-- Game scale
scale = 2

function love.conf(t)
	t.title = "Snaek"
	t.screen.width = 800
  t.screen.height = 600
	t.screen.vsync = false

  -- t.screen.fullscreen = true

  -- Disable joystick and mouse
  -- for faster game load
  t.modules.joystick = false
  t.modules.mouse = false
  -- Game author
  t.author = "Rohan Prinja"

end
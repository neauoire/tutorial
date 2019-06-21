--  
--   ////\\\\
--   ////\\\\  TUTORIAL
--   ////\\\\  PART 11
--   \\\\////
--   \\\\////  PARAMETERS
--   \\\\////
--

local viewport = { width = 128, height = 64 }
local focus = { x = 0, y = 0 }
local options = {"Cyan", "Magenta", "Yellow", "Black"}
local actions = {"Yes", "No"}

-- Main

function init()
  -- Render Style
  screen.level(15)
  screen.aa(0)
  screen.line_width(1)
  -- Center focus
  focus.x = viewport.width/2
  focus.y = viewport.height/2
  -- Render
  redraw()
  params:add{type = "number", id = "number", name = "Number", min = 1, max = 48, default = 4}
  params:add{type = "option", id = "option", name = "Option", options = options, default = 1}
  params:add{type = "option", id = "action", name = "Action", options = actions, default = 1, action=function(x) print('selection:'..x) end}
end

-- Render

function draw_frame()
  screen.rect(1, 1, viewport.width-1, viewport.height-1)
  screen.stroke()
end

function draw_labels()
  line_height = 8
  -- 
  screen.level(5)
  screen.move(5,viewport.height - (line_height * 1))
  screen.text('number')
  screen.move(5,viewport.height - (line_height * 2))
  screen.text('option')
  screen.move(5,viewport.height - (line_height * 3))
  screen.text('action')
  -- 
  screen.level(15)
  screen.move(40,viewport.height - (line_height * 1))
  screen.text(params:get("number"))
  screen.move(40,viewport.height - (line_height * 2))
  screen.text(options[params:get("option")])
  screen.move(40,viewport.height - (line_height * 3))
  screen.text(actions[params:get("action")])
  screen.fill()
end

function redraw()
  screen.clear()
  draw_frame()
  draw_labels()
  screen.update()
end

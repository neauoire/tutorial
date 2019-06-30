--  
--   ////\\\\
--   ////\\\\  TUTORIAL
--   ////\\\\  PART 11
--   \\\\////
--   \\\\////  PARAMETERS
--   \\\\////
--

local mdh = include('lib/midi_device_helper')

local viewport = { width = 128, height = 64 }
local actions = {"Yes", "No"}

-- Main

function init()
  -- Render Style
  screen.level(15)
  screen.aa(0)
  screen.line_width(1)
  -- Render
  redraw()
  -- Add params with a library
  mdh:init()
  -- Script Params
  params:add{type = "number", id = "number", name = "Number", min = 1, max = 48, default = 4}
  params:add{type = "option", id = "action", name = "Action", options = actions, default = 1, action=function(x) print('selection:'..actions[x]) end}
end

-- Render

function draw_frame()
  screen.rect(1, 1, viewport.width-1, viewport.height-1)
  screen.stroke()
end

function draw_label(id,name,value)
  local y = viewport.height - (8 * id)
  screen.level(5)
  screen.move(5,y)
  screen.text(name)
  screen.level(15)
  screen.move(60,y)
  if value then
    screen.text(value)
  end
  screen.fill()
end

function draw_labels()
  draw_label(1,'action',actions[params:get("action")])
  draw_label(2,'number',params:get("number"))
  -- Library 
  draw_label(5,'midi_output',mdh:get_output_name())
  draw_label(4,'midi_input',mdh:get_input_name())
end

function redraw()
  screen.clear()
  draw_frame()
  draw_labels()
  screen.update()
end

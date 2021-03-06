--  
--   ////\\\\
--   ////\\\\  TUTORIAL
--   ////\\\\  PART 5
--   \\\\////
--   \\\\////  OUTPUT
--   \\\\////
--

engine.name = 'OutputTutorial'

local viewport = { width = 128, height = 64, frame = 0 }
local focus = { x = 0, y = 0 }

-- Main

function init()
  -- Render Style
  screen.level(15)
  screen.aa(0)
  screen.line_width(1)
  -- Center focus
  reset()
  -- Render
  redraw()
end

function reset()
  focus.x = viewport.width/2
  focus.y = viewport.height/2
end

-- Interactions

function key(id,state)
  reset()
  redraw()
end

function enc(id,delta)
  if id == 2 then
    focus.x = clamp(focus.x + delta,6,123)
  elseif id == 3 then
    focus.y = clamp(focus.y + delta,6,59)
    re.time = clamp(focus.y/viewport.height,0.05,4)
  end
  redraw()
end

-- Render

function draw_frame()
  screen.rect(1, 1, viewport.width-1, viewport.height-1)
  screen.stroke()
end

function draw_crosshair()
  screen.move(focus.x,focus.y - 4)
  screen.line(focus.x,focus.y - 2)
  screen.move(focus.x - 4,focus.y)
  screen.line(focus.x - 2,focus.y)
  screen.move(focus.x,focus.y + 3)
  screen.line(focus.x,focus.y + 1)
  screen.move(focus.x + 3,focus.y)
  screen.line(focus.x + 1,focus.y)
  screen.stroke()
  
  for i = viewport.width,1,-1 do 
    if i % 2 == 1 then
      screen.move(i, focus.y)
      screen.line(i + 1, focus.y)
    end
  end
  
  for i = viewport.height,1,-1 do 
    if i % 2 == 1 then
      screen.move(focus.x, i)
      screen.line(focus.x, i + 1)
    end
  end
end

function draw_freq()
  screen.move(5,viewport.height - (8 * 1))
  screen.text(get_freq()..'hz')
  screen.move(5,viewport.height - (8 * 2))
  screen.text(clamp(focus.y/viewport.height,0.05,4)..'ms')
end

function redraw()
  screen.clear()
  draw_frame()
  draw_crosshair()
  draw_freq()
  screen.stroke()
  screen.update()
end

-- Utils

function clamp(val,min,max)
  return val < min and min or val > max and max or val
end

function get_freq()
  return ((focus.x/viewport.width) * 700) + 300
end

-- Interval

re = metro.init()
re.time = 0.5
re.event = function()
  viewport.frame = viewport.frame + 1
  engine.hz(get_freq())
end
re:start()

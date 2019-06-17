--  
--    ////\\\\
--    ////\\\\  TUTORIAL
--    ////\\\\  PART 10
--    \\\\////
--    \\\\////  ENGINE
--    \\\\////
--

local viewport = { width = 128, height = 64, frame = 0 }

-- Main

function init()
  -- Render Style
  screen.level(15)
  screen.aa(0)
  screen.line_width(1)
  -- Render
  update()
end

function update()
  redraw()
end

-- Interactions

function key(id,state)
  update()
end

function enc(id,delta)
  update()
end

-- Render

function draw_frame()
  screen.level(10)
  screen.rect(1, 1, viewport.width-1, viewport.height-1)
  screen.stroke()
end

function redraw()
  screen.clear()
  draw_frame()
  screen.stroke()
  screen.update()
end

-- Utils

function clamp(val,min,max)
  return val < min and min or val > max and max or val
end

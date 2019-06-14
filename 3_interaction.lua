-- scriptname: tutorial part 2
-- v1.0.0 @neauoire
-- llllllll.co/t/norns-tutorial/23241

local viewport = { width = 128, height = 64 }
local focus = { x = 0, y = 0 }

-- Main

function init()
  print('init')
  -- Render Style
  screen.level(10)
  screen.aa(0)
  screen.line_width(1)
  -- Center focus
  reset()
  -- Render
  redraw()
end

function reset()
  print('reset')
  focus.x = viewport.width/2
  focus.y = viewport.height/2
end

-- Interactions

function key(id,state)
  print('key',id,state)
  reset()
  redraw()
end

function enc(id,delta)
  print('enc',id,delta)
  if id == 2 then
    focus.x = clamp(focus.x + delta,6,123)
  elseif id == 3 then
    focus.y = clamp(focus.y + delta,6,59)
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
end

function draw_position()
  line_height = 8
  screen.move(5,viewport.height - (line_height * 1))
  screen.text(math.floor(focus.x)..','..math.floor(focus.y))
end

function redraw()
  print('redraw')
  screen.clear()
  draw_frame()
  draw_crosshair()
  draw_position()
  screen.update()
end

-- Utils

function clamp(val,min,max)
  return val < min and min or val > max and max or val
end

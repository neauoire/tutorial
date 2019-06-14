-- scriptname: tutorial part 2
-- v1.0.0 @neauoire
-- llllllll.co/t/22222

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
  focus.x = viewport.width/2
  focus.y = viewport.height/2
  -- Render
  redraw()
end

-- Interactions

function key(id,state)
  print('key',id,state)
end

function enc(id,delta)
  print('enc',id,delta)
  if id == 1 then
    focus.x = focus.x + delta
  end
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

function redraw()
  print('redraw')
  screen.clear()
  draw_frame()
  draw_crosshair()
  screen.update()
end
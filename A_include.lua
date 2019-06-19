--  
--   ////\\\\
--   ////\\\\  TUTORIAL
--   ////\\\\  PART 10
--   \\\\////
--   \\\\////  INCLUDE
--   \\\\////
--

-- Main

local view1 = include('lib/view1')
local view2 = include('lib/view2')

local viewport = { width = 128, height = 64, frame = 0 }

function init()
  print('init')
  redraw()
end

-- Interactions

function key(id,state)
  print('key',id,state)
end

function enc(id,delta)
  print('enc',id,delta)
  if id == 2 then
    view1.move_by(delta,0)
  elseif id == 3 then
    view1.move_by(0,delta)
  end
  redraw()
end

-- Render

function draw_frame()
  screen.level(15)
  screen.rect(1, 1, viewport.width-1, viewport.height-1)
  screen.stroke()
end

function redraw()
  print('redraw')
  screen.clear()
  draw_frame()
  view1.draw(screen)
  view2.draw(screen)
  screen.update()
end

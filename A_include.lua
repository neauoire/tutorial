--  
--   ////\\\\
--   ////\\\\  TUTORIAL
--   ////\\\\  PART 10
--   \\\\////
--   \\\\////  INCLUDE
--   \\\\////
--

-- Main

local view1 = include('lib/view')
local view2 = include('lib/view')

local viewport = { width = 128, height = 64, frame = 0 }
local selection = nil

function init()
  redraw()
  view1:set_name('view1')
  view2:set_name('view2')
  view1:move_to(9,8)
  view2:move_to(40,21)
  select_view(view1)
end

function select_view(view)
  print('Select: '..view.name)
  if selection then
    selection.is_selected = false
  end
  selection = view
  selection.is_selected = true
  redraw()
end

-- Interactions

function key(id,state)
  if state == 1 then
    if id == 2 then
      select_view(view1)
    elseif id == 3 then
      select_view(view2)
    end
  end
  redraw()
end

function enc(id,delta)
  if id == 2 then
    selection:move_by(delta,0)
  elseif id == 3 then
    selection:move_by(0,delta)
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
  screen.clear()
  draw_frame()
  view1:draw(screen)
  view2:draw(screen)
  screen.update()
end

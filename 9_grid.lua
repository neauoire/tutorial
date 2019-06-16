-- scriptname: tutorial part 9
-- v1.0.0 @neauoire
-- llllllll.co/t/norns-tutorial/23241

local g
local viewport = { width = 128, height = 64, frame = 0 }
local focus = { x = 1, y = 1, brightness = 15 }

-- Main

function init()
  connect()
  -- Render Style
  screen.level(15)
  screen.aa(0)
  screen.line_width(1)
  -- Render
  update()
end

function connect()
  g = grid.connect()
  g.event = on_grid_event
end

function on_grid_event(x,y,z)
  print(x,y,z)
end

function update()
  g:all(0)
  g:led(focus.x,focus.y,focus.brightness)
  g:refresh()
  redraw()
end

-- Interactions

function key(id,state)
  print('key',id,state)
  if id == 2 and state == 1 then
    focus.brightness = 15
  elseif id == 3 and state == 1 then
    focus.brightness = 5
  end
  update()
end

function enc(id,delta)
  print('enc',id,delta)
  if id == 2 then
    focus.x = clamp(focus.x + delta, 1, 16)
  elseif id == 3 then
    focus.y = clamp(focus.y + delta, 1, 8)
  end
  update()
end

-- Render

function draw_frame()
  screen.level(10)
  screen.rect(1, 1, viewport.width-1, viewport.height-1)
  screen.stroke()
end

function draw_grid()
  screen.level(1)
  offset = { x = 30, y = 13, spacing = 4 }
  for x=1,16,1 do 
    for y=1,8,1 do 
      if focus.x == x and focus.y == y then
        screen.stroke()
        screen.level(15)
      end
      screen.pixel((x*offset.spacing) + offset.x, (y*offset.spacing) + offset.y)
      if focus.x == x and focus.y == y then
        screen.stroke()
        screen.level(1)
      end
    end
  end
  screen.stroke()
end

function draw_label()
  screen.level(15)
  line_height = 8
  screen.move(5,viewport.height - (line_height * 1))
  screen.text(focus.x..','..focus.y)
  screen.stroke()
end

function redraw()
  screen.clear()
  draw_frame()
  draw_grid()
  draw_label()
  screen.stroke()
  screen.update()
end

-- Utils

function clamp(val,min,max)
  return val < min and min or val > max and max or val
end

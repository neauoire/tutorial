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
end

function on_osc_event(path, args, from)
  msg = { path = path, ip = from[1], port = from[2], bytes = args }
  redraw(msg)
end

function update()
  g:all(0)
  g:led(focus.x,focus.y,15)
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

function draw_labels()
  line_height = 8
  screen.level(1)
  screen.move(5,viewport.height - (line_height * 1))
  screen.text('path')
  screen.move(5,viewport.height - (line_height * 2))
  screen.text('ip')
  screen.move(5,viewport.height - (line_height * 3))
  screen.text('port')
  screen.move(5,viewport.height - (line_height * 4))
  screen.text('len')
end

function draw_msg(msg)
  line_height = 8
  screen.level(15)
  if msg.path then
    screen.move(30,viewport.height - (line_height * 1))
    screen.text(msg.path)
  end
  if msg.ip then
    screen.move(30,viewport.height - (line_height * 2))
    screen.text(msg.ip)
  end
  if msg.port then
    screen.move(30,viewport.height - (line_height * 3))
    screen.text(msg.port)
  end
  if msg.bytes then
    screen.move(30,viewport.height - (line_height * 4))
    screen.text(#msg.bytes)
  end
end

function redraw(msg)
  screen.clear()
  draw_frame()
  draw_labels()
  if msg then
    draw_msg(msg)
  end
  screen.stroke()
  screen.update()
end

-- Utils

function clamp(val,min,max)
  return val < min and min or val > max and max or val
end

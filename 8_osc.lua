--  
--   ////\\\\
--   ////\\\\  TUTORIAL
--   ////\\\\  PART 8
--   \\\\////
--   \\\\////  OSC
--   \\\\////
--

local viewport = { width = 128, height = 64, frame = 0 }

-- Main

function init()
  connect()
  -- Render Style
  screen.level(15)
  screen.aa(0)
  screen.line_width(1)
  -- Render
  redraw()
end

function connect()
  osc.event = on_osc_event
end

function on_osc_event(path, args, from)
  msg = { path = path, ip = from[1], port = from[2], bytes = args }
  redraw(msg)
end

-- Interactions

function key(id,state)
  if state == 1 and midi_signal then
    midi_signal.note_on(60,127)
  elseif midi_signal then
    midi_signal.note_off(60,127)
  end
  redraw()
end

function enc(id,delta)
  redraw()
end

-- Render

function draw_frame()
  screen.level(15)
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

function note_to_hz(note)
  return (440 / 32) * (2 ^ ((note - 9) / 12))
end

-- scriptname: tutorial part 7
-- v1.0.0 @neauoire
-- llllllll.co/t/norns-tutorial/23241

engine.name = 'OutputTutorial'

local midi_signal
local viewport = { width = 128, height = 64, frame = 0 }

-- Main

function init()
  print('init')
  connect()
  -- Render Style
  screen.level(20)
  screen.aa(0)
  screen.line_width(1)
  -- Center focus
  reset()
  -- Render
  redraw()
end

function connect()
  midi_signal = midi.connect()
  midi_signal.event = on_midi_event
end

function on_midi_event(data)
  msg = midi.to_msg(data)
  play(msg)
  redraw(msg)
end

function play(msg)
  if msg.type == 'note_on' then
    hz = note_to_hz(msg.note)
    engine.amp(msg.vel / 127)
    engine.hz(hz)
  end
  
  if msg.type == "cc" then
    print("cc " .. msg.cc .. " = " .. msg.val)
  end
end

function reset()
  print('reset')
end

-- Interactions

function key(id,state)
  print('key',id,state)
  if state == 1 and midi_signal then
    midi_signal.note_on(60,127)
  elseif midi_signal then
    midi_signal.note_off(60,127)
  end
  redraw()
end

function enc(id,delta)
  print('enc',id,delta)
  redraw()
end

-- Render

function draw_frame()
  screen.rect(1, 1, viewport.width-1, viewport.height-1)
  screen.stroke()
end

function draw_labels()
  line_height = 8
  screen.level(1)
  screen.move(5,viewport.height - (line_height * 1))
  screen.text('note')
  screen.move(5,viewport.height - (line_height * 2))
  screen.text('ch')
  screen.move(5,viewport.height - (line_height * 3))
  screen.text('vel')
  screen.move(5,viewport.height - (line_height * 4))
  screen.text('type')
end

function draw_event(event)
  line_height = 8
  screen.level(20)
  if event.note then
    screen.move(30,viewport.height - (line_height * 1))
    screen.text(msg.note)
  end
  if event.ch then
    screen.move(30,viewport.height - (line_height * 2))
    screen.text(msg.ch)
  end
  if event.vel then
    screen.move(30,viewport.height - (line_height * 3))
    screen.text(msg.vel)
  end
  if event.type then
    screen.move(30,viewport.height - (line_height * 4))
    screen.text(msg.type)
  end
end

function redraw(event)
  print('redraw')
  screen.clear()
  draw_frame()
  draw_labels()
  if event then
    draw_event(event)
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

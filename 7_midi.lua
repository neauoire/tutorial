--  
--   ////\\\\
--   ////\\\\  TUTORIAL
--   ////\\\\  PART 7
--   \\\\////
--   \\\\////  MIDI
--   \\\\////
--

engine.name = 'OutputTutorial'

local midi_signal_in
local midi_signal_out
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
  midi_signal_in = midi.connect(1)
  midi_signal_in.event = on_midi_event
  midi_signal_out = midi.connect(2)
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
end

-- Interactions

function key(id,state)
  if state == 1 and midi_signal_out then
    midi_signal_out:note_on(60,127)
  elseif midi_signal_ then
    midi_signal_out:note_off(60,127)
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
  local line_height = 8
  screen.level(1)
  screen.move(5,viewport.height - (line_height * 1))
  screen.text('note')
  screen.move(5,viewport.height - (line_height * 2))
  screen.text('ch')
  screen.move(5,viewport.height - (line_height * 3))
  screen.text('vel')
  screen.move(5,viewport.height - (line_height * 4))
  screen.text('value')
  screen.move(5,viewport.height - (line_height * 5))
  screen.text('type')
end

function draw_event(event)
  local line_height = 8
  screen.level(15)
  screen.move(30,viewport.height - (line_height * 1))
  if event.note then
    screen.text(msg.note)
  else
    screen.text('-')
  end
  if event.ch then
    screen.move(30,viewport.height - (line_height * 2))
    screen.text(msg.ch)
  end
  screen.move(30,viewport.height - (line_height * 3))
  if event.vel then
    screen.text(msg.vel)
  else
    screen.text('-')
  end
  screen.move(30,viewport.height - (line_height * 4))
  if event.val then
    screen.text(msg.val)
  else
    screen.text('-')
  end
  if event.type then
    screen.move(30,viewport.height - (line_height * 5))
    screen.text(msg.type)
  end
end

function redraw(event)
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

--  
--   ////\\\\
--   ////\\\\  TUTORIAL
--   ////\\\\  PART 10
--   \\\\////
--   \\\\////  ENGINE
--   \\\\////
--

engine.name = 'OutputTutorial'

local candidates = {}
local viewport = { width = 128, height = 64, frame = 0 }
local load_lock = false

-- Main

function init()
  -- Render Style
  screen.level(15)
  screen.aa(0)
  screen.line_width(1)
  -- Render
  redraw()
end

function is_compatible()
  return engine['noteOn'] ~= nil
end

function get_engine_id()
  for id = 1, #engine.names do
    name = engine.names[id]
    if name == engine.name then
      return id
    end
  end
  return -1
end

function select_next_engine()
  target_id = (get_engine_id() + 1)
  if target_id > #engine.names then return end
  next_name = engine.names[target_id]
  select_engine(next_name)
end

function select_prev_engine()
  target_id = (get_engine_id() - 1)
  if target_id < 1 then return end
  prev_name = engine.names[target_id]
  select_engine(prev_name)
end

function select_engine(name)
  print('Loading '..name)
  load_lock = true
  engine.name = name
  engine.load(engine.name, on_engine_load)
  redraw()
end

function on_engine_load()
  print('Loaded '..engine.name)
  load_lock = false
  engine.list_commands()
  redraw()
end

-- Interactions

function key(id,state)
  if load_lock == true then print('Please wait') ; return end
  if id == 3 and state == 1 then
    select_next_engine()
  end
  if id == 2 and state == 1 then
    select_prev_engine()
  end
end

function enc(id,delta)
  if load_lock == true then print('Please wait') ; return end
  redraw()
end

-- Render

function draw_frame()
  screen.level(10)
  screen.rect(1, 1, viewport.width-1, viewport.height-1)
  screen.stroke()
end

function draw_labels()
  line_height = 8
  if load_lock == true then
    screen.level(15)
    screen.move(30,viewport.height - (line_height * 1))
    screen.text('Loading..')
    return
  end
  line_height = 8
  screen.level(5)
  screen.move(5,viewport.height - (line_height * 1))
  screen.text('>')
  screen.move(5,viewport.height - (line_height * 2))
  screen.text('name')
  screen.move(5,viewport.height - (line_height * 3))
  screen.text('id')
  
  screen.level(15)
  screen.move(30,viewport.height - (line_height * 1))
  if is_compatible() == true then
    screen.text('compatible')
  else
    screen.text('incompatible')
  end
  screen.move(30,viewport.height - (line_height * 2))
  screen.text(engine.name)
  screen.move(30,viewport.height - (line_height * 3))
  screen.text(get_engine_id()..'/'..#engine.names)
end

function modal_wait()
  screen.rect(10,10,40,40)
  screen.stroke()
  screen.update()
end

function redraw()
  screen.clear()
  draw_frame()
  draw_labels()
  screen.stroke()
  screen.update()
end

-- Utils

function clamp(val,min,max)
  return val < min and min or val > max and max or val
end

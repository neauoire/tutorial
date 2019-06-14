-- scriptname: tutorial part 6
-- v1.0.0 @neauoire
-- llllllll.co/t/norns-tutorial/23241

engine.name = 'InputTutorial'

local poll = require 'core/poll'
local mix = require 'core/mix'

local viewport = { width = 128, height = 64 }
local signal = { in1 = 0, in2 = 0, out1 = 0, out2 = 0, _in1 = 0, _in2 = 0, _out1 = 0, _out2 = 0, _in1_max = 1, _out1_max = 1}
local controls = { amp = 1.0 }

function init()
  print('init')
  -- Render Style
  screen.level(10)
  screen.aa(0)
  screen.line_width(1)
  -- Render
  redraw()
  -- Listen
  audio.monitor_mono()
  _norns.poll_start_vu()
  norns.vu = mix.vu
  engine.amp(1.0)
end

function update()
  engine.amp(controls.amp)
  redraw()
end

mix.vu = function(in1,in2,out1,out2)
  signal.in1 = in1
  signal.in2 = in2
  signal.out1 = out1 
  signal.out2 = out2
  -- Dampen
  if signal.in1 > signal._in1 then
    signal._in1 = signal.in1
  else
    signal._in1 = signal._in1 - 0.05
  end
  if signal.out1 > signal._out1 then
    signal._out1 = signal.out1
  else
    signal._out1 = signal._out1 - 0.05
  end
  if signal.in1 > signal._in1_max then
    signal._in1_max = signal.in1
  end
end

-- Controls

function key(n,z)
  if z == 0 then return end
  if n == 2 or n == 3 then
    if controls.amp == 1 then
      controls.amp = 0
    else
      controls.amp = 1
    end
  end
  update()
end

function enc(id,delta)
  print('enc',id,delta)
  controls.amp = clamp(controls.amp + (delta/10), 0.1, 1)
  update()
end

-- Render

function draw_frame()
  screen.rect(1, 1, viewport.width-1, viewport.height-1)
  screen.stroke()
end

function draw_uv(value,maximum,offset)
  size = {width = 4, height = viewport.height - 4}
  pos = {x = viewport.width - size.width - offset, y = 2}
  ratio = value/maximum
  activity = clamp(size.height - (ratio * size.height),3,size.height)
  screen.line_width(size.width)
  -- Draw
  screen.level(1)
  screen.move(pos.x,pos.y)
  screen.line(pos.x,pos.y + size.height)
  screen.stroke()
  screen.level(20)
  screen.move(pos.x,pos.y + size.height)
  screen.line(pos.x,activity)
  screen.stroke()
  screen.line_width(1)
end

function draw_controls()
  x = viewport.width - 16
  y = math.floor(viewport.height-(controls.amp * (viewport.height-5)) - 2)
  -- Draw
  screen.level(20)
  screen.line_width(1)
  screen.move(x,y)
  screen.line(x + 4,y)
  screen.stroke()
end

function draw_label()
  line_height = 8
  screen.move(5,viewport.height - (line_height * 1))
  screen.text(controls.amp..'amp')
end

function redraw()
  screen.clear()
  draw_frame()
  draw_controls()
  draw_label()
  draw_uv(signal._in1,signal._in1_max,0)
  draw_uv(signal._out1,signal._in1_max,5)
  screen.stroke()
  screen.update()
end

-- Utils

function clamp(val,min,max)
  return val < min and min or val > max and max or val
end

-- Interval

re = metro.init()
re.time = 30/1000
re.event = function()
  redraw()
end
re:start()

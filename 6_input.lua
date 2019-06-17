-- scriptname: tutorial part 6
-- v1.0.0 @neauoire
-- llllllll.co/t/norns-tutorial/23241

engine.name = 'InputTutorial'

local viewport = { width = 128, height = 64 }
local signal = { amp_in_l = 0, amp_out_l = 0, amp_in_l_max = 0, amp_out_l_max = 0 }
local controls = { amp = 1.0 }
local refresh_rate = 1.0 / 15
local p_amp_in
local p_amp_out

function init()
  -- Render Style
  screen.level(15)
  screen.aa(0)
  screen.line_width(1)
  -- Render
  redraw()
  -- Listen
  audio.monitor_mono()
  engine.amp(1.0)
  -- Poll in
  p_amp_in = poll.set("amp_in_l")
  p_amp_in.time = refresh_rate
  p_amp_in.callback = function(val) 
    signal.amp_in_l = val
    if signal.amp_in_l > signal.amp_in_l_max then 
      signal.amp_in_l_max = signal.amp_in_l
    end
  end
  -- Poll out
  p_amp_out = poll.set("amp_out_l")
  p_amp_out.time = refresh_rate
  p_amp_out.callback = function(val) 
    signal.amp_out_l = val
    if signal.amp_out_l > signal.amp_out_l_max then 
      signal.amp_out_l_max = signal.amp_out_l
    end
  end
end

function update()
  engine.amp(controls.amp)
  redraw()
end

function repoll()
  p_amp_in:update()
  p_amp_out:update()
end

-- Controls

function key(id,state)
  print('key',id,state)
  if state == 0 then return end
  if id == 2 or id == 3 then
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
  screen.level(15)
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
  screen.level(15)
  screen.move(pos.x,pos.y + size.height)
  screen.line(pos.x,activity)
  screen.stroke()
  screen.line_width(1)
end

function draw_controls()
  x = viewport.width - 16
  y = math.floor(viewport.height-(controls.amp * (viewport.height-5)) - 2)
  -- Draw
  screen.level(15)
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
  draw_uv(signal.amp_in_l,signal.amp_in_l_max,0)
  draw_uv(signal.amp_out_l,signal.amp_out_l_max,5)
  screen.stroke()
  screen.update()
end

-- Utils

function clamp(val,min,max)
  return val < min and min or val > max and max or val
end

-- Interval

re = metro.init()
re.time = refresh_rate
re.event = function()
  repoll()
  redraw()
end
re:start()

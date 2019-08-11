--  
--   ////\\\\
--   ////\\\\  TUTORIAL
--   ////\\\\  PART 12
--   \\\\////
--   \\\\////  SOFTCUT
--   \\\\////
--

local m = metro.init()
local positions = {0,0,0,0}
local viewport = { width = 128, height = 64, center = 64, middle = 32 }

local rate = 1.0
local fader = 0.5
local offset = 0
local length = 1

function init()
  -- Render Style
  screen.level(15)
  screen.aa(0)
  screen.line_width(1)
  -- Setup
  m.time = 1.0
  audio.level_adc_cut(1) -- send audio input to softcut input
  setup_softcut()
  m:start()
end

function update_positions(i,pos)
  positions[i] = pos
  redraw()
end

function setup_softcut()
  softcut.buffer_clear()
  -- Voice 1
  softcut.enable(1,1)
  softcut.buffer(1,1)
  softcut.level(1,1.0)
  softcut.loop(1,1) -- voice, 1 = loop
  softcut.loop_start(1,0)
  softcut.loop_end(1,length)
  softcut.position(1,1)
  softcut.play(1,1)
  softcut.fade_time(1,0.25)
  softcut.phase_quant(1,1.0 / 30)
  softcut.level_input_cut(1,1,1.0) -- set input rec level: input channel, voice, level
  softcut.rec_level(1,0.5) -- set voice 1 record level 
  softcut.pre_level(1,0.5) -- set voice 1 pre level
  softcut.rec(1,1)
  -- Voice 2
  softcut.fade_time(2,0.50)
  softcut.phase_quant(2,1.0 / 30)
  softcut.level_input_cut(2,1,1.0)
  -- Polls
  softcut.event_phase(update_positions)
  softcut.poll_start_phase()
end

function key(n,z)
  if z == 1 then
    if n == 3 then
      rate = clamp(rate+0.2,-4,4)
    elseif n == 2 then
      rate = clamp(rate-0.2,-4,4)
    end
  end
  refresh()
  redraw()
end

function enc(n,d)
  -- fader
  if n==1 then
    fader = clamp(fader+d/100,0,1)
  end
  -- offset
  if n==2 then
    offset = clamp(offset+d/100,0,5-length)
  end
  -- length
  if n==3 then
    length = clamp(length+d/100,0.25,4)
  end
  refresh()
  redraw()
end

function refresh()
  softcut.rate(1,rate)
  softcut.loop_start(1,offset)
  softcut.loop_end(1,offset+length)
  softcut.pre_level(1,fader)
  softcut.rec_level(1,1-fader)
end

function draw_frame()
  screen.rect(1, 1, viewport.width-1, viewport.height-1)
  screen.stroke()
end

function redraw()
  screen.clear()
  draw_frame()
  local pad = 10
  local width = viewport.width - (2*pad)
  local limit = 5
  local seek_from = (offset/limit) * width
  local seek_to = ((offset+length)/limit) * width
  local seek_at = clamp((positions[1]/limit) * width,seek_from,seek_to)
  -- Fader
  screen.move(pad,viewport.middle-pad)
  screen.text(string.format("%.2f",fader))
  -- Rate
  screen.move(viewport.width-pad,viewport.middle-pad)
  screen.text_right(string.format("%.2f",rate))
  -- Offset
  screen.move(pad,viewport.middle+pad+5)
  screen.text(string.format("%.2f",offset))
  -- Length
  screen.move(viewport.width-pad,viewport.middle+pad+5)
  screen.text_right(string.format("%.2f",offset+length))
  -- Position
  screen.move(viewport.center,viewport.middle+pad+5)
  screen.text_center(string.format("%.2f",positions[1]))
  screen.level(2)
  -- Background
  screen.move(pad,viewport.middle)
  screen.line(pad + width,viewport.middle)
  screen.stroke()
  screen.level(15)
  screen.move(seek_from+pad,viewport.middle)
  screen.line(seek_to+pad,viewport.middle)
  screen.move(seek_at+pad,viewport.middle-3)
  screen.line(seek_at+pad,viewport.middle+2)
  screen.stroke()
  screen.update()
end

function clamp(val,min,max)
  return val < min and min or val > max and max or val
end

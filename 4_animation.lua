-- scriptname: tutorial part 2
-- v1.0.0 @neauoire
-- llllllll.co/t/norns-tutorial/23241

local viewport = { width = 128, height = 64, frame = 0 }
local amplitude = 10
local rate = 10

-- Main

function init()
  -- Render Style
  screen.level(15)
  screen.aa(0)
  screen.line_width(1)
  -- Center focus
  reset()
  -- Render
  redraw()
end

function reset()
  print('reset')
  amplitude = 10
end

-- Interactions

function key(id,state)
  print('key',id,state)
  reset()
  redraw()
end

function enc(id,delta)
  print('enc',id,delta)
  if id == 2 then
    amplitude = clamp(amplitude + (delta/2),0,20)
  else
    rate = clamp(rate + (delta/10),2,20)
  end
  redraw()
end

-- Render

function draw_frame()
  screen.rect(1, 1, viewport.width-1, viewport.height-1)
  screen.stroke()
end

function draw_wave()
  for i = 1,126 do
    x = i
    y = (math.sin((viewport.frame+i)/rate) * amplitude) + (viewport.height/2)
    screen.pixel(x,y)
  end
  screen.fill()
end

function draw_label()
  line_height = 8
  screen.move(5,viewport.height - (line_height * 1))
  screen.text(amplitude..':'..rate)
  screen.stroke()
end

function redraw()
  screen.clear()
  draw_frame()
  draw_wave()
  draw_label()
  screen.update()
end

-- Utils

function clamp(val,min,max)
  return val < min and min or val > max and max or val
end

-- Interval

re = metro.init()
re.time = 1.0 / 15
re.event = function()
  viewport.frame = viewport.frame + 1
  redraw()
end
re:start()

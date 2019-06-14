-- scriptname: tutorial part 7
-- v1.0.0 @neauoire
-- llllllll.co/t/norns-tutorial/23241

engine.name = 'OutputTutorial'

local viewport = { width = 128, height = 64, frame = 0 }

-- Main

function init()
  print('init')
  -- Render Style
  screen.level(10)
  screen.aa(0)
  screen.line_width(1)
  -- Center focus
  reset()
  -- Render
  redraw()
end

function reset()
  print('reset')
end

-- Interactions

function key(id,state)
  print('key',id,state)
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

function draw_freq()
  -- screen.move(5,viewport.height - 4)
  -- screen.text(get_freq()..'hz')
  -- screen.move(5,viewport.height - 10)
  -- screen.text(clamp(focus.y/viewport.height,0.05,4)..'ms')
end

function redraw()
  print('redraw')
  screen.clear()
  draw_frame()
  draw_freq()
  screen.stroke()
  screen.update()
end

-- Utils

function clamp(val,min,max)
  return val < min and min or val > max and max or val
end

--  
--    ////\\\\
--    ////\\\\  TUTORIAL
--    ////\\\\  PART 1
--    \\\\////
--    \\\\////  BLANK
--    \\\\////
--

-- Main

function init()
  print('init')
  redraw()
end

-- Interactions

function key(id,state)
  print('key',id,state)
end

function enc(id,delta)
  print('enc',id,delta)
end

-- Render

function redraw()
  print('redraw')
  screen.clear()
  screen.update()
end
-- scriptname: tutorial part 1
-- v1.0.0 @neauoire
-- llllllll.co/t/22222

function init()
  print('init')
  redraw()
end

function key(id,state)
  print('key',id,state)
end

function enc(id,delta)
  print('enc',id,delta)
end

function redraw()
  print('redraw')
  screen.clear()
  screen.update()
end
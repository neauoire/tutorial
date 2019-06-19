
local position = { x = 9, y = 8 }
local size = { width = 46, height = 36 }

return {
  move_by = function(x,y)
    position.x = position.x + x
    position.y = position.y + y
  end,
  draw = function(screen)
    screen.level(5)
    screen.rect(position.x,position.y,size.width,size.height)
    screen.move(position.x + 4,position.y + size.height - 4)
    screen.text('view1')
    screen.stroke()
  end
}
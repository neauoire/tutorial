local view = { 
  name = 'no_name', 
  position = { x = 9, y = 8 }, 
  size = { width = 46, height = 36 }, 
  is_selected = false 
}

view.set_name = function(self,name)
  self.name = name
end

view.move_to = function(self,x,y)
  self.position.x = x
  self.position.y = y
end

view.move_by = function(self,x,y)
  self.position.x = self.position.x + x
  self.position.y = self.position.y + y
end

view.draw = function(self,screen)
  if self.is_selected == true then
    screen.level(15)
  else
    screen.level(5)
  end
  screen.rect(self.position.x,self.position.y,self.size.width,self.size.height)
  screen.move(self.position.x + 4,self.position.y + self.size.height - 4)
  screen.text(self.name)
  screen.stroke()
end

return view
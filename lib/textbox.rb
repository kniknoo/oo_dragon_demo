class TextBox < Array
  def initialize(x, y, message = "Hello, World!", fore = [255, 255, 255], back = [0,0,0], font_size = 12)
    #@x, @y = x, y
    #@message = message
    #@back, @fore = back, fore
    #@font_size = font_size
    #[[x, y - (4 * font_size), font_size * 10 + 30, font_size * 4, *back].solid, [x, y, message, font_size, 0, 255, *fore].label]
  end
  
  #def attr
  #[@x, @y - (4 * @font_size), @font_size * 10 + 30, @font_size * 4, *@back].solid, [@x, @y, @message, @font_size, 0, 255, *@fore].label
  #end 
end

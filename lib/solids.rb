class Solid

  gtk_args

  def initialize(x, y, width, height, color = [0,0,0], alpha = 255)
    @x, @y = x, y
    @height, @width = height, width
    @color, @alpha = color, alpha
  end
  
  def show
    [@x, @y, @height, @width, *@color, *@alpha]
  end
end

class Background < Solid

  def initialize(color = [0,0,0], alpha = 255)
    super(0,0,720, 1280)
    @color, @alpha = color, alpha
  end
  
end

class Star
  
  def self.maker(quantity)
    quantity.map{[rand(1280), rand(360) + 360, rand(3) + 2, rand(3) + 2, rand(20)+ 235, 200, rand(20) + 235, 255]}
  end
  
end

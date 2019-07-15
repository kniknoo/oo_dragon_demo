$gtk.require "lib/sprite.rb"

class Dragon < Sprite

  gtk_args
  
  include Animation
  include Sensation
  
  def initialize(x, y)
    super(x, y, 128, 101, "sprites/dragon_fly_" )
    @color = random_color(55, 200)
    load_frames
  end
  
  def flap() animate end
  def roar() "sounds/roaring.wav" end
  def say(message, primitives)
    primitives << [[x - 20, y2, 250, 48, 0, 0, 0].solid, 
    [x, y2 + 40, message, 8, 0, 255, 255, 255, 255].label]
  #[[x, y - (4 * font_size), font_size * 10 + 30, font_size * 4, *back].solid, [x, y, message, font_size, 0, 255, *fore].label]

  end
end

class Player < Dragon

    include Movement
    
end

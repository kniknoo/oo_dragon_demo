$gtk.require "lib/sprite.rb"

class Wizard < Sprite
  
  include Movement
  include Animation
  
  def initialize(x, y)
    super(x, y, 413, 348, "sprites/wizard/run_" )
    @start, @frames = 0, 4
    load_frames
  end
end

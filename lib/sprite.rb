class Sprite
  
  gtk_args
  attr_accessor :x, :y, :color, :viewport, :origin, :height, :width, :scale, :start
  
  def initialize(x, y, width, height, filename, scale = 1, ext = ".png" )
    @scale = scale
    @x, @y, @width, @height = x, y, width * @scale, height * @scale
    @filename, @ext = filename, ext
    @file = "#{@filename}#{@ext}"
    @rot, @vflip = 0, false
    @color, @alpha = [255, 255, 255], 255
    @origin, @viewport = [0, 0], [@width / @scale, @height / @scale]
    @already_touching = false
  end
  
  def attr() [@x, @y, @width, @height, @file, @rot, @alpha, *@color, *@origin, *@viewport, @vflip] end
  
  def x2() @x + @width end
  def y2() @y + @height end
  
end

module Animation

  def load_frames(start, sprites, per, loop)
    @start = start
    @sprites, @per, @loop = sprites, per, loop
  end
  
  def animate()
    index = 0.frame_index @sprites, @per, @loop
    @file = "#{@filename}#{index + @start}#{@ext}" 
    #Testing frame_index : comment above 2 lines and uncomment below
    #@file = "#{@filename}#{@start.frame_index @sprites, @per, @loop}#{@ext}"
  end
  
  def random_color(start, size) @color = 3.times.map {rand(size) + start} end
  
end

module Movement

  def left
    @vflip = true
    @x -= 10 unless @x <= 0
  end
  
  def right
    @vflip = false
    @x += 10 unless x2 >= 1280
  end
  
  def up() @y += 10 unless y2 >= 720 end
  
  def down() @y -= 10 unless @y <= 0 end
  
end

module Sensation

  def touching?(its) x2 >= its.x and x <= its.x2 and y2 >= its.y and y <= its.y2 end
  
  def touches?(it)
    if touching?(it) and not @already_touching 
      @already_touching = true
      return true
    elsif not touching?(it) and @already_touching
      @already_touching = false
    end 
    return false
  end
  
end

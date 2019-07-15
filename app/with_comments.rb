# This is a module definition. It isn't necessary, that is, you can 
# define Classes without one. It's just here for demonstration and
# because it's good form to declare a name space so that classes don't 
# get mixed up due to having the same name.
module Sprite
  # This is Class definition
  class Static
    # Define a Static Sprite
    def initialize(x, y, width, height, filename,  ext = ".png" )
      # Set up attributes, called by .new()
      @x, @y, @width, @height = x, y, width, height
      # Any number per line, just line them up in order
      @filename, @ext = filename, ext
      # String interpolation
      @file = "#{@filename}#{@ext}"
      @rot, @vflip = 0, false
      # You can bundle setting into array groups
      @color, @alpha = [255, 255, 255], 255
      @stretch, @center = [0, 0], [@width, @height]
    end
    
    def attr
      # Set up the attribute array and return it
      # The attributes with a * (aka splat) are the Arrays above that need "unpacked"
      [@x, @y, @width, @height, @file, @rot, @alpha, *@color, *@stretch, *@center, @vflip]
    end
  end

  class Animated < Static
    # Extend the Static class to allow for reusable animation extensions
    def initialize(x, y, height, width, filename)
      # super calls Static.new() and needs its parameters
      super(x, y, height, width, filename)
      # Set up attributes for animation
      @start = 0
      @sprites, @per, @loop = 6, 4, true
    end
    
    def self.animate
      # Run the animation loop. 
      # Int#frame_index is a built-in helper to cycle, 
      # it will return an Int between @start and @sprites, exclusively
      # Parameters are (number_of_files : Int, frames_between_update :Int, loop? : Bool) 
      @file = "#{@filename}#{@start.frame_index @sprites, @per, @loop}#{@ext}"
    end
  end

  class Dragon < Animated
    # Extend the animated class to specify the dragon
    def initialize(x, y)
      # call Animated.new(), thus Static.new(). Specify the dragon image prefix
      super(x, y, 128, 101, "sprites/dragon_fly_" )
    end
    
    def left
      # Turn on vflip and move the dragon 10px left until it hits the edge
      @vflip = true
      @x -= 10 unless @x <= 0
    end
    
    def right
      # Turn off vflip and move the dragon 10px right until it hits the edge
      @vflip = false
      @x += 10 unless @x + @width >= 1280
    end
    
    # Move the dragon 10px up or down until it hits the edge
    def up() @y += 10 unless @y + @height >= 720 end
    
    def down() @y -= 10 unless @y <= 0 end
    
    # Calling animate because flap() looks nicer. One-liner Methods require the ()
    def flap() self.animate end
    
  end
end

# Now for the main mathods

def check_keys a
  # Check the key state and respond
  key = a.keyboard
  $puff.left if key.left
  $puff.right if key.right
  $puff.up if key.up
  $puff.down if key.down
end

def action
  #Run any updates on Objects, it's just a lonely flap for now
  $puff.flap
  $hr_puffnstuff.flap
end

def update a
  # Update the args
  a.solids << [a.grid.rect, 38, 38, 38]
  a.sprites << $castle.attr
  a.sprites << $puff.attr 
  a.sprites << $hr_puffnstuff.attr
end

# Objects in DragonRuby require a $ prefix
# If no module were defined above, the Sprite:: prefix would be unnecessary ie Dragon.new()

# The Castle background will be a Static class from the Sprite Module
$castle = Sprite::Static.new(0, 0, 1280, 720, "sprites/castle")

# We have a dragon named Puff. They're from the Dragon class in the Sprite module

$hr_puffnstuff = Sprite::Dragon.new(576, 310)
$puff = Sprite::Dragon.new(576, 310)

# Now that we have all that set up, it's time to load up tick.
def tick a
  #Check the keys
  check_keys a
  #Action
  action
  # Run the updates
  update a
end

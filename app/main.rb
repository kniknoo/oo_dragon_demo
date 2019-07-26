$gtk.require "lib/sprite.rb"
$gtk.require "lib/dragon.rb"
$gtk.require "lib/solids.rb"
$gtk.require "lib/wizard.rb"


class Wizard < Sprite
  
  include Movement
  include Animation
  
  def initialize(x, y)
    super(x, y, 413, 348, "sprites/wizard/run_", 0.25 )
    load_frames(1, 4, 8, true)
  end
end



$music_playing = false
 
def check_keys key

  $puff.left if key.left
  $puff.right if key.right
  $puff.up if key.up
  $puff.down if key.down
  $merlin.up if key.key_held.w
  $merlin.down if key.key_held.s
  
end

def music sounds

  if not $music_playing
    sounds << "sounds/DragonDemoBG(The_Journey).ogg"
    $music_playing = true
  end
  
end

$background = Background.new([38,38,38])
$ground = Solid.new(0,0,360, 1280, [25, 50, 25])
$stars = Star.maker(50)
$castle = Sprite.new(320, 300, 1280, 720, "sprites/castle", 0.5)

$smaug = Dragon.new(200, 100)
$puff = Player.new(576, 310)
$merlin = Wizard.new(100, 360)
def tick as  
  #music as.outputs.sounds
  check_keys as.keyboard
  $stars.map{|star| star[7] = rand(100) + 150 if rand > 0.9}
  $puff.flap
  $smaug.flap
  $merlin.animate
  as.solids << [$background.show, $ground.show]
 
  as.solids << $stars
  as.sprites << [$castle.attr, $smaug.attr, $puff.attr, $merlin.attr]

  $smaug.say("Hello, Puff!", as.outputs.primitives) if $puff.touching?($smaug)
  
  #if $puff.touches?($smaug)
  #  $puff.random_color(55, 200)
  #  as.outputs.sounds << $puff.roar 
  #end

end

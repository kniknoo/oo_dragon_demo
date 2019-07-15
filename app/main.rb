$gtk.require "lib/sprite.rb"
$gtk.require "lib/dragon.rb"

$music_playing = false

def check_keys key

  $puff.left if key.left
  $puff.right if key.right
  $puff.up if key.up
  $puff.down if key.down
  
end

def music sounds

  if not $music_playing
    sounds << "sounds/DragonDemoBG(The_Journey).ogg"
    $music_playing = true
  end
  
end

$castle = Sprite.new(0, 0, 1280, 720, "sprites/castle")
$smaug = Dragon.new(200, 100)
$puff = Player.new(576, 310)

def tick as

  music as.outputs.sounds
  check_keys as.keyboard
  
  $puff.flap
  $smaug.flap
  
  as.solids << [as.grid.rect, 38, 38, 38]
  as.sprites << [$castle.attr, $smaug.attr, $puff.attr]
  
  $smaug.say("Hello, Puff!", as.outputs.primitives) if $puff.touching?($smaug)
  
  if $puff.touches?($smaug)
    $puff.random_color(55, 200)
    as.outputs.sounds << $puff.roar 
  end
  
end

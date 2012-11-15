require 'player2'

class Player
  attr_accessor :player, :image, :score, :pontos, :morto, :x, :y, :estagio
  def initialize(window)
  #  @image = Gosu::Image::load_tiles(window, "img/pidgeottobw.png", 2.3, 3.0, 3)
    @janela =  window
    @image = Gosu::Image.new(window, "img/players/player.png", false)
    @morto= Gosu::Image.new(window, "img/hitted.png", true)
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score = 3
    @pontos = 0
    @acertado = false
    @estagio = 1
  end

  def warp(x, y)
    @x, @y = x, y
  end

  def turn_left
    @x -= 4.5
    if @x < 0
      @x=0
    end
  end

  def turn_right
    @x += 4.5
    if @x > 640
      @x = 600
    end
  end

  def up
    @vel_x += Gosu::offset_x(@angle, 0.5)
    @vel_y += Gosu::offset_y(@angle, 0.5)
  end

  def down
    @vel_x -= Gosu::offset_x(@angle, 0.5)
    @vel_y -= Gosu::offset_y(@angle, 0.5)
  end

  def move
    @x += @vel_x
    @y += @vel_y
    @vel_x *= 0.95
    @vel_y *= 0.95
    if @y<0
      @y = 0
    elsif @y>480
      @y=480
    end
  end

  def draw

    if @acertado
    @morto.draw(@x, @y, 4)
    else
    @image.draw_rot(@x,@y,1, @angle)
    end
  end

  def hit_by?(bichos)
    @acertado =  bichos.any? {|bicho| Gosu::distance(bicho.x, bicho.y, @x, @y) < 60}

    if @acertado
      @score = @score - 1
    else
    @acertado
    end
  end

  def reset_position
    @x = rand(@janela.width)
  end

end


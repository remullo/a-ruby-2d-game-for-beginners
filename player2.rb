class Player2
  attr_accessor :player2, :imagep2, :score2
  def initialize(window)
    @imagep2 = Gosu::Image.new(window, "img/players/player2.png", true)
    @x = @y = @vel_x = @vel_y = @angle = 0.0
    @score2 = 3
  #  @score = 0
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

  def subir
    @vel_x += Gosu::offset_x(@angle, 0.08)
    @vel_y += Gosu::offset_y(@angle, 0.08)
  end

  def descer
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
      @y=400
    end
  end

  def hit_by?(bichos)
    @acertado =  bichos.any? {|bicho| Gosu::distance(bicho.x, bicho.y, @x, @y) < 30}

    if @acertado
      @score2 = @score2 - 1
    end
    @acertado
  end

  def reset_position2
    @x = rand(@janela.width)
  end

  def draw

    @imagep2.draw_rot(@x, @y, 1, @angle)

  #  @image2.draw_rot(-@x, @y, 0, @angle)
  end
end

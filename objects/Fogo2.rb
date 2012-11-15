class Fogo2
  attr_accessor :fogo2, :fogoimg2
  def initialize(window)
    @fogoimg2= Gosu::Image.new(window, "img/ambient/fire2.png", true)
    @x = @y = 0.0
  #  @score = 0
  end

  def surgir(x, y)
    # while (@fogo?=true) do
    @x, @y = x, y
  # @x = x+y
  # end

  end

  # def inside_window?(x = @x, y = @y)
  #  x >= 0 && x <= $window.width && y >= 0 && y <= $window.height
  #end

  def mudar
    @x += @vel_x
    @y += @vel_y
    @x %= 640
    @y %= 480
    @vel_x *= 0.95
    @vel_y *= 0.95
  end

  def draw

    @fogoimg2.draw_rot(@x, @y, 1, @angle)
  #  @image2.draw_rot(-@x, @y, 0, @angle)
  end
end
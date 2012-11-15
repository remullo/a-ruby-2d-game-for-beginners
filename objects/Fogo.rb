class Fogo
  attr_accessor :fogoimg, :changes
  def initialize(window) 
    @fogoimg = Gosu::Image.new(window, "img/ambient/fire.png", true)
  #  @fogoimg2 = Gosu::Image.new(window, "img/ambient/fire.png", true)
   
  end

  def surgir(x, y)
    @x, @y= x, y
  end
  
  
  
  def draw
    @fogoimg.draw_rot(@x, @y, 1, 0)
   
  end
end
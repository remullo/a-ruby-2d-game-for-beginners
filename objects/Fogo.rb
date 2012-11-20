class Fogo
  attr_accessor :fogoimg, :changes, :imgfire, :tela
  def initialize(window) 
    @tela = window
    @fogoimg = Gosu::Image.new(@tela, "img/ambient/firetile.png", true)
    @imgfire = Gosu::Image::load_tiles(@tela, @fogoimg, 30, 40, true)
    
 ##   @fogoimg = Gosu::Image.new(window, "img/ambient/fire.png", true)
  #  @fogoimg2 = Gosu::Image.new(window, "img/ambient/fire.png", true)
   $item = 0
   $indice = 0
  end

  def surgir(x, y)
    @x, @y= x, y
  end
  
  
  
  def draw
    
    if $item <200 then
      $item+=1
      end
      if $item == 200 then
      $indice+=1
      $i = 0
      end
      if $indice >= @imgfire.size then
      $ind = 0
      end
    @imgfire[$indice].draw(@x, @y, 0)
   # @fogoimg.draw_rot(@x, @y, 1, 0)
   
  end
end
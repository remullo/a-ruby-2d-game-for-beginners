class Botaofechar
  attr_reader :tela, :botaosair, :x, :y
  def initialize(window)
    @tela = window
    @botaosair = Gosu::Image.new(@tela, "img/menu/botaosair.png", true)
    @x = 180
    @y = 350
  end
  
  def update
    
  end
  
  def draw
     @botaosair.draw(@x, @y,8)
  end
  
end
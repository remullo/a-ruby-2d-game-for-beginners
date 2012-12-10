class Ponteiro
  attr_reader :x, :y, :tela, :ponteiro
  def initialize(window)
    
    @tela = window
    @x = @y = 0.0
    @ponteiro = Gosu::Image.new(@tela, "img/cursor.png", true)
    
  end
  
  def update
    
 @x = @tela.mouse_x
 @y = @tela.mouse_y
 
  end
    
    
    def draw
      @ponteiro.draw(@x,@y, 9)
    end
end
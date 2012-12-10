class Botaoiniciar
  attr_reader :botaoimg, :tela, :x, :y
  def initialize(window)

    @tela = window
    @botaoimg = Gosu::Image.new(@tela,"img/menu/botaoiniciar.png", true)
    @x = 180
    @y = 200

 

  end

  def update
    if (Gosu::distance(@tela.ponteiro.x, @tela.ponteiro.y, @x, @y) <= 20) and Gosu::Button::MsLeft
     
      @tela.menu == false

    end
    
  
  
  end

  def draw
    @botaoimg.draw(@x, @y,8)
  end

end
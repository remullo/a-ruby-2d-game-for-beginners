class Abertura
  attr_accessor :menuimg, :menurun, :botaostart, :botaoend, :tela
  def initialize(window)
    @tela = window
    @menuimg = Gosu::Image.new(self, "img/menu/bg.jpg", true)
    @botaostart = Gosu::Image.new(self, "img/menu/botaoiniciar.jpg", true)
    @botaoend = Gosu::Image.new(self, "img/menu/botaoiniciar.jpg", true)
    @menurun = true
  end
  
  def update
    if @menurun
      puts "lol"
    else
      puts "Lal"
    end
  end
  
  def draw
    @menuimg.draw(0,0,0)
      @botaostart.draw(320,240,3)
        @botaoend.draw(320,300,3)
  end
end
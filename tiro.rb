class Tiro
    attr_reader :x, :y, :labareda, :tiro, :player, :window
   
    def initialize(window)
        @tela = window
        @x = @tela.player.x
        @y = @tela.player.y+80
        @labareda = Gosu::Image.new(@tela, "img/flame.png", true)
    end
   

   
    def update
      @x = @x + 10
       @tela.bichos.each {|bicho| bicho.levou?(self)}
      if @x > 640
        morrer
      end
    end
   
    def morrer
      @tela.tiros.delete(self)  
    end
   
    def draw
            @labareda.draw(@x, @y, 4)
    end
   
end
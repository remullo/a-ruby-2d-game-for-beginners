class Tiro
    attr_reader :x, :y, :labareda, :tiro, :player, :window
   
    def initialize(window)
        @tela = window
        @x = @tela.player.x
        @y = @tela.player.y+80
        @labareda = Gosu::Image.new(@tela, "img/flame.png", true)
		@som = Gosu::Sample.new(@tela, "mus/smp/shot.wav")
		@tirosample = @som.play(vol = 1, speed = 1, looping = false)
		
		$t = 0
		$tir = 0
    end
   

   
    def update
		if $t<1000
		$t += 1
		end
		if $t==1000
		$tir+=1
		$t = 0
		end
		if $tir>=1000
		$tir = 0
		end
		@tirosample
    
	@x = @x + 10
       @tela.bichos.each {|bicho| bicho.levou?(self)}
      if @x >= 400 + @tela.player.x
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
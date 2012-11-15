require 'player'

class Enemy
  attr_reader :x, :y, :tela, :mons, :vivo, :pl, :speed, :player
  def initialize(window)
    @tela = window
    @mons = Gosu::Image.new(@tela, 'img/monster.png', true)
    @vivo = true
    @y = rand(@tela.height) - @mons.height
    @ace = 0.1
    @velx = 2
    @vely = 2
    @x = 660
    @speed = @x - 10*4
    
 
  end



  def mover(tiro)
    @x = @x - @velx
    if @y > @tela.player.y
      @y -= @vely
    elsif @y < @tela.player.y
      @y += @vely
    end
    
    if @y > @tela.width
      @y = rand(@tela.width)
    end

    #if (@x <= 320) then
      @velx += @ace
    #end

   # levou?(tiro)
   #---------------------------------LEVELS LOGICA -------------------------------------------#
    if @tela.player.pontos > 200 and @tela.player.pontos < 400
        @ace = 0.2
        @tela.player.estagio = 2
    end
    
     if @tela.player.pontos > 400 and @tela.player.pontos < 600
         @ace = 0.3
          @tela.player.estagio = 3
     end
     if @tela.player.pontos > 600 and @tela.player.pontos < 1000
          @ace = 0.4
           @tela.player.estagio = 4
     end 
         
     if @tela.player.pontos >1000
           @ace = 0.6
           @tela.player.estagio = 5
      end
  #------------------------------------------------------------------------------------#    
  if @tela.player.pontos
      
      
    if(@x <= -@mons.width)
      morrer
    end
  end
  
  def morrer
    @tela.bichos.delete(self)  
    @tela.player.pontos = @tela.player.pontos + 10
  
  end

  end
  def getpoints
    if
    self.x <= 0
    @tela.player.pontos = @tela.player.pontos + 10
    end
  end

  def draw
    @mons.draw(@x, @y, 3)
  end

  def levou?(tiro)
    if Gosu::distance(tiro.x, tiro.y, @x, @y) < 60
      morrer
    end
  end
end
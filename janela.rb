$LOAD_PATH << "."
require 'rubygems'
require 'gosu'
require 'player'
require 'player2'
require 'objects/Fogo.rb'
require 'bicho'
require_relative 'tiro'

require_relative 'clock'



#----------- Janela de entrada/abertura --------------------------------
class GameWindow < Gosu::Window
  attr_reader  :musica, :closebutton ,:ponteiro, :botaoiniciar, :iniciotexto, :player, :player2, :bgtiles, :bichos, :menu, :fonte, :fonte2, :clock, :pontos, :tiros, :atirar, :background_image, :estagio, :telainicio, :bgmenu
  def initialize
    
    super 640,480, false
    tileable = true
    @tempoTiro = 0
    self.caption = "Plume Brothers - v 1.8 "
    @background_image = Gosu::Image.new(self, "img/flamesky.jpg", true)
    @gameover = Gosu::Image.new(self, "img/game_over.png", true)
    @bichos = 2.times.map {Enemy.new(self)} 
    @clock = Timer.new(self, @bichos)
    @tiros = []
    @atirar = true
    @telainicio = true
    
   
    @fogo = Fogo.new(self)
    @fogo.surgir(350,400)

    @player = Player.new(self)
    @player.warp(50, 100)
    @point = @player.pontos

    @player2 = Player2.new(self)
    @player2.warp(500,200)
   
    @ponteiro = Ponteiro.new(self)

    @rodando = true
    @iniciar = false
    @menu = true
	@pause = true
    
     #---------------itens do menu-----------------------------------
    @bgmenu  = Gosu::Image.new(self, "img/menu/bg.jpg")
    @botaoiniciar = Botaoiniciar.new(self)
    @startbutton = Gosu::Image.new(self, "img/menu/botaoiniciar.png")
    @closebutton = Botaofechar.new(self)
    
    #-----------------------TEXTOS UTILIZADOS NO GAME--------------------------------
    @fonte = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @fonte2 = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @fonte3 = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @estagio = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @iniciotexto = Gosu::Font.new(self, Gosu::default_font_name, 30)
    @textoreset = Gosu::Font.new(self, Gosu::default_font_name, 30)
    #---------------------ESTAGIOS
    @stage1 = Gosu::Image.new(self, "img/STAGE1.png", true)
	
    end

  def update
    

    @ponteiro.update


    if (Gosu::distance(@ponteiro.x, @ponteiro.y, @botaoiniciar.x, @botaoiniciar.y) < 140 ) 
       if button_down? Gosu::Button::MsLeft
        @menu = false
        end
    end

        if (Gosu::distance(@ponteiro.x, @ponteiro.y, @closebutton.x, @closebutton.y) < 150)
            if button_down? Gosu::Button::MsLeft
              close
            end
        end

    
  if button_down? Gosu::KbX then
    @iniciar = true
  end
    if @rodando #Confere se o jogo estará rodando ou não
      if @player.hit_by? @bichos then 
        @rodando = false
		
       
      else
        if @iniciar
        
        rungame
        end
      end
    end
    
    #----------------------------------RESET POSITION ----------------------------#
    if @rodando == false and button_down? Gosu::Button::KbR and @player.score > 0
      @rodando = true
    @player.reset_position
    end
    #--------------------------------PAUSE GAME ------------------------------------------
	if  @pause and button_down? Gosu::Button::KbP
			@pause == false

	end
	
    #-------------------------------FUNÇÃO DO PLACAR FINAL------------------------#
     if (@player.score == 0) 
       @textofase
          puts "O seu Score foi de: #{@player.pontos} pontos!!"
          puts "Estagio maximo atingido: #{@player.estagio}!!"
         
     end
  end
#--------------------------------PARTE DA LÓGICA DO JOGO SEPARADA EM UMA DEF ---------------------------------#
  def rungame
    bichovivo.each {|bicho| bicho.mover(@bicho)}
    
    @player.move
        @clock.atual
    #@player2.move


    #---------------------------------------------------CONTROLES PLAYER 1-------------------------------------#

    if button_down? Gosu::KbLeft or button_down? Gosu::GpLeft then
    @player.turn_left
    end
    if button_down? Gosu::KbRight or button_down? Gosu::GpRight then
    @player.turn_right
    end

    if button_down? Gosu::KbUp or button_down? Gosu::GpUp then
    @player.up

    end

    if button_down? Gosu::KbDown or button_down? Gosu::GpDown then
    @player.down
    end
   
   
   #----------------------------------TIRO---------------------------------------------------
    
     
    @tiros.each {|tiro| tiro.update }
    
    
    #-------------------------------PLAYER 2-----------------------------------------------------

    if button_down? Gosu::KbA or button_down? Gosu::GpLeft then
    @player2.turn_left
    end

    if button_down? Gosu::KbD or button_down? Gosu::GpRight then
    @player2.turn_right
    end

    if button_down? Gosu::KbW or button_down? Gosu::GpUp then
    @player2.subir
    end

    if button_down? Gosu::KbS or button_down? Gosu::GpDown then
    @player2.descer
    end

  end

  def draw
    @tiros.each {|tiro| tiro.draw}
    @bichos.each {|bicho| bicho.draw}
    @player.draw
    
    if button_down? Gosu::Kb2
       @player2.draw
    end 
    
    
    @fonte2.draw("FLAMING PIDGEOT", 10, 10, 3.0, 1.0, 1.0, 0xffffffff)
    @fonte.draw("Lifes P1: #{@player.score} miserable lifes", 10, 29, 3.0, 1.0, 1.0, 0xF3FF3323)
    if (@iniciar == false)
    @iniciotexto.draw("PRESSIONE 'X' PARA INICIAR O JOGO", 100, 240, 3.0, 1.0, 1.0, 0xffffffff)
    end
      if (@rodando == false)
        @textoreset.draw("PRESSIONE 'R' PARA RESSUCITAR", 100, 240, 3.0, 1.0, 1.0, 0xffffffff)
      end
    @estagio.draw("Estagio #{@player.estagio} ", 10, 70, 3.0, 1.0, 1.0, 0xffffffff)
    @fonte.draw("Pontos P1: #{@player.pontos} pontos", 10, 50, 3.0, 1.0, 1.0, 0xffffffff)
   if @menu
    @bgmenu.draw(0,0,8)
    @startbutton.draw(180,200,8)
     @ponteiro.draw
     @botaoiniciar.draw
     @closebutton.draw
    end
  #  @fogo.draw
    bichovivo.each {|bicho| bicho.draw}
   
    @background_image.draw(0, 0, 0);
    
    if @player.score == 0
          
      @gameover.draw(0,0,5)
        if button_down? Gosu::Button::KbM
          @menu = true
          @player.pontos = -10
          @player.estagio = 1
          @player.score = 3
          @player.warp(50, 100)
          bichovivo.each {|bicho| bicho.morrer}
          if (Gosu::distance(@ponteiro.x, @ponteiro.y, @botaoiniciar.x, @botaoiniciar.y) < 140 ) 
            @rodando=true
            @iniciar = false
          end
          
        end
  #-------------------------------------------estagios -----------------------------
    if @player.estagio = 1 and player.pontos<=0
      @stage1.draw(200,200, 5)
    
    end        
   
    end
    
     

    
  end
  
  def bichovivo
    @bichos.select {|bicho| bicho.vivo == true}
  end

  def button_down(id)
         
    if id == Gosu::KbSpace
  
      if ((Gosu::milliseconds - @tempoTiro) > 700)
        @tiros << Tiro.new(self)
        @tempoTiro = Gosu::milliseconds
      end
    elsif id == Gosu::KbEscape
      close
    end
  end
end

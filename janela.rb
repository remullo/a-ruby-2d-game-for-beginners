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
  attr_reader :player, :player2, :bichos, :menu, :fonte, :fonte2, :clock, :pontos, :tiros, :atirar, :background_image, :estagio, :telainicio, :bgmenu
  def initialize
    
    super 640,480, false
    @tempoTiro = 0
    self.caption = "Plume Brothers - - v 1.0"
    @background_image = Gosu::Image.new(self, "img/sp.png", true)
    @bgmenu = Gosu::Image.new(self, "img/menu/bg.jpg", true)
    @bichos = 2.times.map {Enemy.new(self)}
    @clock = Timer.new(self, @bichos)
    @tiros = []
    @atirar = true
    @telainicio = true
    

    @fogo = Fogo.new(self)
    @fogo.surgir(350,400)

    @player = Player.new(self)
    @player.warp(320, 240)
    @point = @player.pontos

    @player2 = Player2.new(self)
    @player2.warp(500,200)
   

    @rodando = true

    @fonte = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @fonte2 = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @fonte3 = Gosu::Font.new(self, Gosu::default_font_name, 20)
    @estagio = Gosu::Font.new(self, Gosu::default_font_name, 20)

  end

  def update

    if @rodando #Confere se o jogo estará rodando ou não
      if @player.hit_by? @bichos then 
        @rodando = false
       
      else
        rungame
      end
    end
    
    #----------------------------------RESET POSITION ----------------------------#
    if @rodando == false and button_down? Gosu::Button::KbR and @player.score > 0
      @rodando = true
    @player.reset_position
    end
    
    #-------------------------------FUNÇÃO DO PLACAR FINAL------------------------#
     if (@player.score == 0) 
          puts "O seu Score foi de: #{@player.pontos} pontos!!"
          close
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
    
    if button_down? Gosu::KbP
       @player2.draw
    end 
    
    
    @fonte2.draw("FLAMING PIDGEOT", 10, 10, 3.0, 1.0, 1.0, 0xffffffff)
    @fonte.draw("Lifes P1: #{@player.score} miserable lifes", 10, 29, 3.0, 1.0, 1.0, 0xF3FF3323)
    @estagio.draw("Estagio #{@player.estagio} ", 10, 70, 3.0, 1.0, 1.0, 0xffffffff)
    @fonte.draw("Pontos P1: #{@player.pontos} pontos", 10, 50, 3.0, 1.0, 1.0, 0xffffffff)
    @bgmenu.draw(0,0,0)
    @fogo.draw
    bichovivo.each {|bicho| bicho.draw}
   

    @background_image.draw(0, 0, 0);
  end
  
  def bichovivo
    @bichos.select {|bicho| bicho.vivo == true}
  end

  def button_down(id)
    if id == Gosu::KbSpace
      if ((Gosu::milliseconds - @tempoTiro) > 500)
        @tiros << Tiro.new(self)
        @tempoTiro = Gosu::milliseconds
      end
    elsif id == Gosu::KbEscape
      close
    end
  end
end

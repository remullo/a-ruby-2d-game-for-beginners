$LOAD_PATH << "."
require 'rubygems'
require 'gosu'
require_relative 'janela'
require_relative 'player'
require_relative 'tiro'
require_relative 'clock'
require 'objects/Fogo.rb'
require 'bicho'
require 'menu'


window = GameWindow.new
window.show


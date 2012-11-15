#!ruby
require 'gosu'


ROOT_DIR = File.expand_path(File.dirname __FILE__)



Gosu::Image.autoload_dirs.unshift "#{ROOT_DIR}/img"
#Gosu::Font.autoload_dirs.unshift "#{ROOT_DIR}/data/fnt"

#default user config
$config = {
  'screen_size' => [1400, 960],
  'controls' => 'windows',
}
if File.exists?("#{ROOT_DIR}/user_settings.yml")
  $config = $config.merge(YAML.load_file "#{ROOT_DIR}/user_settings.yml")
elsif File.exists?("#{ROOT_DIR}/user_settings.yml.default")
  puts 'No user_settings.yml, using default settings'
  $config = $config.merge(YAML.load_file "#{ROOT_DIR}/user_settings.yml.default")
#else cry a lot and raise exceptions
end

if RUBY_VERSION < '1.9.3'
  alias old_rand rand
  def rand(blah)
    if blah.is_a?(Range)
      Gosu.random(blah.min, blah.max)
    else
      old_rand(blah)
    end
  end
end

class Numeric
  def radians_to_vec2
    CP::Vec2.new(Math.cos(self), Math.sin(self))
  end
  
  def i() to_i end
  def f() to_f end
end

begin
  if state = ARGV.find { |_| _.size == 2 }
    state = state.upcase
    state = SpaceGame::ChooseGame::GameStates.find { |k, _| _[2] == state }
    abort "Invalid state #{state} please check the top of src/gamestates/menu-state.rb for valid options" unless state
    state = state[1][0]
  else state = SpaceGame::ChooseGame end
  
  SpaceGame::MainWindow.new(state).show
rescue
  case RUBY_PLATFORM
  when /linux/, /darwin/
    #colorful backtrace :>
    puts
    puts "\e[31m#{$!.class}\e[0m: #{$!.message}"
    puts $!.backtrace.map { |z|
      z = z.split ':'
      z[0] = z[0].split('/')
      z[0] = z[0][-[z[0].size, 5].min..-1]
      z[0][-1] = "\e[35m#{z[0][-1]}\e[0m"
      z[1] = "\e[33m#{z[1]}\e[0m"
      "#{z[0].join('/')}:#{z[1]}:#{z[2]}"
    }.join("\n")
  else
    puts "#{$!.class}: #{$!.message}"
    puts
    puts "  #{$!.backtrace.join "\n  "}"
  end
end
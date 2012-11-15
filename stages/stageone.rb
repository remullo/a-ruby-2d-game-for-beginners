require '../bicho'

class Stageone

 def initialize(window)
   attr_reader :bicho
  @bicho = Enemy.new(self)
  
 
 end  

 def stageone
        @arraymonster = Array.new
        @arraymonster = []
        @arraymonster << @bicho
        @arraymonster << @bicho
        @arraymonster << @bicho
        @arraymonster << @bicho
        
       for @bicho.each do |@bicho|
       end
     end
     
end
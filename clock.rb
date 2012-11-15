class Timer
  def initialize(window, bichos)
    @bichos = bichos
    @window = window
    @inicio = Time.now
    @cada_n_seg = 1
    @ult_seg_lembrado = 0
  end
  
  def atual
    @bichos << Enemy.new(@window) if mais_bicho?
  end
  
  def segundos
    (Time.now-@inicio).to_i
  end

  
  def mais_bicho?
    if segundos != @ult_seg_lembrado and segundos%@cada_n_seg == 0
      @ult_seg_lembrado = segundos
      true
    else
      false
    end
  end
  
end
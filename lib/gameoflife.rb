class GameOfLife
  attr_accessor :state

  def initialize(start_state = '')
    @state = start_state
  end

  def tick
    @state = @state.gsub(/\*/, '.')
  end
end
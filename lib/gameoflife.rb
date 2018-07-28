class GameOfLife
  attr_accessor :state

  def initialize(start_state = '')
    @state = start_state
    @board = start_state.split('\n')
    @rows, @cols = @board.shift.split(' ')
  end

  def tick
    @state = @state.gsub(/\*/, '.')
  end
end
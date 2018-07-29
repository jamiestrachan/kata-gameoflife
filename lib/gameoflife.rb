class GameOfLife
  def initialize(start_state = '')
    @state = start_state
    @board = start_state.split('\n')
    @rows, @cols = @board.shift.split(' ').map(&:to_i)
    @board = @board.map { |r| r.split('') }
  end

  def state
    ["#{@rows} #{@cols}", @board.map { |r| r.join('') }].join('\\n')
  end

  def tick
    @board = @board.each_with_index.map do |row, row_index|
      row.each_with_index.map do |current, col_index|
        age(current, row_index, col_index)
      end
    end
  end

  def age(current, row_index, col_index)
    neighbors = determine_neighbors(row_index, col_index)
    neighbor_cells = count_neighbor_cells(neighbors)
    new_state = current
    if current == '*'
      if neighbor_cells < 2 || neighbor_cells > 3
        new_state = '.'
      end
    else
      if neighbor_cells == 3
        new_state = '*'
      end
    end
    new_state
  end

  def determine_neighbors(row_index, col_index)
    retval = []
    if row_index - 1 >= 0
      retval.push([row_index - 1, col_index - 1]) if col_index - 1 >= 0
      retval.push([row_index - 1, col_index])
      retval.push([row_index - 1, col_index + 1]) if col_index + 1 < @cols
    end

    retval.push([row_index, col_index - 1]) if col_index - 1 >= 0
    retval.push([row_index, col_index + 1]) if col_index + 1 < @cols

    if row_index + 1 < @rows
      retval.push([row_index + 1, col_index - 1]) if col_index - 1 >= 0
      retval.push([row_index + 1, col_index])
      retval.push([row_index + 1, col_index + 1]) if col_index + 1 < @cols
    end

    retval
  end

  def count_neighbor_cells(neighbors)
    neighbors.select{ |row_index, col_index| @board[row_index][col_index] == '*' }.size
  end
end

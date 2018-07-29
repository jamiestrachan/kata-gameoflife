require 'gameoflife'

RSpec.describe GameOfLife do
  context 'with a board of dimensions 1, 1 and no cells' do
    it 'should return the same state' do
      gol = GameOfLife.new('1 1\n.')
      expect(gol.state).to eq '1 1\n.'
    end

    it 'should return the same state after a tick' do
      gol = GameOfLife.new('1 1\n.')
      gol.tick
      expect(gol.state).to eq '1 1\n.'
    end
  end

  context 'with a board of dimensions 1, 1 and one cell' do
    it 'should return the same state' do
      gol = GameOfLife.new('1 1\n*')
      expect(gol.state).to eq '1 1\n*'
    end

    it 'should a board with no cells after a tick' do
      gol = GameOfLife.new('1 1\n*')
      gol.tick
      expect(gol.state).to eq '1 1\n.'
    end
  end

  context 'determine_neighbors' do
    it 'should work in the top left corner' do
      gol = GameOfLife.new('4 4\n....\n....\n....\n....')
      expect(gol.determine_neighbors(0, 0)).to eq [[0, 1], [1, 0], [1, 1]]
    end

    it 'should work on the right side' do
      gol = GameOfLife.new('4 4\n....\n....\n....\n....')
      expect(gol.determine_neighbors(2, 3)).to eq [[1, 2], [1, 3], [2, 2], [3, 2], [3, 3]]
    end

    it 'should work in the middle' do
      gol = GameOfLife.new('4 4\n....\n....\n....\n....')
      expect(gol.determine_neighbors(1, 1)).to eq [[0, 0], [0, 1], [0, 2], [1, 0], [1, 2], [2, 0], [2, 1], [2, 2]]
    end

    it 'should work in the bottom right corner' do
      gol = GameOfLife.new('4 4\n....\n....\n....\n....')
      expect(gol.determine_neighbors(3, 3)).to eq [[2, 2], [2, 3], [3, 2]]
    end
  end

  context 'count_neighbor_cells' do
    it 'should count properly for few neighbors, no cells' do
      gol = GameOfLife.new('2 2\n..\n..')
      expect(gol.count_neighbor_cells([[0, 1], [1, 0], [1, 1]])).to eq 0
    end
    it 'should count properly for few neighbors, many cells' do
      gol = GameOfLife.new('2 2\n.*\n**')
      expect(gol.count_neighbor_cells([[0, 1], [1, 0], [1, 1]])).to eq 3
    end
    it 'should count properly for many neighbors, many cells' do
      gol = GameOfLife.new('3 3\n***\n***\n***')
      expect(gol.count_neighbor_cells([[0, 0], [0, 1], [0, 2], [1, 0], [1, 2], [2, 0], [2, 1], [2, 2]])).to eq 8
    end
    it 'should count properly for many neighbors, few cells' do
      gol = GameOfLife.new('3 3\n*..\n*..\n*..')
      expect(gol.count_neighbor_cells([[0, 0], [0, 1], [0, 2], [1, 0], [1, 2], [2, 0], [2, 1], [2, 3]])).to eq 3
    end
  end

  context 'with a 2,2 board' do
    it 'should grow a new cell when there are three to start' do
      gol = GameOfLife.new('2 2\n.*\n**')
      gol.tick
      expect(gol.state).to eq '2 2\n**\n**'
    end
  end

  context 'small exploder' do
    it 'should reach a stable state' do
      gol = GameOfLife.new('13 13\n.............\n.............\n.............\n.............\n.............\n......*......\n.....***.....\n.....*.*.....\n......*......\n.............\n.............\n.............\n.............')
      16.times { gol.tick }
      expect(gol.state).to eq '13 13\n......*......\n.....*.*.....\n.....*.*.....\n......*......\n.............\n.**.......**.\n*..*.....*..*\n.**.......**.\n.............\n......*......\n.....*.*.....\n.....*.*.....\n......*......'
    end
  end
end

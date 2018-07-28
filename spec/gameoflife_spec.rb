require 'gameoflife'

RSpec.describe GameOfLife do
  context 'with no initial state' do
    it 'should return an empty board' do
      gol = GameOfLife.new
      expect(gol.state).to eq ''
    end
  end

  context 'with a board of dimensions 0, 0' do
    it 'should return a board of dimensions 0, 0' do
      gol = GameOfLife.new('0 0')
      expect(gol.state).to eq '0 0'
    end
  end

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

  context 'with a 2,2 board' do
    it 'should grow a new cell when there are three to start' do
      gol = GameOfLife.new('2 2\n.*\n**')
      gol.tick
      expect(gol.state).to eq '2 2\n**\n**'
    end
  end
end
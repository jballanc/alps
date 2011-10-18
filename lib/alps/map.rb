class Map
  def initialize(size, max_height)
    raise "Size must be greater than 1." unless size > 1
    @max = size - 1 # Only square maps for now.
    @mountains = {}
    size.times do |x|
      size.times do |y|
        @mountains[[x,y]] = Mountain.new(max_height, [x, y])
      end
    end
  end

  def each_mountain
    @mountains.each do |pos, mountain|
      yield mountain, pos
    end
  end

  def mountains_adjacent_to(pos)
    x, y = *pos
    adjacent = []
    adjacent << @mountains[[x, y+1]] unless y == @max # North
    adjacent << @mountains[[x+1, y]] unless x == @max # East
    adjacent << @mountains[[x, y-1]] unless y == 0    # South
    adjacent << @mountains[[x-1, y]] unless x == 0    # West
    adjacent
  end
end

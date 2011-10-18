class Skier
  DIRECTIONS = [:north, :east, :west, :south]
  attr_reader :pos
  def initialize(mountain, pos, lodge)
    @mountains_visited = [mountain]
    @lodge = lodge

    @momentum = mountain.height
    @pos = pos
    @direction = nil
  end

  def ski_to(mountains)
    skiers = [self]
    skiers << self.dup until skiers.length == mountains.length
    skiers.zip(mountains).map do |skier, mountain|
      skier.turn_and_ski_to(mountain)
    end
  end

  def turn_and_ski_to(mountain)
    new_dir = new_direction(mountain.pos)
    unless @direction == nil # We start with no direction
      turns = num_turns(new_dir)
      @momentum -= Integer(@momentum * (0.1 * turns))
    end

    if mountain.height > @momentum
      @lodge.report_run(@mountains_visited.length)
      return nil
    else
      @mountains_visited << mountain
      @pos = mountain.pos
      @direction = new_dir
      return self
    end
  end

  private
  def new_direction(new_pos)
    case [@pos[0] - new_pos[0], @pos[1] - new_pos[1]]
    when [0, 1] then :north
    when [1, 0] then :east
    when [0, -1] then :south
    when [-1, 0] then :west
    end
  end

  def num_turns(new_dir)
    n = DIRECTIONS.index(@direction)
    m = DIRECTIONS.index(new_dir)
    n, m = m, n if n > m
    diff = m - n
    diff %= DIRECTIONS.length/2 if diff > DIRECTIONS.length/2
    diff
  end
end

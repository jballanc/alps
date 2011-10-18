class Mountain
  attr_reader :height, :pos
  def initialize(max_height, pos)
    raise "Max height must be greater than 10" unless max_height > 10
    @height = rand(max_height - 10) + 10
    @pos = pos
  end
end

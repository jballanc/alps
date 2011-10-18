class Mountain
  attr_reader :height, :pos
  def initialize(max_height, pos)
    @height = rand(max_height) + 1
    @pos = pos
  end
end

class SkiLodge
  attr_reader :longest_run
  def initialize
    @skiers = []
    @longest_run = 0
  end

  def report_run(length)
    if length > @longest_run
      @longest_run = length
    end
  end

  def ski_map(trail_map)
    trail_map.each_mountain do |mountain, pos|
      @skiers << Skier.new(mountain, pos, self)
    end

    until @skiers.empty?
      @skiers.map! do |skier|
        skier.ski_to(trail_map.mountains_adjacent_to(skier.pos))
      end.flatten!.compact!

      if $debug
        puts "Skiers remaining: #{@skiers.length}."
        puts "Skier momentums: #{@skiers.map { |s| s.instance_variable_get(:@momentum)}.uniq.sort}"
      end
    end
  end
end

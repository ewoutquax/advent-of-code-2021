class Cave
  attr_reader :name, :adjecent

  def initialize(name)
    @name = name

    @is_small = name.match(/[A-Z]/).nil?

    @adjecent = []
  end

  def is_start?
    @name == "start"
  end

  def is_end?
    @name == "end"
  end

  def small?
    @is_small
  end

  def add_adjecent(cave)
    @adjecent << cave
  end

  def reachable_caves(path, allow_one_double_small_cave)
    can_visit_small_cave_again = if allow_one_double_small_cave
        all_small_caves = path.select(&:small?).map(&:name)
        (all_small_caves.size - all_small_caves.uniq.size) == 0
      else
        false
      end

    if can_visit_small_cave_again
      @adjecent.reject(&:is_start?)
    else
      @adjecent.reject { |cave| cave.small? && path.include?(cave) }
    end
  end

  def self.parse_caves(lines)
    cave_names =
      lines
        .inject([]) { |acc, line| acc << line.split("-") }
        .flatten
        .uniq

    caves = cave_names.each_with_object({}) { |name, acc| acc[name] = Cave.new(name) }

    lines.each do |line|
      from, to = line.split("-")
      caves[from].add_adjecent(caves[to])
      caves[to].add_adjecent(caves[from])
    end

    caves
  end
end

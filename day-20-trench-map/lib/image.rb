# frozen-string-literal: true

class Image
  attr_reader :all_pixels

  def initialize(enhancement)
    @enhancement = enhancement

    @mapped_pixels = {}
    @all_pixels = []
  end

  def enhance(background_value: '.')
    min_y = @mapped_pixels.keys.min
    max_y = @mapped_pixels.keys.max
    min_x = @mapped_pixels.keys.map { |row| @mapped_pixels[row].keys }.flatten.min
    max_x = @mapped_pixels.keys.map { |row| @mapped_pixels[row].keys }.flatten.max

    puts ''
    puts "map size (default value: '#{background_value}'"
    puts '--------'
    puts "[#{min_x}, #{min_y}] - [#{max_x}, #{max_y}]"

    ((min_y - 1)..(max_y + 1)).to_a.each do |y|
      ((min_x - 1)..(max_x + 1)).to_a.each do |x|
        persistence, pixel =
          if @mapped_pixels.key?(y) && @mapped_pixels[y].key?(x)
            [:existing, @mapped_pixels[y][x]]
          else
            temp = Pixel.new(background_value, x, y)
            temp.link_to_neighbours(@mapped_pixels)
            [:new, temp]
          end

        code, value = pixel.enhance(@enhancement, background_value)

        print "Enhancing pixel at [#{x},#{y}] via '#{code}' to '#{value}'. This is a #{persistence} pixel. "

        if persistence == :new && pixel.new_value != background_value
          puts 'This background-pixel has changed; add it to the image'
          add_pixel(pixel, x, y)
          pixel.neighbours.each { |n| n.link_to_neighbours(@mapped_pixels) }
        else
          puts 'This pixel will NOT be persisted'
        end

        puts "> The image now has '#{all_pixels.size}' pixels"
      end
    end

    @all_pixels.each { |pixel| pixel.enhance(@enhancement, background_value) }
    @all_pixels.each(&:update_value_with_next_value)
  end

  def draw
    min_y = @mapped_pixels.keys.min
    max_y = @mapped_pixels.keys.max
    min_x = @mapped_pixels.keys.map { |row| @mapped_pixels[row].keys }.flatten.min
    max_x = @mapped_pixels.keys.map { |row| @mapped_pixels[row].keys }.flatten.max

    puts ''
    puts 'Drawing map size'
    puts '----------------'
    puts "[#{min_x}, #{min_y}] - [#{max_x}, #{max_y}]"

    (min_y..max_y).to_a.each do |y|
      print "y '#{y}': "
      (min_x..max_x).to_a.each do |x|
        value =
          if @mapped_pixels.key?(y) && @mapped_pixels[y].key?(x)
            @mapped_pixels[y][x].value || 'x'
          else
            '.'
          end

        print value
      end
      puts ''
    end
  end

  def self.parse(lines)
    image = new(lines.shift)

    # Skip blank line
    lines.shift

    lines.each.with_index do |line, y|
      line.split(//).each.with_index do |value, x|
        pixel = Pixel.new(value, x, y)
        image.add_pixel(pixel, x, y)
      end
    end

    image.link_pixels
    image
  end

  def add_pixel(pixel, x, y)
    puts "add-pixel: #{pixel.class}"
    pixel.is_a?(Pixel) || raise(pixel.class)
    @all_pixels << pixel

    @mapped_pixels[y] ||= {}
    @mapped_pixels[y][x] = pixel
  end

  def link_pixels
    @all_pixels.each do |pixel|
      pixel.nil? || pixel.link_to_neighbours(@mapped_pixels)
    end
  end
end

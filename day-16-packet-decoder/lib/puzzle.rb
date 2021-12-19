module Puzzle
  class << self
    def sum_version_ids(code = nil)
      code ||= read_file()

      PacketFactory.from_hex(code).sum_version_ids()
    end

    def exec_operators(code = nil)
      code ||= read_file()

      PacketFactory.from_hex(code).value
    end

    private

    def read_file
      File.read("input.txt")
    end
  end
end

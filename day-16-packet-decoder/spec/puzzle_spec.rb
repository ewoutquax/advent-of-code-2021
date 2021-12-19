require "rspec"
require "bootstrapper"

RSpec.describe Puzzle do
  context "part 1" do
    it "from packet '8A004A801A8002F478'" do
      assert_sum_version_ids("8A004A801A8002F478", 16)
    end

    it "from packet '620080001611562C8802118E34'" do
      assert_sum_version_ids("620080001611562C8802118E34", 12)
    end

    it "from packet 'C0015000016115A2E0802F182340'" do
      assert_sum_version_ids("C0015000016115A2E0802F182340", 23)
    end

    it "from packet 'A0016C880162017C3686B18A3D4780'" do
      assert_sum_version_ids("A0016C880162017C3686B18A3D4780", 31)
    end

    it "solve puzzle" do
      assert_sum_version_ids(nil, 957)
    end
  end

  context "part 2" do
    context "examples" do
      it "sum" do
        assert_operator_result("C200B40A82", 3)
      end
      # it "product" do
      #   assert_operator_result("04005AC33890", 3)
      # end
      it "min" do
        assert_operator_result("880086C3E88112", 7)
      end
      it "max" do
        assert_operator_result("CE00C43D881120", 9)
      end
      it "less than" do
        assert_operator_result("D8005AC2A8F0", 1)
      end
      it "greater than" do
        assert_operator_result("F600BC2D8F", 0)
      end
      it "equal to" do
        assert_operator_result("9C005AC2F8F0", 0)
      end

      it "nested" do
        assert_operator_result("9C0141080250320F1802104A08", 1)
      end
    end

    it "solve puzzle" do
      assert_operator_result(nil, 744953223228)
    end
  end

  def assert_operator_result(hex_code, expected_result)
    result = Puzzle.exec_operators(hex_code)
    expect(result).to eq(expected_result)
  end

  def assert_sum_version_ids(hex_code, expected_result)
    expect(Puzzle.sum_version_ids(hex_code)).to eq(expected_result)
  end
end

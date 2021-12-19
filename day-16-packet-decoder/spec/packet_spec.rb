require "rspec"
require "bootstrapper"

RSpec.describe Packet do
  context "decode" do
    context "literal packet" do
      let(:packet) { PacketFactory.from_hex("D2FE28") }

      it "detect type literal" do
        expect(packet).to be_kind_of(Packet::Literal)
      end

      it "packet-version" do
        expect(packet.packet_version).to eq(6)
      end

      it "packet-type-id" do
        expect(packet.packet_type_id).to eq(4)
      end

      it "can determine the length of the package" do
        expect(packet.my_length).to eq(21)
      end

      it "three groups" do
        expect(packet.value).to eq(2021)
      end
    end

    context "operator packet with subpacket length" do
      let (:packet) { PacketFactory.from_hex("38006F45291200") }

      it "detect type Operator::Length" do
        expect(packet).to be_kind_of(Packet::Operator::Length)
      end

      it "packet-version" do
        expect(packet.packet_version).to eq(1)
      end

      it "length type-id" do
        expect(packet.length_type_id).to eq("0")
      end

      it "subpacket-length" do
        expect(packet.subpacket_length).to eq(27)
      end

      it "can determine the length of the package" do
        expect(packet.my_length).to eq(49)
      end
    end

    context "operator packet with number of subpackets" do
      let (:packet) { PacketFactory.from_hex("EE00D40C823060") }

      it "detect type Operator::Count" do
        expect(packet).to be_kind_of(Packet::Operator::Count)
      end

      it "length type-id" do
        expect(packet.length_type_id).to eq("1")
      end

      it "can determine the length of the package" do
        expect(packet.my_length).to eq(51)
      end
    end
  end
end

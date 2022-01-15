# frozen-string-literal: true

require 'rspec'
require 'bootstrapper'

RSpec.describe Helpers do
  let(:lines_scanner_0) do
    [
      '--- scanner 0 ---',
      '404,-588,-901',
      '528,-643,409',
      '-838,591,734',
      '390,-675,-793',
      '-537,-823,-458',
      '-485,-357,347',
      '-345,-311,381',
      '-661,-816,-575',
      '-876,649,763',
      '-618,-824,-621',
      '553,345,-567',
      '474,580,667',
      '-447,-329,318',
      '-584,868,-557',
      '544,-627,-890',
      '564,392,-477',
      '455,729,728',
      '-892,524,684',
      '-689,845,-530',
      '423,-701,434',
      '7,-33,-71',
      '630,319,-379',
      '443,580,662',
      '-789,900,-551',
      '459,-707,401'
    ]
  end

  let(:lines_scanner_1) do
    [
      '--- scanner 1 ---',
      '686,422,578',
      '605,423,415',
      '515,917,-361',
      '-336,658,858',
      '95,138,22',
      '-476,619,847',
      '-340,-569,-846',
      '567,-361,727',
      '-460,603,-452',
      '669,-402,600',
      '729,430,532',
      '-500,-761,534',
      '-322,571,750',
      '-466,-666,-811',
      '-429,-592,574',
      '-355,545,-477',
      '703,-491,-529',
      '-328,-685,520',
      '413,935,-424',
      '-391,539,-444',
      '586,-435,557',
      '-364,-763,-893',
      '807,-499,-711',
      '755,-354,-619',
      '553,889,-390'
    ]
  end

  context 'matching' do
    let(:scanner0) { Scanner.parse(lines_scanner_0) }
    let(:scanner1) { Scanner.parse(lines_scanner_1) }

    it 'can determine the transformation-rules, based on 4 beacons' do
      expected_result =
        { x: [:x, -1],
          y: [:y, 1],
          z: [:z, -1] }

      scanner1_beacon, scanner1_beacon_to, scanner0_beacon, scanner0_beacon_to =
        scanner1.find_matching_beacons_from_scanner0(scanner0)

      rules =
        Helpers.transformation_rules(scanner1_beacon, scanner1_beacon_to, scanner0_beacon, scanner0_beacon_to)

      expect(rules).to eq(expected_result)
    end

    it 'can calculate the scanner-location relative to scanner0, based on 2 beacons and the transformation-rules' do
      scanner1_beacon, scanner1_beacon_to, scanner0_beacon, scanner0_beacon_to =
        scanner1.find_matching_beacons_from_scanner0(scanner0)

      rules =
        Helpers.transformation_rules(scanner1_beacon, scanner1_beacon_to, scanner0_beacon, scanner0_beacon_to)

      scanner_location =
        Helpers.calculate_scanner_location(scanner0_beacon, scanner1_beacon, rules)

      expect(scanner_location).to eq([68, -1246, -43])
    end
  end
end

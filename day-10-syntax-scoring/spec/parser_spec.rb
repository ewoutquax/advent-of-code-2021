require "rspec"
require "pry"
require "bootstrapper"

RSpec.describe Parser do
  it "recognizes a valid line" do
    expect(Parser.line("")).to eq([:valid])
    expect(Parser.line("a")).to eq([:valid])
    expect(Parser.line("[]")).to eq([:valid])
    # expect(Parser.line("[({})]")).to eq(:valid)
    # expect(Parser.line("[]()")).to eq(:valid)
    # expect(Parser.line("[](){}<>")).to eq(:valid)
    # expect(Parser.line("[<>({}){}[([])<>]]")).to eq(:valid)
    # expect(Parser.line("(((((((((())))))))))")).to eq(:valid)
  end

  it "recognizes the incorrect closing char" do
    expect(Parser.line("{([(<{}[<>[]}>{[]{[(<()>")).to eq([:corrupt, "}"])
    expect(Parser.line("[[<[([]))<([[{}[[()]]]")).to eq([:corrupt, ")"])
  end
  it "reports missing closing tags" do
    expect(Parser.line("[")).to eq([:incomplete, "]"])
    expect(Parser.line("([])[<>")).to eq([:incomplete, "]"])
    expect(Parser.line("{}{([])[<>")).to eq([:incomplete, "]}"])

    expect(Parser.line("[({(<(())[]>[[{[]{<()<>>")).to eq([:incomplete, "}}]])})]"])
  end
end

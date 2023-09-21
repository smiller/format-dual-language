require_relative '../lib/formatter'

RSpec.describe Formatter do

  it "does alternate" do
    input = <<~DOC
      original-1
      original-2 eheu

      translation-1
      translation-2 oh dear
    DOC

    expected_output = <<~DOC
      |-----------------+-----------------------|
      | original-1      | translation-1         |
      | original-2 eheu | translation-2 oh dear |
    DOC

    formatter = Formatter.new

    expect(formatter.format(input)).to eq(expected_output)
  end
end

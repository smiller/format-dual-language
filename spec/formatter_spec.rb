require 'formatter'

RSpec.describe Formatter do

  # it "does alternate without stanzas" do
  #   input = <<~DOC
  #     original-1
  #     original-2 eheu

  #     translation-1
  #     translation-2 oh dear
  #   DOC

  #   expected_output = <<~DOC
  #     |-----------------+-----------------------|
  #     | original-1      | translation-1         |
  #     | original-2 eheu | translation-2 oh dear |
  #   DOC

  #   formatter = Formatter.new

  #   expect(formatter.format(input)).to eq(expected_output)
  # end

  # it "does alternate with stanzas" do
  #   input = <<~DOC
  #     original-st1-1
  #     original-st1-2 eheu

  #     translation-st1-1
  #     translation-st1-2 oh dear

  #     original-st2-3
  #     original-st2-4
  #     original-st2-5

  #     translation-st2-3
  #     translation-st2-4
  #     translation-st2-5
  #   DOC

  #   expected_output = <<~DOC
  #     |---------------------+---------------------------|
  #     | original-st1-1      | translation-st1-1         |
  #     | original-st1-2 eheu | translation-st1-2 oh dear |
  #     |                     |                           |
  #     | original-st2-3      | translation-st2-3         |
  #     | original-st2-4      | translation-st2-4         |
  #     | original-st2-5      | translation-st2-5         |
  #   DOC

  #   formatter = Formatter.new

  #   expect(formatter.format(input)).to eq(expected_output)
  # end
end

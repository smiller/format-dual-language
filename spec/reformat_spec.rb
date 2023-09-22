require 'fileutils'

require_relative '../lib/formatter'

RSpec.describe "cli for formatter" do

  before do
    FileUtils.rm_r("spec/tmp_files")
    FileUtils.mkdir("spec/tmp_files")
  end

  it "writes correct output file" do
    input_file_path = "spec/example_files/input.txt"
    expected_output_file_path = "spec/example_files/expected_output.txt"
    output_file_path = "spec/tmp_files/actual.txt"

    system("./reformat alternating --in #{input_file_path} --out #{output_file_path}")

    actual_lines = File.open(output_file_path).readlines
    expected_lines = File.open(expected_output_file_path).readlines

    expect(actual_lines).to match_array(expected_lines)
  end

end

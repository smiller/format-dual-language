require 'fileutils'
require 'open3'

RSpec.describe "cli for FileInterface" do

  before do
    FileUtils.rm_r("spec/tmp_files") if Dir.exist?("spec/tmp_files")
    FileUtils.mkdir("spec/tmp_files")
  end

  it "displays help if no options selected" do
    stdout, _, _ = Open3.capture3("./reformat")
    expect(stdout).to include("Reformats dual-language texts")
  end

  it "invalid path: returns error message" do
    input_file_path = "spec/example_files/macavitys_not_there.txt"
    _, stderr, _ = Open3.capture3("./reformat alternating --in #{input_file_path}")
    expect(stderr).to include("input file must exist")
    expect(stderr).to include("-o FILE option for output file required")
  end

  it "happy path: writes correct output file" do
    input_file_path = "spec/example_files/input.txt"
    expected_output_file_path = "spec/example_files/expected_output.txt"
    output_file_path = "spec/tmp_files/actual.txt"

    Open3.capture3("./reformat alternating --in #{input_file_path} --out #{output_file_path}")

    actual_lines = File.open(output_file_path).readlines
    expected_lines = File.open(expected_output_file_path).readlines

    expect(actual_lines).to match_array(expected_lines)
  end
end

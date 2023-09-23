require 'file_interface'

RSpec.describe FileInterface do

  # before do
  #   FileUtils.rm_r("spec/tmp_files") if Dir.exist?("spec/tmp_files")
  #   FileUtils.mkdir("spec/tmp_files")
  # end

  # describe "unhappy paths" do
  #   describe "multiple errors can appear" do
  #     let(:ui) { FileInterface.new(options: {}) }
  #     it "has both expected error messages" do
  #       ui.validate
  #       expect(ui.errors).to match_array(["-i FILE option for input file required",
  #                                         "-o FILE option for output file required"])
  #     end
  #   end

  #   describe "no --in argument" do
  #     # we're passing in a dummy stderr so we don't pollute actual stderr from file_interface_spec.
  #     # cli_spec verifies that the errors are passed to the real $stderr and do show up.
  #     let(:ui) { FileInterface.new(options: {out: "spec/tmp_files/actual.txt"}, stderr: StringIO.new) }

  #     it "has expected error message" do
  #       ui.validate
  #       expect(ui.errors).to match_array(["-i FILE option for input file required"])
  #     end

  #     it "exits" do
  #       expect { ui.process }.to raise_error SystemExit
  #     end
  #   end

  #   describe "no --out argument" do
  #     let(:ui) { FileInterface.new(options: {in: "spec/example_files/input.txt"}, stderr: StringIO.new) }

  #     it "has expected error message" do
  #       ui.validate
  #       expect(ui.errors).to match_array(["-o FILE option for output file required"])
  #     end

  #     it "exits" do
  #       expect { ui.process }.to raise_error SystemExit
  #     end
  #   end

  #   describe "input file doesn't exist (and it should)" do
  #     let(:ui) { FileInterface.new(options: {in: "spec/example_files/macavitys_not_there.txt", out: "spec/tmp_files/actual.txt"}, stderr: StringIO.new) }

  #     it "has expected error message" do
  #       ui.validate
  #       expect(ui.errors).to match_array(["input file must exist"])
  #     end

  #     it "exits" do
  #       expect { ui.process }.to raise_error SystemExit
  #     end
  #   end

  #   describe "output file already exists (and it shouldn't)" do
  #     let(:ui) { FileInterface.new(options: {in: "spec/example_files/input.txt", out: "spec/example_files/input.txt"}, stderr: StringIO.new) }

  #     it "has expected error message" do
  #       ui.validate
  #       expect(ui.errors).to match_array(["output file must not exist"])
  #     end

  #     it "exits" do
  #       expect { ui.process }.to raise_error SystemExit
  #     end
  #   end
  # end

  # it "happy path" do
  #   input_file_path = "spec/example_files/input.txt"
  #   expected_output_file_path = "spec/example_files/expected_output.txt"
  #   output_file_path = "spec/tmp_files/actual.txt"

  #   options = {
  #     in: input_file_path,
  #     out: output_file_path
  #   }

  #   FileInterface.new(options: options).process

  #   actual_lines = File.open(output_file_path).readlines
  #   expected_lines = File.open(expected_output_file_path).readlines

  #   expect(actual_lines).to match_array(expected_lines)
  # end
end

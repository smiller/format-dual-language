require 'processor'

RSpec.describe Processor do

  before do
    FileUtils.rm_r("spec/tmp_files") if Dir.exist?("spec/tmp_files")
    FileUtils.mkdir("spec/tmp_files")
  end

  let(:ui) { described_class.new(options: options, stderr: StringIO.new) }

  describe "unhappy paths" do
    describe "multiple errors can appear" do
      let(:options) { {} }
      it "has both expected error messages" do
        ui.validate
        expect(ui.errors).to match_array([described_class::ERROR_INPUT_OPTION_MISSING,
                                          described_class::ERROR_OUTPUT_OPTION_MISSING])
      end
      it "does not continue after failing validation" do
        expect(ui).not_to receive(:process_after_validation)
        ui.process
      end
    end

    describe "no --in argument" do
      let(:options) { { out: "spec/tmp_files/actual.txt" } }

      it "has expected error message" do
        ui.validate
        expect(ui.errors).to match_array([described_class::ERROR_INPUT_OPTION_MISSING])
      end

      it "does not continue after failing validation" do
        expect(ui).not_to receive(:process_after_validation)
        ui.process
      end
    end

    describe "no --out argument" do
      let(:options) { { in: "spec/example_files/input.txt" } }

      it "has expected error message" do
        ui.validate
        expect(ui.errors).to match_array([described_class::ERROR_OUTPUT_OPTION_MISSING])
      end

      it "does not continue after failing validation" do
        expect(ui).not_to receive(:process_after_validation)
        ui.process
      end
    end

    describe "input file doesn't exist (and it should)" do
      let(:options) { { in: "spec/example_files/macavitys_not_there.txt", out: "spec/tmp_files/actual.txt" } }

      it "has expected error message" do
        ui.validate
        expect(ui.errors).to match_array([described_class::ERROR_INPUT_FILE_NOT_FOUND])
      end

      it "does not continue after failing validation" do
        expect(ui).not_to receive(:process_after_validation)
        ui.process
      end
    end

    describe "output file already exists (and it shouldn't)" do
      let(:options) { { in: "spec/example_files/input.txt", out: "spec/example_files/input.txt" } }

      it "has expected error message" do
        ui.validate
        expect(ui.errors).to match_array([described_class::ERROR_OUTPUT_FILE_FOUND])
      end

      it "does not continue after failing validation" do
        expect(ui).not_to receive(:process_after_validation)
        ui.process
      end
    end
  end

  it "happy path" do
    input_file_path = "spec/example_files/input.txt"
    expected_output_file_path = "spec/example_files/expected_output.txt"
    output_file_path = "spec/tmp_files/actual.txt"

    options = {
      in: input_file_path,
      out: output_file_path
    }

    described_class.new(options: options).process

    actual_lines = File.open(output_file_path).readlines
    expected_lines = File.open(expected_output_file_path).readlines

    expect(actual_lines).to match_array(expected_lines)
  end
end

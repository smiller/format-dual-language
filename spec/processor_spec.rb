require 'processor'

RSpec.describe Processor do

  before do
    FileUtils.rm_r("spec/tmp_files") if Dir.exist?("spec/tmp_files")
    FileUtils.mkdir("spec/tmp_files")
  end

  describe "unhappy paths" do
    describe "multiple errors can appear" do
      let(:ui) { described_class.new(options: {},
                                     stderr: StringIO.new) }
      it "has both expected error messages" do
        ui.validate
        expect(ui.errors).to match_array(["-i FILE option for input file required",
                                          "-o FILE option for output file required"])
      end
      it "does not continue after failing validation" do
        expect(ui).not_to receive(:process_after_validation)
        ui.process
      end
    end

    describe "no --in argument" do
      let(:ui) { described_class.new(options: { out: "spec/tmp_files/actual.txt" },
                                     stderr: StringIO.new) }

      it "has expected error message" do
        ui.validate
        expect(ui.errors).to match_array(["-i FILE option for input file required"])
      end

      it "does not continue after failing validation" do
        expect(ui).not_to receive(:process_after_validation)
        ui.process
      end
    end

    describe "no --out argument" do
      let(:ui) { described_class.new(options: { in: "spec/example_files/input.txt" },
                                     stderr: StringIO.new) }

      it "has expected error message" do
        ui.validate
        expect(ui.errors).to match_array(["-o FILE option for output file required"])
      end

      it "does not continue after failing validation" do
        expect(ui).not_to receive(:process_after_validation)
        ui.process
      end
    end

    describe "input file doesn't exist (and it should)" do
      let(:ui) { described_class.new(options: {
                                       in: "spec/example_files/macavitys_not_there.txt",
                                       out: "spec/tmp_files/actual.txt"
                                     },
                                     stderr: StringIO.new) }

      it "has expected error message" do
        ui.validate
        expect(ui.errors).to match_array(["input file must exist"])
      end

      it "does not continue after failing validation" do
        expect(ui).not_to receive(:process_after_validation)
        ui.process
      end
    end

    describe "output file already exists (and it shouldn't)" do
      let(:ui) { described_class.new(options: {
                                       in: "spec/example_files/input.txt",
                                       out: "spec/example_files/input.txt"
                                     },
                                     stderr: StringIO.new) }

      it "has expected error message" do
        ui.validate
        expect(ui.errors).to match_array(["output file must not exist"])
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

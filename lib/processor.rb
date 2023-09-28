# frozen_string_literal: true

require_relative 'formatter'

class Processor

  ERROR_INPUT_OPTION_MISSING = "-i FILE option for input file required"
  ERROR_OUTPUT_OPTION_MISSING = "-o FILE option for output file required"
  ERROR_INPUT_FILE_NOT_FOUND = "input file must exist"
  ERROR_OUTPUT_FILE_FOUND = "output file must not exist"

  attr_accessor :errors

  def initialize(options:, stderr: $stderr)
    @options = options
    @stderr = stderr
  end

  def validate
    @errors = []

    if !@options.has_key?(:in)
      @errors << ERROR_INPUT_OPTION_MISSING
    end
    if !@options.has_key?(:out)
      @errors << ERROR_OUTPUT_OPTION_MISSING
    end

    if @options.include?(:in) && !File.file?(@options[:in])
      @errors << ERROR_INPUT_FILE_NOT_FOUND
    end
    if @options.include?(:out) && File.file?(@options[:out])
      @errors << ERROR_OUTPUT_FILE_FOUND
    end
  end

  def process_after_validation
    input = File.open(@options[:in]).readlines.join("")

    output = Formatter.new.format(input)

    File.open(@options[:out], "w") do |f|
      f.write(output)
    end
  end

  def process
    validate
    if @errors.any?
      @stderr.puts @errors
      return
    end

    process_after_validation
  end
end

require_relative 'formatter'

class Processor

  ERR_INPUT_REQ = "-i FILE option for input file required".freeze
  ERR_OUTPUT_REQ = "-o FILE option for output file required".freeze
  ERR_INPUT_MISSING = "input file must exist".freeze
  ERR_OUTPUT_MISSING = "output file must not exist".freeze

  attr_accessor :errors

  def initialize(options:, stderr: $stderr)
    @options = options
    @stderr = stderr
  end

  def validate
    @errors = []

    if !@options.has_key?(:in)
      @errors << ERR_INPUT_REQ
    end
    if !@options.has_key?(:out)
      @errors << ERR_OUTPUT_REQ
    end

    if @options.include?(:in) && !File.file?(@options[:in])
      @errors << ERR_INPUT_MISSING
    end
    if @options.include?(:out) && File.file?(@options[:out])
      @errors << ERR_OUTPUT_MISSING
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

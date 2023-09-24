require_relative 'formatter'

class Processor

  attr_accessor :errors

  def initialize(options:, stderr: $stderr)
    @options = options
    @stderr = stderr
  end

  def validate
    @errors = []

    if !@options.has_key?(:in)
      @errors << "-i FILE option for input file required"
    end
    if !@options.has_key?(:out)
      @errors << "-o FILE option for output file required"
    end

    if @options.include?(:in) && !File.file?(@options[:in])
      @errors << "input file must exist"
    end
    if @options.include?(:out) && File.file?(@options[:out])
      @errors << "output file must not exist"
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

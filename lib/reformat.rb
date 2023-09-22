#!/usr/bin/env ruby

require 'optparse'

require_relative 'formatter'

def alternating_check_params(options)
  errors = []

  if !options.has_key?(:in)
    errors << "-i FILE option for input file required"
  end
  if !options.has_key?(:out)
    errors << "-o FILE option for output file required"
  end

  if errors.any?
    $stderr.puts errors
    exit 1
  end

  if options.include?(:in) && !File.file?(options[:in])
    errors << "input file must exist"
  end
  if options.include?(:out) && File.file?(options[:out])
    errors << "output file must not exist"
  end

  if errors.any?
    $stderr.puts errors
    exit 1
  end
end

def alternating_format(options)
  input = File.open(options[:in]).readlines.join("")

  formatter = Formatter.new

  output = formatter.format(input)

  File.open(options[:out], "w") do |f|
    f.write(output)
  end
end

def process_alternating(options)
  alternating_check_params(options)
  alternating_format(options)
end

options = {}

option_parser = OptionParser.new do |opts|
  opts.banner = <<~HELP_TEXT
                  Reformats dual-language texts.

                  Usage:
                      ./reformat [variant] [options]

                  Example:
                      ./reformat alternating --in [input file] --out [output file]

                  Options:
                HELP_TEXT
  opts.on('-i FILE','--in FILE', 'Input file') do |file|
    options[:in] = file
  end
  opts.on('-o FILE', '--out FILE', 'Output file') do |file|
    options[:out] = file
  end
  opts.on( '-h', '--help', 'Display help' ) do
    options[:help] = true
    puts opts
  end
end

option_parser.parse!
variant = ARGV[0]

if (variant.nil? && options.empty?) || variant == "help"
  puts option_parser
end

if variant == "alternating"
  process_alternating(options)
end

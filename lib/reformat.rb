#!/usr/bin/env ruby

require 'optparse'

require_relative 'file_interface'

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
  FileInterface.new(options: options).process
end

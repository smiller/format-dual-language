class Formatter

  def format(input)
    parts = input.split("\n\n")

    lines_orig = parts[0].split("\n")
    max_length_orig = lines_orig.map(&:size).max

    lines_transl = parts[1].split("\n")
    max_length_transl = lines_transl.map(&:size).max

    output_lines = []
    output_lines << "|-#{'-'*max_length_orig}-+-#{'-'*max_length_transl}-|"

    lines_orig.zip(lines_transl).each do |pair|
      output_lines << "| #{pair[0].ljust(max_length_orig, ' ')} | #{pair[1].ljust(max_length_transl, ' ')} |"
    end

    "#{output_lines.join("\n")}\n"
  end
end

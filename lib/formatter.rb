class Formatter

  def format(input)
    parts = input.split("\n\n")

    original, translation = parts.partition.with_index { |_,i| i.even? }

    @line_length_original = max_length(original)
    @line_length_translation = max_length(translation)

    output_lines = []
    output_lines << header_line

    output_lines << stanza(original.first, translation.first)

    more_stanzas_original = original.drop(1)
    more_stanzas_translation = translation.drop(1)

    more_stanzas_original.zip(more_stanzas_translation).each do |pair|
      output_lines << stanza_break_line
      output_lines << stanza(pair[0], pair[1])
    end

    "#{output_lines.join("\n")}\n"
  end

  def max_length(stanzas)
    stanzas.map { |s| s.split("\n") }.flatten.map(&:size).max
  end

  def header_line
    "|-#{'-'*@line_length_original}-+-#{'-'*@line_length_translation}-|"
  end

  def stanza_break_line
    "| #{' '*@line_length_original} | #{' '*@line_length_translation} |"
  end

  def stanza(original, translation)
    original.split("\n").zip(translation.split("\n")).map do |pair|
      "| #{pair[0].ljust(@line_length_original, ' ')} | #{pair[1].ljust(@line_length_translation, ' ')} |"
    end
  end
end

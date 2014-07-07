class ItauSmsParser

  def parse(text_line)
    simple_line = ""
    debito = text_line[/Compra/].size > 0
    match = /(\d{4})-(\d{2})-(\d{2}).+?-(.+?)valor.+RS(.+?)em.+/.match(text_line)
    if (match)
      simple_line = "#{match[3]}/#{match[2]}/#{match[1]};#{match[4].strip};"
      if (debito)
        simple_line += "-"
      end
      simple_line += "#{match[5].strip};"
    end
    simple_line.empty? ? nil : simple_line
  end

end

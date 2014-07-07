class ItauSmsParser

  def parse(text_line)
    simple_line = ""
    linha_ja_processada = /(\d{2})\/(\d{2})\/(\d{4});(.+?);(.+?);(.+)?/
    
    return text_line if linha_ja_processada.match(text_line)
    
    debito = (text_line =~ /compra|pagamento|\sdoc\s/i)
    transacao_cartao = /(\d{4})-(\d{2})-(\d{2}).+?-(.+?)valor.+RS(.+?)em.+/
    pagamento_titulos = /(\d{4})-(\d{2})-(\d{2}).+?o\spagamento\sde(.+?)foi.+?valor.+R.(.+?)em.+/
    doc_transferencia = /(\d{4})-(\d{2})-(\d{2}).+?realizad.(.+?)\s.+?valor.+R.(.+?)em.+/
    match = transacao_cartao.match(text_line)
    if (!match)
      match = pagamento_titulos.match(text_line)
      if (!match)
        match = doc_transferencia.match(text_line)
      end
    end
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

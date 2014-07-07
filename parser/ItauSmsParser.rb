class ItauSmsParser

  def parse(text_line)
    simple_line = ""
    debito = (text_line =~ /compra|pagamento/i)
    transacao_cartao = /(\d{4})-(\d{2})-(\d{2}).+?-(.+?)valor.+RS(.+?)em.+/.match(text_line)
    pagamento_titulos = /(\d{4})-(\d{2})-(\d{2}).+?o\spagamento\sde(.+?)foi.+?valor.+R.(.+?)em.+/.match(text_line)
    if (transacao_cartao)
      simple_line = "#{transacao_cartao[3]}/#{transacao_cartao[2]}/#{transacao_cartao[1]};#{transacao_cartao[4].strip};"
      if (debito)
        simple_line += "-"
      end
      simple_line += "#{transacao_cartao[5].strip};"
    elsif (pagamento_titulos)
      simple_line = "#{pagamento_titulos[3]}/#{pagamento_titulos[2]}/#{pagamento_titulos[1]};#{pagamento_titulos[4].strip};"
      if (debito)
        simple_line += "-"
      end
      simple_line += "#{pagamento_titulos[5].strip};"    
    end
    simple_line.empty? ? nil : simple_line
  end

end

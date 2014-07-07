class ExcelUtil

  def self.montar_resumo(transaction_lines, idioma)
    resumo = ""
    categorias = []
    formula = idioma == :pt ? "somaproduto" : "sumproduct"
    
    
    colunas = ('A'..'D').to_a
    indice_categoria = colunas.size - 1
    indice_valor = indice_categoria - 1
    linhas_branco = 2
    
    transaction_lines.each do |t|
      detalhes = t.split(";")
      categorias << detalhes[3] if detalhes.size == 4
    end
    
    categorias << "Sem categoria"
    
    categorias = categorias.uniq
    expressoes = {}
    inicio = categorias.size + linhas_branco + 1
    fim = inicio + transaction_lines.size - 1
    categorias.each do |cat|
      texto = cat
      texto = "" if cat == "Sem categoria"
      expressao = "=#{formula}("
      expressao += "(#{colunas[indice_valor]}#{inicio}:#{colunas[indice_valor]}#{fim}<0) * "
      expressao += "(#{colunas[indice_categoria]}#{inicio}:#{colunas[indice_categoria]}#{fim} = \"#{texto}\") * "
      expressao += "(#{colunas[indice_valor]}#{inicio}:#{colunas[indice_valor]}#{fim})"
      expressao += ")"
      expressoes[cat] = expressao
    end
    expressoes
  end

end

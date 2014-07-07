require './file/FileUtil.rb'
require './report/ExcelUtil.rb'

puts "iniciando processamento..."
file_name = ARGV.first
puts "..processando arquivo #{file_name}"

encoding = "ISO-8859-1"
puts "..usando encoding #{encoding}"

conteudo_simplificado = FileUtil.read_content(file_name, encoding)
puts "..#{conteudo_simplificado.size} transações encontradas"

formulas = ExcelUtil.montar_resumo(conteudo_simplificado, :en)
puts "..#{formulas.size} categorias encontradas"

formulas_array = []
formulas.each do |k, v|
  formulas_array << "#{k};#{v}"
end
formulas_array << "" << "" #linhas em branco. deve casar com o excel util

FileUtil.write_content(file_name, formulas_array << conteudo_simplificado, encoding)
puts "fim do processamento"

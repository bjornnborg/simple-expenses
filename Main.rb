require './file/FileUtil.rb'
require './report/ExcelUtil.rb'
puts "iniciando processamento..."
puts "hadouken"
puts /.+/.match("hadouken\n")[0]

file_name = ARGV.first
conteudo_simplificado = FileUtil.read_content(file_name)
formulas = ExcelUtil.montar_resumo(conteudo_simplificado, :en)
#puts formulas
formulas_array = []
formulas.each do |k, v|
  formulas_array << "#{k};#{v}"
end
formulas_array << "" << ""

puts formulas_array

FileUtil.write_content(file_name, formulas_array << conteudo_simplificado)

puts "fim do processamento"

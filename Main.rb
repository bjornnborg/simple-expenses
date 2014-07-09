require './file/FileUtil.rb'
require './report/ExcelUtil.rb'

class Planilha
  
  def initialize(transacoes, encoding, lang)
    @transacoes=transacoes
    @encoding=encoding
    @lang=lang
  end
  
  def montar
    formulas = ExcelUtil.montar_resumo(@transacoes, @lang)
    puts "..#{formulas.size} categorias encontradas"
    formulas_array = []
    formulas.each do |k, v|
      formulas_array << "#{k};#{v}"
    end
    formulas_array << "" << "" #linhas em branco. deve casar com o excel util  
    formulas_array << @transacoes
  end

end

puts "iniciando processamento..."
file_name = ARGV.first
puts "..processando arquivo #{file_name}"

encoding = "ISO-8859-1"
puts "..usando encoding #{encoding}"

conteudo_simplificado = FileUtil.read_content(file_name, encoding)
puts "..#{conteudo_simplificado.size} transações encontradas"

planilha = Planilha.new(conteudo_simplificado, encoding, :en)
FileUtil.write_content(file_name, planilha.montar, encoding)

#cópia da planilha em pt
file_name_info = file_name.split(".")
copy_file_name = "#{file_name_info[0]}-nao-alterar.#{file_name_info[1]}"
copia_planilha = Planilha.new(conteudo_simplificado, encoding, :pt)
FileUtil.write_content(copy_file_name, copia_planilha.montar, encoding)
puts "..cópia gerada: #{copy_file_name}"

puts "fim do processamento"



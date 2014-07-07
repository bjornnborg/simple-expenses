require './parser/ItauSmsParser.rb'
class FileUtil

  def self.read_content(file_name)
    conteudo_simplificado = []
    File.open(file_name) do |file|
      parser = ItauSmsParser.new
      while line = file.gets
          linha_simplificada = parser.parse(line)
          conteudo_simplificado << linha_simplificada if linha_simplificada
      end
    end
    conteudo_simplificado  
  end
  
  def self.write_content(file_name)
  
  end

end

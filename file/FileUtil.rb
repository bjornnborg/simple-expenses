require './parser/ItauSmsParser.rb'
class FileUtil

  def self.read_content(file_name)
    conteudo_simplificado = []
    File.open(file_name) do |file|
      parser = ItauSmsParser.new
      while line = file.gets
          conteudo_simplificado << parser.parse(line)
      end
    end
    conteudo_simplificado  
  end
  
  def self.write_content(file_name)
  
  end

end

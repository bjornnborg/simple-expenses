require './parser/ItauSmsParser.rb'
class FileUtil

  def self.read_content(file_name, encoding)
    conteudo_simplificado = []
    File.open(file_name, "r:#{encoding}") do |file|
      parser = ItauSmsParser.new
      while line = file.gets
          linha_simplificada = parser.parse(line.gsub(/\n/,""))
          conteudo_simplificado << linha_simplificada if linha_simplificada
      end
    end
    conteudo_simplificado  
  end
  
  def self.write_content(file_name, content_lines, encoding)
    File.open(file_name, "w:#{encoding}") do |f|
      content_lines.each do |line|
        f.puts line;
      end
    end
  end

end

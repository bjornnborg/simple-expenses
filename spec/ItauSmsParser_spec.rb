require './parser/ItauSmsParser.rb'
describe ItauSmsParser do

  context "Simplificar linhas" do
  
    it "Deve simplificar linhas transação cartão titular" do
      linha_complexa = "2014-06-06	19:05:45	in	25001	25001	Compra aprovada no seu PERSON VISA PLAT final 8008 - MARIA JOAO valor RS 51,40 em 06/06, as 13h45."
      parser = ItauSmsParser.new
      linha_simplificada = parser.parse(linha_complexa)
      "06/06/2014;MARIA JOAO;-51,40;".should eq linha_simplificada
    end
  
  end

end

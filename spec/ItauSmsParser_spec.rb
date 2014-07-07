require './parser/ItauSmsParser.rb'
describe ItauSmsParser do

  context "Simplificar linhas" do
  
    it "Deve simplificar linhas transação cartão titular" do
      linha_complexa = "2014-06-06	19:05:45	in	25001	25001	Compra aprovada no seu PERSON VISA PLAT final 8008 - MARIA JOAO valor RS 51,40 em 06/06, as 13h45."
      parser = ItauSmsParser.new
      linha_simplificada = parser.parse(linha_complexa)
      "06/06/2014;MARIA JOAO;-51,40;".should eq linha_simplificada
    end
    
    it "Deve simplificar linhas transação cartão dependente" do
      linha_complexa = "2014-06-06	00:14:08	in	25001	25001	Compra aprovada no PERSON VISA PLAT p/ REGINA D C SILVA - BFB TAMBORE FARMAIS valor RS 95,26 em 05/06/2014 as 15h59."
      parser = ItauSmsParser.new
      linha_simplificada = parser.parse(linha_complexa)
      "06/06/2014;BFB TAMBORE FARMAIS;-95,26;".should eq linha_simplificada
    end
    
    it "Deve retornar nil para mensagem de fechamento de fatura" do
      linha_complexa = "2014-06-06	19:43:43	in	25001	25001	O total da fatura do seu PERSON VISA PLAT com vencimento em 18/06 e de RS 999.999,06. Compras a partir de 05/06 entram nos proximos lancamentos."    
      parser = ItauSmsParser.new
      linha_simplificada = parser.parse(linha_complexa)
      linha_simplificada == nil
    end
  
  end

end

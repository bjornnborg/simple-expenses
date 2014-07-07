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

    
    it "Deve simplificar linhas de pagamento de títulos de concessionária" do
      linha_complexa = "2014-06-07	07:02:37	in	25001	25001	Itau Personnalite: o pagamento de ELET.PAULO 819028100 foi efetuado no valor de R$77,50 em 06/06 as 23:57. Conta XXX95-5."
      parser = ItauSmsParser.new
      linha_simplificada = parser.parse(linha_complexa)
      "07/06/2014;ELET.PAULO 819028100;-77,50;".should eq linha_simplificada
    end
    
    it "Deve simplificar linhas de pagamento de títulos normais" do
      linha_complexa = "2014-06-07	13:05:00	in	25001	25001	Itau Personnalite: o pagamento de TITULOS foi efetuado no valor de R$57,15 em 07/06 as 10:34. Conta XXX95-5."
      parser = ItauSmsParser.new
      linha_simplificada = parser.parse(linha_complexa)
      "07/06/2014;TITULOS;-57,15;".should eq linha_simplificada
    end

  
  end
  
  context "Linhas descartadas" do
    it "Deve retornar nil para mensagem de fechamento de fatura" do
      linha_complexa = "2014-06-06	19:43:43	in	25001	25001	O total da fatura do seu PERSON VISA PLAT com vencimento em 18/06 e de RS 999.999,06. Compras a partir de 05/06 entram nos proximos lancamentos."    
      parser = ItauSmsParser.new
      linha_simplificada = parser.parse(linha_complexa)
      linha_simplificada == nil
    end
    
    it "Deve retornar nil para mensagem semanal de saldo" do
      linha_complexa = "2014-06-07	06:49:51	in	25001	25001	Itau Personnalite: o saldo de sua conta corrente  XXX95-5 e de R$ -328,60 em 06/06/2014 as 09:28."
      parser = ItauSmsParser.new
      linha_simplificada = parser.parse(linha_complexa)
      linha_simplificada == nil
    end
    
    it "Deve retornar nil para mensagem de iToken" do
      linha_complexa = "2014-06-17	00:12:47	in	25001	25001	ITAU: iToken 621308, Data: 17/06/2014, Hora: 00:12:41h."
      parser = ItauSmsParser.new
      linha_simplificada = parser.parse(linha_complexa)
      linha_simplificada == nil
    end
    
    
  end
  
  context "Linhas já processadas" do
    it "Deve retornar linhas já processadas da forma como estão" do
      linha_complexa = "07/06/2014;TITULOS;-57,15;"
      parser = ItauSmsParser.new
      linha_simplificada = parser.parse(linha_complexa)
      "07/06/2014;TITULOS;-57,15;".should eq linha_simplificada
    end
    
    it "Deve retornar linhas já processadas e categorizadas da forma como estão" do
      linha_complexa = "07/06/2014;TITULOS;-57,15;Carro"
      parser = ItauSmsParser.new
      linha_simplificada = parser.parse(linha_complexa)
      "07/06/2014;TITULOS;-57,15;Carro".should eq linha_simplificada
    end  
  end

end

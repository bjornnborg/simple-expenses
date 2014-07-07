require './report/ExcelUtil.rb'
describe ExcelUtil do

  context "Montar resumo categorias" do
  
    it "Deve montar resumo transações débito categorizadas" do
      transacoes = ["06/06/2014;TELEFONE;-50,00;casa","06/06/2014;AGUA;-50,00;casa","06/06/2014;RESTAURANTE;-50,00;alimentação"]
      resumo = ExcelUtil.montar_resumo(transacoes, :pt);
      resumo.size.should be_equal 3
      resumo['casa'].should include("C6:C8") 
      #3 categorias (A1..A3), mais 2 linhas em branco (A4..A5) 3 transações (A6..A8)
    end
    
    it "Deve montar resumo transações débito não categorizadas" do
      transacoes = ["06/06/2014;TELEFONE;-50,00;","06/06/2014;AGUA;-50,00;","06/06/2014;RESTAURANTE;-50,00;"]
      resumo = ExcelUtil.montar_resumo(transacoes, :pt);
      resumo.size.should be_equal 1
      resumo['Sem categoria'].should include("D4:D6")
      #1 categorias (A1), mais 2 linhas em branco (A2..A3) 3 transações (A4..A6)
    end

  end

end

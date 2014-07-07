require './file/FileUtil.rb'
describe FileUtil do

  context "Gerenciar conteúdo" do
  
    it "Deve ler conteúdo do arquivo" do
      content = FileUtil.read_content('./spec/resources/simple_file_read.txt')
      content.size.should be_equal 2
      content[0].should eq "06/06/2014;RIACHUELO SP TAMB;-43,80;"
    end
    
    it "Não deve retornar linhas vazias" do
      content = FileUtil.read_content('./spec/resources/contendo_linha_pagamento.txt')
      content.size.should be_equal 2
      content[0].should eq "06/06/2014;RIACHUELO SP TAMB;-43,80;"
    end

  end

end

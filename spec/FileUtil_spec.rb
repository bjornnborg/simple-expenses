require './file/FileUtil.rb'
describe FileUtil do

  context "Gerenciar conteúdo" do
    it "Deve ler conteúdo do arquivo" do
      content = FileUtil.read_content('./spec/resources/simple_file_read.txt')
      content.size.should be_equal 2
      content[0].should eq "06/06/2014;RIACHUELO SP TAMB;-43,80;"
    end

    it "Deve ler conteúdo de arquivo complexo" do
      content = FileUtil.read_content('./spec/resources/complex_file_read.txt')
      content.size.should be_equal 13
      content.last.should eq "03/07/2014;SAQUE;-100,00;"
      content[6].should eq "07/06/2014;ELET.PAULO 819028100;-77,50;"
      content[11].split(";")[3].should eq "vestuário"
    end

    it "Não deve retornar linhas vazias" do
      content = FileUtil.read_content('./spec/resources/contendo_linha_pagamento.txt')
      content.size.should be_equal 2
      content[0].should eq "06/06/2014;RIACHUELO SP TAMB;-43,80;"
    end

  end

end

# encoding: utf-8
require_relative "../../lib/libkanji"
gem 'rspec-rails'

module LibKanji
  describe Sentence do
    it "should break a a simple valid sentence into words" do
      text = IO.read("data/ruby.txt")
      text = "取って\n名付けられた。"

      words = Sentence.parse(text).map{|x|x.word}
      words.should == ["取って", "\n", "名", "付け", "ら", "れ", "た", "。"]
    end
  
    it "should break a complex sentence into words" do    
      text = "私がこの世でいちばん好きな場所は台所だと思う。"
      words = Sentence.parse(text).map{|x|x.word}

      # いちばん should be a single word, but for simplicity we don't look up words by pronunciation 
      words.should == ["私", "が", "この世で",  "い", "ち", "ば", "ん", "好きな", "場所", "は", "台所だ", "と", "思う", "。"]
    end
    
    it "should handle Nするという" do
      words = Sentence.parse("挑戦するという").map{|x|x.word}
      pending
      words.should == ["挑戦する", "と", "い", "う"]
    end
  end
end


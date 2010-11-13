# encoding: utf-8
require_relative "../../lib/libkanji"
gem 'rspec-rails'

module LibKanji
  describe Sentence do
    it "should break a valid sentence into words" do
      text = IO.read("data/ruby.txt")
      text = "取って\n名付けられた。"

      words = Sentence.parse(text).map{|x|x.word}
      words.should == ["取って", "\n", "名", "付け", "ら", "れ", "た", "。"]
    end
  end
end


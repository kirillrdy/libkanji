# encoding: utf-8
require_relative "../../lib/libkanji"
gem 'rspec-rails'

module LibKanji
  describe Conjugations do
    describe "verbs" do
      it "should support v1 verbs" do
        c = Conjugations.new("がめる", "v1")
        c.conjugations.include?("がめない").should be_true
        c.conjugations.include?("がめよう").should be_true
      end
    
      it "should support vk verbs" do
        c = Conjugations.new("いって来る", "vk")
        c.conjugations.include?("いって来ない").should be_true
        c.conjugations.include?("いって来よう").should be_true
        c = Conjugations.new("来る", "vk")
        c.conjugations.include?("来される").should be_true
        c.conjugations.include?("来い").should be_true
      end
      
      it "should support v5r-i (like ある)" do
        c = Conjugations.new("ある", "v5r-i")
        pending
        c.conjugations.include?("いない").should be_true
      end
    end
    
    describe "adjectives" do
      it "should support adj adjectives" do
        c = Conjugations.new("頼もしい", "adj")
        c.conjugations.include?("頼もしくない").should be_true
      end
    end
    
    describe "nouns" do
      it "should support Nだ" do
        c = Conjugations.new("台所", "n")
        c.conjugations.include?("台所だ").should be_true
      end

      it "should support Nする" do
        c = Conjugations.new("挑戦", "n")
        c.conjugations.include?("挑戦する").should be_true
        c.conjugations.include?("挑戦しない").should be_true
      end
    end
  end
end

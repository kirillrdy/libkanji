# encoding: utf-8
require_relative "../../lib/libkanji"
require 'rspec'

module LibKanji
  describe Dictionary do
    it "should allow searching for a word" do
      Dictionary.search("来る").should be_true
    end

    it "should tell you if a word is in the dictionary or not" do
      Dictionary.has_word?("来る").should be_true
    end

    it "should load some words commonly written in hiragana" do
      Dictionary.has_word?("いい").should be_true
    end
  end
end

# encoding: utf-8
class LibKanji::DictionaryWord
  attr_accessor :word
  attr_accessor :pronunciation
  attr_accessor :types
  attr_accessor :meaning
  
  def to_s
    stuff = "#{@pronunciation} "
    stuff = "#{@word} " unless @pronunciation
    "#{stuff}: #{@types.join ","} #{@meaning}"
  end
  
  def initialize(word,pronunciation,types,meaning)
    @word = word
    @pronunciation = pronunciation
    @types = types
    @meaning = meaning
  end
  
  def conjugations
    list = []
    for type in @types
      list_of_conjugations =  LibKanji::Conjugations.new(@word,type).conjugations
      list += list_of_conjugations if list_of_conjugations
    end
    return list
  end
end

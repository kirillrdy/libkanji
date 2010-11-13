# encoding: utf-8
class LibKanji::DictionaryWord
  attr_accessor :word
  attr_accessor :pronunciation
  attr_accessor :type
  attr_accessor :meaning
  
  def to_s
    stuff = "#{@pronunciation} "
    stuff = "#{@word} " unless @pronunciation
    "#{stuff}: #{@type.join ","} #{@meaning}"
  end
  
  def initialize(word,pronunciation,type,meaning)
    @word = word
    @pronunciation = pronunciation
    @type = type
    @meaning = meaning
  end
  
  def conjugations
    list = []
    if type.include? "v1"
      [ "ない",'ます','ましょう','たい','なさい','られる','れば','よう','た','て'].each {|x| list << self.word.gsub(/る$/,x)}
    end
    if type.include? "v5u"
      ['わない','います','いましょう','いたい','いなさい','える','え','えば','おう','った','って'].each {|x| list << self.word.gsub(/う$/,x)}
    end
    if type.include? "v5k"
      ['かない','きます','きましょう','きたい','きなさい','ける','け','けば','こう','いた','いて'].each {|x| list << self.word.gsub(/く$/,x)}
    end
    if type.include? "v5s"
      ['さない','します','しましょう','したい','しなさい','せる','せ','せば','そう','した','して'].each {|x| list << self.word.gsub(/す$/,x)}
    end
    if type.include? "v5t"
      ['たない','ちます','ちましょう','ちたい','ちなさい','てる','て','てば','とう','った','って'].each {|x| list << self.word.gsub(/つ$/,x)}
    end
    if type.include? "v5n"
      ['なない','にます','にましょう','にたい','になさい','ねる','ね','ねば','のう','んだ','んで'].each {|x| list << self.word.gsub(/ぬ$/,x)}
    end
    if type.include? "v5m"
      ['まない','みます','みましょう','みたい','みなさい','める','め','めば','もう','んだ','んで'].each {|x| list << self.word.gsub(/む$/,x)}
    end
    if type.include? "v5r"
      ['らない','ります','りましょう','りたい','りなさい','れる','れ','れば','ろう','った','って'].each {|x| list << self.word.gsub(/る$/,x)}
    end
    if type.include? "v5g"
      ['がない','ぎます','ぎましょう','ぎたい','ぎなさい','げる','げ','げば','ごう','いだ','いで'].each {|x| list << self.word.gsub(/ぐ$/,x)}
    end
    if type.include? "v5b"
      ['ばない','びます','びましょう','びたい','びなさい','べる','べ','べば','ぼう','んだ','んで'].each {|x| list << self.word.gsub(/ぶ$/,x)}
    end
    if type.include? 'adj-na'
      list << (self.word + 'な')
    end
    return list
  end
end

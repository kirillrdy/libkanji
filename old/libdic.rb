# encoding: utf-8
class Dictionary

  DICTIONARY_DUMP_FILE = '/tmp/dic_dump'
  DICTIONARY_FILE = 'data/dictionary.txt'
  #DICTIONARY_FILE = 'data/small_dic.txt'

  def self.word_search
    
    return @hash if @hash
    
    if File.exists?(DICTIONARY_DUMP_FILE)
      @hash = Marshal.load(IO.read(DICTIONARY_DUMP_FILE))
      return @hash
    end

    @hash = {}
    self.parse_dic.each do |dictionary_word|
      @hash[dictionary_word.word] ||= []
      @hash[dictionary_word.word] << dictionary_word
      
      # TODO all other possible conjugations
      for item in dictionary_word.conjugations
        @hash[item] ||= []
        @hash[item] << dictionary_word
      end
    end
    
    File.open(DICTIONARY_DUMP_FILE,'w') {|f| f.write(Marshal.dump(@hash)) }

    return @hash
  end
  
  def self.parse_dic
    text = IO.read(DICTIONARY_FILE)
    words = text.scan(/^(.*?) \/\((.*?)\) (.*)\//)
    words.map! do |word,type,meaning|
      pronunciation = word.scan(/\[(.*?)\]/).first.first if word.scan(/\[(.*?)\]/).first
      word.gsub!(/ \[.*?\]/,"")
      type = type.split(",")
      meaning = meaning.split("\/")
      DictionaryWord.new(word,pronunciation,type,meaning)
    end

    return words
  end
  
  
  def self.parse_sentence(sentence)

    list_of_words_in_sentence = []

    start = 0

    while start < sentence.length

      word_from_dictionary = nil
      matched_part_from_text = nil

      for finish in (start..sentence.length-1)
        part = sentence[start..finish]
        if Dictionary.word_search.has_key? part
          word_from_dictionary = Dictionary.word_search[part]
          matched_part_from_text = part
        end
      end

      if word_from_dictionary
        start += matched_part_from_text.length - 1
      end

      key_to_add = matched_part_from_text || sentence[start..start]
      
      list_of_words_in_sentence << [key_to_add  ,word_from_dictionary]
      
      start += 1
    end
    
    return list_of_words_in_sentence
  end
  
  
end


class DictionaryWord
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
      puts "*" * 30 if self.word == '適切'
      list << (self.word + 'な')
    end
    return list
  end

end




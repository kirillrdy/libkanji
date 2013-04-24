#!/usr/bin/ruby1.9.1


class String

  def is_hiragana?
    # range is taken from Wikipedia
    (12352..12447).include? self.ord
  end
  
  def is_katakana?
    # range is taken from Wikipedia
    (12448..12543).include? self.ord
  end
  
  def is_kana?
    # range is taken from Wikipedia
    self.is_hiragana? or self.is_katakana?
  end
  
  def is_kanji?
    # range is taken from Wikipedia
    (19968..40895).include? self.ord
  end
  
  def is_japanese?
    is_kana? or is_kanji?
  end
  
  def type
    return "Kanji" if self.is_kanji?
    return "Hiragana" if self.is_hiragana?
    return "Katakana" if self.is_katakana?
  end
  
  
  def is_ascii?
    (0..256).include? self.ord
  end
  
end

class Kanji < String
end

class Hiragana < String
end

class Katakana < String
end

class Text < String
  def self.kitchen
    self.new IO.read('data/kitchen.txt')
  end
  
  def self.yugi
    self.new IO.read('data/yugi.txt')
  end
  
  def to_sentences
  
  end
  
end

class Sentence < String
  
end

class Word < String
end

all = Text.yugi
chars = Text.yugi.chars.to_a.uniq


freq = {}

for char in all.chars
  next unless char.is_kanji?
  freq[char] ||= 0
  freq[char] += 1
end


#chars.each {|x| puts "#{x} - #{x.ord}" unless x.is_japanese? or x.is_ascii? }



freq_arr = freq.to_a.sort {|x,y| x[1] <=> y[1] }
puts freq_arr.inspect



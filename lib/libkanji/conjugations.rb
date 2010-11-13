# encoding: utf-8
class Conjugations
  def initialize(word,type)
    @word = word
    @type = type
  end
  
  def conjugations
    case @type
      #
      # Verbs
      #
      when "v1"
        [ "ない",'ます','ましょう','たい','なさい','られる','れば','よう','た','て'].map {|x| @word.gsub(/る$/,x)}
      when "v5u"
        ['わない','います','いましょう','いたい','いなさい','える','え','えば','おう','った','って'].map {|x| @word.gsub(/う$/,x)}
      when "v5k"
        ['かない','きます','きましょう','きたい','きなさい','ける','け','けば','こう','いた','いて'].map {|x| @word.gsub(/く$/,x)}
      when "v5s"
        ['さない','します','しましょう','したい','しなさい','せる','せ','せば','そう','した','して'].map {|x| @word.gsub(/す$/,x)}
      when "v5t"
        ['たない','ちます','ちましょう','ちたい','ちなさい','てる','て','てば','とう','った','って'].map {|x| @word.gsub(/つ$/,x)}
      when "v5n"
        ['なない','にます','にましょう','にたい','になさい','ねる','ね','ねば','のう','んだ','んで'].map {|x| @word.gsub(/ぬ$/,x)}
      when "v5m"
        ['まない','みます','みましょう','みたい','みなさい','める','め','めば','もう','んだ','んで'].map {|x| @word.gsub(/む$/,x)}
      when "v5r"
        ['らない','ります','りましょう','りたい','りなさい','れる','れ','れば','ろう','った','って'].map {|x| @word.gsub(/る$/,x)}
      when "v5g"
        ['がない','ぎます','ぎましょう','ぎたい','ぎなさい','げる','げ','げば','ごう','いだ','いで'].map {|x| @word.gsub(/ぐ$/,x)}
      when "v5b"
        ['ばない','びます','びましょう','びたい','びなさい','べる','べ','べば','ぼう','んだ','んで'].map {|x| @word.gsub(/ぶ$/,x)}
      when "vk"
        # 来る special case
        ['ない','ます','ましょう','たい','なさい','られる','れば','よう','た','て','される','い'].map {|x| @word.gsub(/る$/,x)}
      when "v5aru", "v5z", "v5uru", "v5u-s", "v5r-i", "v5k-s", "vt", "vs-s", "vs-i", "vs", "vn", "vi", "vz"
        puts "'#{@type}' is currently unsupported"
      #
      # Adjectives
      #
      when 'adj', 'adj-i'
        ['く','くない','くて','かった','ければ','くなかった'].map {|x| @word.gsub(/い$/,x)}
      when 'adj-na'
        [(@word + 'な')]
      when 'adj-t', 'adj-f', 'adj-no', 'adj-pn'
        puts "'#{@type}' is currently unsupported"
    end
  end
end

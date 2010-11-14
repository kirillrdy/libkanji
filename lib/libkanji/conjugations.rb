# encoding: utf-8
#
# Part of Speech Marking (from EDICT docs)
# 
# The following POS markings are currently used:
# 
#   adj-i adjective (keiyoushi)
#   adj-na  adjectival nouns or quasi-adjectives (keiyodoshi)
#   adj-no  nouns which may take the genitive case particle `no'
#   adj-pn  pre-noun adjectival (rentaishi)
#   adj-t `taru' adjective
#   adj-f noun or verb acting prenominally (other than the above)
#   adj former adjective classification (being removed)
#   adv adverb (fukushi)
#   adv-n adverbial noun
#   adv-to  adverb taking the `to' particle
#   aux auxiliary
#   aux-v auxiliary verb
#   aux-adj auxiliary adjective
#   conj  conjunction
#   ctr counter
#   exp Expressions (phrases, clauses, etc.)
#   id  idiomatic expression
#   int interjection (kandoushi)
#   iv  irregular verb
#   n noun (common) (futsuumeishi)
#   n-adv adverbial noun (fukushitekimeishi)
#   n-pref  noun, used as a prefix
#   n-suf noun, used as a suffix
#   n-t noun (temporal) (jisoumeishi)
#   num numeric
#   pn  pronoun
#   pref  prefix
#   prt particle
#   suf suffix
#   v1  Ichidan verb
#   v5  Godan verb (not completely classified)
#   v5aru Godan verb - -aru special class
#   v5b Godan verb with `bu' ending
#   v5g Godan verb with `gu' ending
#   v5k Godan verb with `ku' ending
#   v5k-s Godan verb - iku/yuku special class
#   v5m Godan verb with `mu' ending
#   v5n Godan verb with `nu' ending
#   v5r Godan verb with `ru' ending
#   v5r-i Godan verb with `ru' ending (irregular verb)
#   v5s Godan verb with `su' ending
#   v5t Godan verb with `tsu' ending
#   v5u Godan verb with `u' ending
#   v5u-s Godan verb with `u' ending (special class)
#   v5uru Godan verb - uru old class verb (old form of Eru)
#   v5z Godan verb with `zu' ending
#   vz  Ichidan verb - zuru verb - (alternative form of -jiru verbs)
#   vi  intransitive verb
#   vk  kuru verb - special class
#   vn  irregular nu verb
#   vs  noun or participle which takes the aux. verb suru
#   vs-i  suru verb - irregular
#   vs-s  suru verb - special class
#   vt  transitive verb
#
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
        # TODO: handle くる in hiragana (こない etc.)
      when "vs-i"
        # する special case
        ['しない','します','し','して','した','している','すれば','しょう','できる','される','させる','しろ'].map {|x| @word.gsub(/する$/,x)}
      when "v5r-i"
        # ある special case
        ['いない','あり','あります','あって','あった','あれば'].map {|x| @word.gsub(/ある$/,x)}
      when "v5aru", "v5z", "v5uru", "v5u-s", "v5k-s", "vt", "vs-s", "vs", "vn", "vi", "vz"
        puts "'#{@type}' is currently unsupported"
      #
      # Adjectives
      #
      when 'adj', 'adj-i'
        ['く','くない','くて','かった','ければ','くなかった'].map {|x| @word.gsub(/い$/,x)}
      when 'adj-na'
        [(@word + 'な')]
      when 'adj-pn'
        # as far as I know, this is what you can do with these rentaishi
        [(@word + 'の')]
      when 'adj-t', 'adj-f', 'adj-no'
        puts "'#{@type}' is currently unsupported"
      #
      # Nouns
      #
      when "n"
        # FIXME: する is not really a conjugation - it modifies the noun to make it a verb.
        # should really change the part of speech for the conjugation
        ['だ', 'の', 'で', 'でない', 'だった', 'なら'].map {|x| @word + x} + ['する', 'しない','します','し','して','した','している','すれば','しょう','できる','される','させる','しろ'].map {|x| @word + x}
    end
  end
end

module LibKanji
  class SentenceWord

    attr_accessor :word, :dictionary_words

    def initialize(word,dictionary_words)
      @word = word
      @dictionary_words = dictionary_words
    end
    
    def inspect
      "#{@word}"
    end

  end
end

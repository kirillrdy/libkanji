module LibKanji

  #
  # Methods for working with Japanese sentences.
  #
  module Sentence

    #
    # Parses a Japanese sentence into words.
    #
    def self.parse(sentence)
      list_of_words_in_sentence = []
      start = 0

      while start < sentence.length
        start, next_word = next_word(sentence, start)
        list_of_words_in_sentence << next_word
      end
      
      list_of_words_in_sentence
    end
    
    private
    
    def self.lookup(part)
      if Dictionary.has_word? part
        @words_from_dictionary = Dictionary.search(part)
        @matched_part_from_text = part
      end      
    end

    def self.next_start_pointer(start)
      @words_from_dictionary ? start + (@matched_part_from_text.length - 1) : start
    end

    def self.next_word(sentence, start)
      @words_from_dictionary = nil
      @matched_part_from_text = nil
      
      for finish in (start..sentence.length-1)
        lookup sentence[start..finish]
      end
      
      start = next_start_pointer(start)      
      word_in_sentence = @matched_part_from_text || sentence[start..start]

      start += 1
      [start, SentenceWord.new(word_in_sentence, @words_from_dictionary)]
    end
  end
end

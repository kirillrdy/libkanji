module LibKanji

  class Sentence

    def self.parse(sentence)
      list_of_words_in_sentence = []

      start = 0

      while start < sentence.length

        words_from_dictionary = nil
        matched_part_from_text = nil

        for finish in (start..sentence.length-1)
          part = sentence[start..finish]
          if Dictionary.has_word? part
            words_from_dictionary = Dictionary.search(part)
            matched_part_from_text = part
          end
        end

        if words_from_dictionary
          start += matched_part_from_text.length - 1
        end

        key_to_add = matched_part_from_text || sentence[start..start]
        
        list_of_words_in_sentence << SentenceWord.new(key_to_add,words_from_dictionary)

        start += 1
      end
      return self.clean_empty(list_of_words_in_sentence)
    end
    
    def self.clean_empty(words)
      new_list = []
      next_word = ""
      words.each do |word|

        if not word.dictionary_words
          next_word += word.word
        end

        if word.dictionary_words
          if not next_word == ''
            new_list << SentenceWord.new(next_word,nil)
            next_word = ''
          end
          new_list << word
        end
      end
      
      return new_list
      
    end

  end
end

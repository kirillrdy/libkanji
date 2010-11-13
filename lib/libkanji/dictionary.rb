# encoding: utf-8
module LibKanji
  module Dictionary

    DICTIONARY_DUMP_FILE = '/tmp/dic_dump'
    DICTIONARY_FILE =  File.dirname(__FILE__) + '/../../data/dictionary.txt'

    #
    # Wrapper functions for accessing words hash
    #
    def self.search(word)
      self.words_hash[word]
    end

    def self.has_word?(word)
      self.words_hash.has_key? word
    end
    
    private
    
    # This is a massive Hash that contains all our mapped answers
    def self.words_hash

      return @hash if @hash

      # dump file contains hash of words
      if File.exists?(DICTIONARY_DUMP_FILE)
        @hash = Marshal.load(IO.read(DICTIONARY_DUMP_FILE))
        return @hash
      end

      @hash = {}
      self.parse_text_dictionary.each do |dictionary_word|
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

    # Parses Plain text dictionary into Word(s)
    def self.parse_text_dictionary
      text = IO.read(DICTIONARY_FILE)
      words = text.scan(/^(.*?) \/\((.*?)\) (.*)\//)
      words.map! do |word,type,meaning|
        pronunciation = word.scan(/\[(.*?)\]/).first.first if word.scan(/\[(.*?)\]/).first
        word.gsub!(/ \[.*?\]/,"")
        types = type.split(",")
        meanings = meaning.split("\/")
        # for purpose of quality we dont need one length 
        # hiragana or katakana
        next if word.length == 1 &&  (word.is_hiragana? || word.is_katakana?)
        DictionaryWord.new(word,pronunciation,types,meanings)
      end
    
      words.delete_if {|x| x == nil }
      return words
    end

  end
end # Module

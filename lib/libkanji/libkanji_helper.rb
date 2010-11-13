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

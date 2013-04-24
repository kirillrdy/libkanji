# encoding:  utf-8

require 'svg_output'
require 'kanji_strokes'

class Kanji

  include KanjiStrokes
  include SvgOutput

  def self.list_of_all_kanji
    KanjiStrokes.strokes.keys
  end
  
  def initialize(kanji)
    @kanji = kanji
  end
  
  def number_of_strokes
    KanjiStrokes.strokes[@kanji].length
  end
  
end


##
# Looping through all Kanji and writing stroke order 
# for all of them

for kanji_char in  Kanji.list_of_all_kanji
  puts "Working on #{kanji_char}"
  kanji = Kanji.new(kanji_char)
  kanji.save_all_levels('output/')
end

Dir['output/*.svg'].each do |file|

  png_filename = "output/"+ File.basename(file,".svg")+".png"
  puts "working on #{file}"
  puts `inkscape -z -e #{png_filename} #{file} `
  `rm #{file}`
end


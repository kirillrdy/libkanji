#!/usr/bin/ruby
# encoding:  utf-8
# This is ruby script aided for Japanese Kanji Study
# aka Maki
#
# Written by Kirill Radzikhovskyy kirillrdy@gmail.com
# Distributed under GPLv3
# 2008
#
# /* For all who want to learn */


# Marshal load
strokes_dictionary = Marshal.load( IO.read('data/strokes.db_rb'))

  for key in strokes_dictionary.keys
  #for key in ["愛","馬","山"]
    
     puts key
     File.open("kanji/"+key+'.svg','w') do |file|
        
        a = IO.read("drawing.svg").gsub("place_kanji_here",key) 
        file.write( a )      
      end
    `inkscape -z -e "kanji/#{key}.png" "kanji/#{key}.svg" `
    `rm kanji/#{key}.svg`

  end

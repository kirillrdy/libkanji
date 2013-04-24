#!/usr/bin/env ruby
# encoding: utf-8

require_relative 'lib/libkanji'
#require 'libkanji'

include LibKanji


text = IO.read("data/ruby.txt")

text = "床に野菜くずが散らかっていて、スリッパの裏が真っ黒になるくらい汚いそこは、異様に広いといい。 
ひと冬軽く越せるような食料が並ぶ巨大な冷蔵庫がそびえ立ち、その銀の扉に私はもたれかかる。 
油が飛び散ったガス台や、さびのついた包丁からふと目を上げると、窓の外には淋しく星が光る。 "
puts Dictionary.search "散らかって"

text = "私がこの世でいちばん好きな場所は台所だと思う。"
puts Sentence.parse(text).map{|x|x.word }.inspect

#text.lines.each do|line|
#  puts Dictionary.parse_sentence(line).inspect
#end

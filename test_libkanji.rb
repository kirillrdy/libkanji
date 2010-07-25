#!/usr/bin/env ruby
# encoding: utf-8
require 'libkanji'

include LibKanji


text = IO.read("data/ruby.txt")

puts Sentence.parse(text.lines.to_a.first).inspect

#text.lines.each do|line|
#  puts Dictionary.parse_sentence(line).inspect
#end

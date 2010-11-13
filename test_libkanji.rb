#!/usr/bin/env ruby
# encoding: utf-8

#
# NOTE: this test is deprecated. Now using rspec.
#
require_relative 'lib/libkanji'
#require 'libkanji'

include LibKanji


text = IO.read("data/ruby.txt")

text = "取って\n名付けられた。"

puts Sentence.parse(text).map{|x|x.word }.inspect

#text.lines.each do|line|
#  puts Dictionary.parse_sentence(line).inspect
#end

#!/usr/bin/evn ruby

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'deuces'

deck = Deuces::Deck.new(:deuces_wild)
hand = Deuces::Hand.new(deck)

puts hand
puts hand.score

FACE_CODES = {'2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9, 'T' => 10,
    'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14}
SUIT_CODES = {'C' => 1, 'D' => 2, 'H' => 3, 'S' => 4}
FACES = ['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A']
SUITS = ['C', 'D', 'H', 'S']


require './deuces/card'
require './deuces/deck'
require './deuces/hand'

def main
  @deck = Deck.new('D')
  @hand = Hand.new(@deck)
  puts @hand
  puts @hand.score

  @stacked_deck = Deck.new('D')
  @hand.discard([0, 1, 2, 3, 4])
  @hand.stuff(['AH', 'KH', 'QH', 'JH', 'TH'])
  puts @hand
  puts @hand.score
end

main




module Deuces

 
  
  autoload :Card, 'deuces/card'
  autoload :Deck, 'deuces/deck'
  autoload :Hand, 'deuces/hand'
  autoload :Scoring, 'deuces/scoring'
  
  def self.run
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
end

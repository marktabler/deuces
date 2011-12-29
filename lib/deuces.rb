module Deuces

  autoload :Card, 'deuces/card'
  autoload :Joker, 'deuces/joker'
  autoload :Deck, 'deuces/deck'
  autoload :Hand, 'deuces/hand'
  autoload :Scoring, 'deuces/scoring'

  
  def self.run
    @deck = Deck.new(:deuces_wild)
    @hand = Hand.new(@deck)
    puts @hand
    puts @hand.score
  end
end

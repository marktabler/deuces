module Deuces
  class Hand
    
    include Scoring
    
    attr_accessor :cards
    
    def initialize(deck)
      @cards = deck.deal(5)
    end
    
    def to_s
      @cards.map(&:to_s).join(' ')
    end
    
    # Discard and draw are meant to model typical play options. Discarding is
    # done from the top of the array down so that deleted cards don't change
    # the indexes of cards we're still discarding.
    def discard(indexes)
      [indexes].flatten.sort.reverse.each do |card_index|
        @cards.delete_at(card_index)
      end
    end

    # Reset on draw actions only; you should never need to score a
    # hand between a discard and a draw.
    def draw(deck, count = 1)
      @cards = @cards + deck.deal(count)
      reset_scorable_hand
    end
    
    # Stuffing allows us to put specific cards into a hand. It doesn't support
    # setting the wild attribute on a card directly, but it does support stuffing
    # jokers which are always wild.
    def stuff(cards)
      [cards].flatten.each do |card_code|
        @cards << Card.new(card_code)
      end
      reset_scorable_hand
    end
        
  end
end

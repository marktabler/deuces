module Deuces
  class Hand

    attr_accessor :deuces_wild
    include Scoring

    # Hand.parse allows us to set a whole hand without needing a
    # deck. This accepts only a string of card codes. It does accept
    # any number of codes in the string.
    def self.parse(hand_code)
      cards = hand_code.split(' ')
      hand = Hand.new
      hand.stuff(*cards)
      hand
    end

    # If given a deck object as a parameter, then this will create the hand by
    # drawing five cards from the deck. If no deck object is provided, then the
    # new hand will be empty.
    def initialize(deck = nil)
      deck ? @cards = deck.deal(5) : @cards = []
    end

    # Returns all the card objects in the hand.
    def cards
      @cards
    end

    # Returns the number of cards in the hand.
    def size
      @cards.size
    end

    # Calls to_s on each of the cards in the hand and joins them with spaces
    # into a single string.
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
    
    # Stuffing allows us to put specific cards into a hand without
    # requiring a deck. This accepts a number of card objects or
    # card code strings.
    def stuff(*raw_cards)
      cards = raw_cards.map { |raw_card| Card.parse(raw_card) }
      @cards.push(*cards)
      reset_scorable_hand
    end
        
  end
end

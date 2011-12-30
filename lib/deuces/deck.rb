module Deuces
  class Deck
    # Deck type can be one of:
    # :standard, :deuces_wild,
    # :one_joker, :two_jokers
    def initialize(deck_type = :standard)
      @deck_type = deck_type
      build_deck
      shuffle!
    end

    # If you need to see what's left in the deck, or how many
    # cards are left in the deck, this is what lets you see that.
    def cards
      @cards
    end

    # Just shuffles (or reshuffles) the deck.
    def shuffle!
      @cards.shuffle!
    end

    # Deck#deal removes {count} cards from the deck and delivers them as
    # an array of card objects. Deal also accepts a {reshuffle}
    # argument that determines whether to automatically reshuffle the
    # deck if the deck runs out of cards mid-deal. {reshuffle}
    # defaults to true; if this is explicitly set to false then an
    # error will be raised if the deck is dealt out.
    def deal (count = 1, reshuffle = true)
      if @cards.size < count
        if reshuffle
          cards_after_shuffle = count - @cards.size
          dealt = @cards
          build_deck
          shuffle!
          dealt = dealt + @cards.slice!(0, cards_after_shuffle)
        else
          raise "Out of cards!"
        end
      else
        dealt = @cards.slice!(0, count)
      end
      dealt    
    end

    private
    
    def build_deck
      make_standard_deck
      modify_deck
    end
        
    def make_standard_deck
      @cards = []
      Card::SUITS.keys.each do |suit|
        Card::FACES.keys.each do |face|
          @cards << Card.parse(face + suit)
        end
      end
    end
    
    def modify_deck
      case @deck_type
      when :deuces_wild
        set_deuces_to_wild
      when :one_joker
        add_one_joker
      when :two_jokers
        add_two_jokers
      end
    end

    def set_deuces_to_wild
      @cards.select { |card| card.face == 2 }.each(&:wild!)
    end
    
    def add_one_joker
      @cards << Joker.new
    end
    
    def add_two_jokers
      2.times { add_one_joker }
    end

  end
end


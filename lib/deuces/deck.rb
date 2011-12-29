module Deuces
  class Deck
    
    attr_accessor :deck_type, :cards
    def initialize(deck_type = 'S')
      @deck_type = deck_type
      build_deck
      shuffle!
    end
    
    def shuffle!
      @cards.shuffle!
    end
    
    def build_deck
      make_standard_deck
      case deck_type
      when 'D'
        set_deuces_to_wild
      when 'J'
        add_one_joker
      when 'JJ'
        add_two_jokers
      end
    end
    
    def make_standard_deck
      @cards = []
      Card::SUITS.keys.each do |suit|
        Card::FACES.keys.each do |face|
          @cards << Card.parse(face + suit)
        end
      end
    end
    
    def set_deuces_to_wild
      @cards.select { |card| card.face == 2 }.each { |card| card.wild! }
    end
    
    def add_one_joker
      @cards << Card.parse("JO")
    end
    
    def add_two_jokers
      2.times { add_one_joker }
    end
    
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
  end

end


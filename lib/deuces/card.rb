module Deuces
  
  class Card
    FACES = {'2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9, 'T' => 10,
      'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14}
    SUITS = {'C' => 1, 'D' => 2, 'H' => 3, 'S' => 4}
    
    attr_accessor :face, :suit
    

    # Card.parse accepts either a single string code or a Card object.
    # When a card object is received, that card object is returned.
    # The string code is a face code, a suit code, and any third
    # character is interpreted as making the card wild.
    def self.parse(code)
      return code if code.is_a?(Card)
      face, suit, wild = code.split(//)
      if code == "JO" || code == "JOW"
        Joker.new
      else
        Card.new(FACES[face], SUITS[suit], wild ? true : false)
      end
    end
    
    def initialize(face, suit, wild = false)
      @face, @suit, @wild = face, suit, wild
    end
    
    def wild?
      @wild
    end

    def wild!
      @wild = true
    end
        
    def joker?
      false
    end
    
    def to_s
      FACES.invert[face] + SUITS.invert[suit] + "#{wild? ? '(W)' : nil}"
    end

  end
end

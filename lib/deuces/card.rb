module Deuces
  
  class Card
    FACES = {'2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9, 'T' => 10,
      'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14}
    SUITS = {'C' => 1, 'D' => 2, 'H' => 3, 'S' => 4}
    
    attr_accessor :face, :suit
    
    def self.parse(code, wild = false)
      if code == "JO"
        Joker.new
      else
        face = FACES[code[0]]
        suit = SUITS[code[1]]
        Card.new(face, suit, wild)
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
      FACES.invert[face] + SUITS.invert[suit]
    end

  end
end

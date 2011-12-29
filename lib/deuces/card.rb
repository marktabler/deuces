module Deuces
  
  class Card
    FACE_CODES = {'2' => 2, '3' => 3, '4' => 4, '5' => 5, '6' => 6, '7' => 7, '8' => 8, '9' => 9, 'T' => 10,
      'J' => 11, 'Q' => 12, 'K' => 13, 'A' => 14}
    SUIT_CODES = {'C' => 1, 'D' => 2, 'H' => 3, 'S' => 4}
    FACES = ['2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'A']
    SUITS = ['C', 'D', 'H', 'S']
    
    attr_accessor :face, :suit, :wild
    
    def initialize(code, wild = false)
      if code == "JO"
        @face = 1
        @wild = true
      else
        @face = FACE_CODES[code[0]]
        @suit = SUIT_CODES[code[1]]
        @wild = wild
      end
    end
    
    def wild?
      wild
    end
    
    def joker?
      face == 1
    end
    
    def to_s
      if joker?
        "JO"
      else
        FACES[face - 2] + SUITS[suit - 1]
      end
    end

  end
end

class Card
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

module Deuces

  class Joker < Card

    def initialize
      super(nil, nil, true)
    end

    def joker?
      true
    end

    def wild?
      true
    end
        
    def to_s
      "JO"
    end

  end
end

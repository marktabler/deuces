module Deuces
  module Scoring

    SCORES = {
      "Royal Flush" => :natural_royal?,
      "Four Deuces" => :four_deuces?,
      "Royal Flush w/ Wild" => :wild_royal?,
      "Five of a Kind" => :five_of_a_kind?,
      "Straight Flush" => :straight_flush?,
      "Four of a Kind" => :four_of_a_kind?,
      "Full House" => :full_house?,
      "Flush" => :flush?,
      "Straight" => :straight?,
      "Three of a Kind" => :three_of_a_kind?,
      "Two Pair" => :two_pair?,
      "Pair" => :pair?
    }

    # Returns the best possible score for the hand. Where individual
    # score methods will return true if the criteria are met (e.g.,
    # 22333 will return true for #two_pair? and for #full_house?),
    # #score returns a string representing the best interpretation
    # of a hand's score. This is what would determine a payout amount
    # on an actual Deuces Wild machine.
    def score
      SCORES.each do |name, evaluation|
        return name if send(evaluation)
      end
      "High Card"
    end
    
    # This is not a valid hand scoring, however, knowing about the
    # presence or absence of a natural pair makes certain evaluations easier.
    def natural_pair?
      sh.map(&:face).uniq.size < sh.size
    end

    # Checks to see if only one suit is represented across non-wild cards.
    def flush?
      sh.map(&:suit).uniq.size == 1
    end
    
    # This works for any number of wild cards. If there are 0 wilds,
    # the value of the last minus the value of the first will always be 4.
    # With 1 wild, the number can be 3 or 4, and the wild will make up the
    # difference in all of those cases. The key is that this is only true when
    # there are no duplicate cards in the hand, hence, ! natural_pair?.
    def straight?
      sh.last.face - sh.first.face <= 4 && ! natural_pair?
    end

    # Checks for a royal flush with no wild cards present. This is
    # important because most Deuces Wild games pay out significantly
    # less for a wild royal than a natural royal.
    def natural_royal?
      sh[0].face == 10 && flush? && straight? && wilds == 0
    end

    # Technically, this is any four wilds, but the only "game"
    # supported that has four wilds is Deuces Wild.
    def four_deuces?
      wilds == 4
    end
    
    # If wilds is not greater than or equal to 1, techncially it's not
    # a wild royal - it's strictly a natural royal.
    def wild_royal?
      sh[0].face - wilds <= 10 && flush? && straight? && wilds >= 1
    end

    # Makes sure that only one face value is represented across
    # non-wild cards
    def five_of_a_kind?
      sh.first.face == sh.last.face
    end

    # Calls #straight and #flush and verifies both are true.
    def straight_flush?
      straight? && flush?
    end
    
    # In four of a kind, there's room for one unmatching card. If we match
    # the second card to the last, or the first card to the second to
    # last, then the wilds will account for everything else.
    def four_of_a_kind?
      return true if wilds >= 3
      sh[1].face == sh.last.face || sh.first.face == sh[sh.size - 2].face
    end
    
    # Can't check two_pair && three_of_a_kind, because 3345W will evaluate
    # as three of a kind (33w) and two pair (335w) but is not a full house.
    def full_house?
      case wilds
      when 3, 4, 5
        true
      when 2
        natural_pair?
      when 1
        # A natural two pair or a natural three of a kind, plus a wild,
        # is sufficient to prove a full house.
        (sh[0].face == sh[1].face && sh[2].face == sh[3].face) ||
          (sh[0].face == sh[2].face || sh[1].face == sh[3].face)
      when 0
        # A natural full house is a pair and three of a kind. First,
        # check for two pairs, then see if one of those pairs can be
        # upgraded to three of a kind.
        (sh[0].face == sh[1].face && sh[3].face == sh[4].face) &&
          (sh[1].face == sh[2].face || sh[2].face == sh[3].face)
      end
    end

    # Checks for three-of-a-kind, taking wilds into account.
    def three_of_a_kind?
      case wilds
      when 2, 3, 4, 5
        true
      when 1
        natural_pair?
      when 0
        sh[0].face == sh[2].face ||
          sh[1].face == sh[3].face ||
          sh[2].face == sh[4].face
      end
    end

    # Checks for two pair, taking wilds into account.
    def two_pair?
      case wilds
      when 2, 3, 4, 5
        true
      when 1
        natural_pair?
      when 0
        # If there are not three of a kind, and the five-card hand only contains
        # three unique face values, then there must be two pairs.
        # Also true if there is a full house. Finally, technically, four
        # of a kind is also two pairs.
        (!three_of_a_kind? && sh.map(&:face).uniq.size == 3) || full_house? || four_of_a_kind?
      end
    end

    # Checks for any natural pair or any wild card.
    def pair?
      wilds >= 1 || natural_pair?
    end

    private
    
    def reset_scorable_hand
      @scorable_hand = nil
    end
    
    # For scoring evaluation, the wilds are removed from the hand entirely.
    def sh
      @scorable_hand ||= cards.reject{|card| card.wild?}.sort_by{|card| card.face}
    end
    
    # A hand is always five cards large; if the scorable hand
    # is less than five cards, the missing cards represent wilds
    def wilds
      5 - sh.size
    end
    
  end
end

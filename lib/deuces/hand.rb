class Hand

  attr_accessor :cards

  def initialize(deck)
    @cards = deck.deal(5)
  end

  def to_s
    @cards.map(&:to_s).join(' ')
  end

  #Discard and draw are meant to model typical play options. Discarding is
  #done from the top of the array down so that deleted cards don't change
  #the indexes of cards we're still discarding.
  def discard(indexes)
    [indexes].flatten.sort.reverse.each do |card_index|
      @cards.delete_at(card_index)
    end
  end

  def draw(deck, count = 1)
    @cards = @cards + deck.deal(count)
  end

  #Stuffing allows us to put specific cards into a hand. It doesn't support
  #setting the wild attribute on a card directly, but it does support stuffing
  #jokers which are always wild.
  def stuff(cards)
    [cards].flatten.each do |card_code|
      @cards << Card.new(card_code)
    end
  end
      
  def score
    set_scorable_hand
    return "Royal Flush" if natural_royal?
    return "Four Deuces" if four_deuces?
    return "Royal Flush w/ Wild" if wild_royal?
    return "Five of a Kind" if five_of_a_kind?
    return "Straight Flush" if straight_flush?
    return "Four of a Kind" if four_of_a_kind?
    return "Full House" if full_house?
    return "Flush" if flush?
    return "Straight" if straight?
    return "Three of a Kind" if three_of_a_kind?
    return "Two Pair" if two_pair?
    return "Pair" if pair?
    "High Card"
  end
  
  #wilds are discarded from a hand for scoring purposes;
  #it makes the logic much easier
  def set_scorable_hand
    @scorable_hand = cards.reject{|card| card.wild?}.sort_by{|card| card.face}
  end

  #shorthand to make the typing easier
  def sh
    @scorable_hand || set_scorable_hand
  end
  
  #a hand is always five cards large; if the scorable hand
  #is less than five cards, the missing cards represent wilds
  def wilds
    5 - sh.size
  end

  #this is not a valid hand scoring, however, knowing about the
  #presence or absence of a natural pair makes certain evaluations easier.
  def natural_pair?
    sh.map(&:face).uniq.size < sh.size
  end
  
  def flush?
    sh.map(&:suit).uniq.size == 1
  end

  #This works for any number of wild cards. If there are 0 wilds,
  #the value of the last minus the value of the first will always be 4.
  #With 1 wild, the number can be 3 or 4, and the wild will make up the
  #difference in all of those cases. The key is that this is only true when
  #there are no duplicate cards in the hand, hence, ! natural_pair?.
  def straight?
    sh.last.face - sh.first.face <= 4 && ! natural_pair?
  end

  def natural_royal?
    sh[0].face == 10 && flush? && straight? && wilds == 0
  end

  def four_deuces?
    wilds == 4
  end
  
  #If wilds is not greater than or equal to 1, techncially it's not
  # a wild royal - it's strictly a natural royal.
  def wild_royal?
    sh[0].face - wilds <= 10 && flush? && straight? && wilds >= 1
  end

  def five_of_a_kind?
    sh.first.face == sh.last.face
  end
  
  def straight_flush?
    straight? && flush?
  end

  #In four of a kind, there's room for one unmatching card. If we match
  #the second card to the last, or the first card to the second to
  #last, then the wilds will account for everything else.
  def four_of_a_kind?
    return true if wilds >= 3
    sh[1].face == sh.last.face || sh.first.face == sh[sh.size - 2].face
  end

  #Can't check two_pair && three_of_a_kind, because 3345W will evaluate
  #as three of a kind (33w) and two pair (335w) but is not a full house.
  def full_house?
    case wilds
    when 3, 4, 5

      true
    when 2
      natural_pair?
    when 1
    #A natural two pair or a natural three of a kind, plus a wild,
    #is sufficient to prove a full house.
      (sh[0].face == sh[1].face && sh[2].face == sh[3].face) ||
        (sh[0].face == sh[2].face || sh[1].face == sh[3].face)
    when 0
      #a natural full house is a pair and three of a kind. First,
      #check for two pairs, then see if one of those pairs can be
      #upgraded to three of a kind.
      (sh[0].face == sh[1].face && sh[3].face == sh[4].face) &&
        (sh[1].face == sh[2].face || sh[2].face == sh[3].face)
    end
  end

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
  
  def two_pair?
    case wilds
    when 2, 3, 4, 5
      true
    when 1
      natural_pair?
    when 0
      #If there are not three of a kind, and the five-card hand only contains
      #two or three unique face values, then there must be two pairs.
      #Also true if there is a full house.
      (!three_of_a_kind? && sh.map(&:face).uniq.size == 3) || full_house?
    end
  end

  def pair?
    wilds >= 1 || natural_pair?
  end
  
end

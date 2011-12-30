require 'minitest/autorun'
require 'deuces'
class TestHand < MiniTest::Unit::TestCase

  def setup
    @deck = Deuces::Deck.new('S')
  end

  def test_new_hand_from_deck
    @hand = Deuces::Hand.new(@deck)
    assert_equal 5, @hand.size
  end

  def test_new_hand_from_parse
    @hand = Deuces::Hand.parse("AH KH QH JH TH")
    assert_equal 5, @hand.size
  end

  def test_discard
    @hand = Deuces::Hand.parse("AH KH QH JH TH")
    @hand.discard([0, 2, 4])
    assert_equal 2, @hand.size
    assert_equal "KH JH", @hand.to_s
  end

  def test_draw
    @hand = Deuces::Hand.parse("AH KH")
    @hand.draw(@deck, 3)
    assert_equal 5, @hand.size
  end
  
  def test_full_house_beats_two_pair
    @hand = Deuces::Hand.parse("2H 2C 3C 3H 3S")
    assert @hand.two_pair?
    assert @hand.three_of_a_kind?
    assert @hand.full_house?
    assert_equal "Full House", @hand.score
  end

  def test_wild_royal_beats_four_of_a_kind
    @hand = Deuces::Hand.parse("2HW 2CW 2DW AH QH")
    assert @hand.wild_royal?
    assert @hand.four_of_a_kind?
    assert @hand.full_house?
    assert @hand.three_of_a_kind?
    assert @hand.flush?
    assert @hand.straight?
    assert !@hand.natural_royal?
    assert_equal "Royal Flush w/ Wild", @hand.score
  end

end

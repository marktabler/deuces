require 'minitest/autorun'
require 'deuces'

class TestCard < MiniTest::Unit::TestCase

  def test_wild_parsing
    @card = Deuces::Card.parse('2HW')
    assert @card.wild?
  end

  def test_joker_parsing
    @card = Deuces::Card.parse('JO')
    assert @card.wild?
    assert @card.joker?
  end

  def test_non_wild_deuce_parsing
    @card = Deuces::Card.parse('2C')
    assert !@card.wild?
    assert_equal 2, @card.face
    assert_equal 1, @card.suit
  end

  def test_parse_non_deuce
    @card = Deuces::Card.parse('8S')
    assert_equal "8S", @card.to_s
    assert_equal @card.suit, Deuces::Card::SUITS['S']
    assert_equal @card.face, Deuces::Card::FACES['8']
    assert_equal @card.face, 8
  end

  def test_parse_accepts_card_object
    @card = Deuces::Card.new(5, 2)
    assert_equal @card, Deuces::Card.parse(@card)
  end
  
end

require 'minitest/autorun'
require 'deuces'

class TestCard < MiniTest::Unit::TestCase

  def test_wilds
    @wild_card = Deuces::Card.parse('2HW')
    @not_wild_card = Deuces::Card.parse('2C')
    @joker = Deuces::Card.parse('JO')
    assert @wild_card.wild?
    assert !@not_wild_card.wild?
    assert @joker.wild?
  end

  def test_parse
    @ace_of_hearts = Deuces::Card.parse('AH')
    assert_equal "AH", @ace_of_hearts.to_s
    assert_equal @ace_of_hearts.suit, Deuces::Card::SUITS['H']
    assert_equal @ace_of_hearts.face, Deuces::Card::FACES['A']
    assert_equal @ace_of_hearts.face, 14

    @eight_of_spades = Deuces::Card.parse('8S')
    assert_equal "8S", @eight_of_spades.to_s
    assert_equal @eight_of_spades.suit, Deuces::Card::SUITS['S']
    assert_equal @eight_of_spades.face, Deuces::Card::FACES['8']
    assert_equal @eight_of_spades.face, 8

    assert_equal @eight_of_spades, Deuces::Card.parse(@eight_of_spades)
  end
end

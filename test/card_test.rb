require 'minitest/autorun'
require 'deuces'

class TestCard < MiniTest::Unit::TestCase

  def test_wilds
    @wild_card = Deuces::Card.new('2H', true)
    @not_wild_card = Deuces::Card.new('2C')
    @joker = Deuces::Card.new('JO')
    assert @wild_card.wild?
    assert !@not_wild_card.wild?
    assert @joker.wild?
  end

  def test_codes
    @ace_of_hearts = Deuces::Card.new('AH')
    assert_equal "AH", @ace_of_hearts.to_s
    assert_equal @ace_of_hearts.suit, Deuces::Card::SUIT_CODES['H']
    assert_equal @ace_of_hearts.face, Deuces::Card::FACE_CODES['A']
    assert_equal @ace_of_hearts.face, 14

    @eight_of_spades = Deuces::Card.new('8S')
    assert_equal "8S", @eight_of_spades.to_s
    assert_equal @eight_of_spades.suit, Deuces::Card::SUIT_CODES['S']
    assert_equal @eight_of_spades.face, Deuces::Card::FACE_CODES['8']
    assert_equal @eight_of_spades.face, 8
  end
end

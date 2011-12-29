$LOAD_PATH.unshift 'lib'
require 'minitest/autorun'
require 'lib/deuces'

class TestCard < MiniTest::Unit::TestCase
  def setup
  end

  def test_wild
    @wild_card = Deuces::Card.new('2H', true)
    @not_wild_card = Deuces::Card.new('2C')
    @joker = Deuces::Card.new('JO')
    assert @wild_card.wild?
    assert !@not_wild_card.wild?
    assert @joker.wild?
  end

  def test_codes
  end
end

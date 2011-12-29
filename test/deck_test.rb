require 'minitest/autorun'
require 'deuces'
class TestDeck < MiniTest::Unit::TestCase

  def setup
  end

  def test_deck_build
    @standard_deck = Deuces::Deck.new('S')
    assert @standard_deck.cards.size == 52
    assert @standard_deck.cards.map(&:suit).uniq.size == 4
    assert @standard_deck.cards.map(&:face).uniq.size == 13
    assert @standard_deck.cards.compact.uniq == @standard_deck.cards
    assert !@standard_deck.cards.map(&:wild?).any?
  end

  def test_deuces_build
    @deuces_deck = Deuces::Deck.new('D')
    assert @deuces_deck.cards.size == 52
    assert @deuces_deck.cards.map(&:suit).uniq.size == 4
    assert @deuces_deck.cards.map(&:face).uniq.size == 13
    assert @deuces_deck.cards.compact.uniq == @deuces_deck.cards
    assert @deuces_deck.cards.select { |card| card.wild? }.size == 4
  end

  def test_joker_build
    @two_jokers_deck = Deuces::Deck.new('JJ')
    assert @two_jokers_deck.cards.size == 54
    assert @two_jokers_deck.cards.compact.uniq == @two_jokers_deck.cards
    assert @two_jokers_deck.cards.select { |card| card.wild? }.size == 2
  end

  def test_deal_with_reshuffle
    @deck = Deuces::Deck.new('S')
    toss = @deck.deal(50)
    @hand = @deck.deal(5)
    assert_equal 5, @hand.size
  end

  def test_deal_without_reshuffle

  end
  
end

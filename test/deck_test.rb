require 'minitest/autorun'
require 'deuces'
class TestDeck < MiniTest::Unit::TestCase

  def setup
  end

  def test_standard_deck_build
    @standard_deck = Deuces::Deck.new(:standard)
    assert_equal 52, @standard_deck.cards.size
    assert_equal 4, @standard_deck.cards.map(&:suit).uniq.size
    assert_equal 13, @standard_deck.cards.map(&:face).uniq.size
    assert !@standard_deck.cards.map(&:wild?).any?
  end

  def test_deuces_deck_build
    @deuces_deck = Deuces::Deck.new(:deuces_wild)
    assert_equal 52, @deuces_deck.cards.size
    assert_equal 4, @deuces_deck.cards.map(&:suit).uniq.size
    assert_equal 13, @deuces_deck.cards.map(&:face).uniq.size
    assert @deuces_deck.cards.select { |card| card.wild? }.size == 4
  end

  def test_joker_deck_build
    @two_jokers_deck = Deuces::Deck.new(:two_jokers)
    assert_equal 54, @two_jokers_deck.cards.size
    assert_equal 2, @two_jokers_deck.cards.select { |card| card.wild? }.size
  end

  def test_deal_with_reshuffle_continues_after_deck_out
    @deck = Deuces::Deck.new(:standard)
    toss = @deck.deal(50)
    @hand = @deck.deal(5)
    assert_equal 5, @hand.size
  end

  def test_deal_without_reshuffle_raises_error_on_deck_out
    @deck = Deuces::Deck.new(:standard)
    toss = @deck.deal(50)
    assert_raises(RuntimeError) { @hand = @deck.deal(5, false) }
  end

  
end

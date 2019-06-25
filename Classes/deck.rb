class Deck
  require_relative 'card'

  attr_reader :suits, :rangs, :cards

  def initialize
    @cards = []

    Card::RANGS.each do |rang|
      Card::SUITS.each do |suit|
        card = Card.new(rang[0], rang[1], suit)
        @cards << card
      end
    end
  end

  def remove_card(card)
    @cards.delete(card)
  end
end

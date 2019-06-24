class Deck
  attr_reader :suits, :rangs, :deck

  def initialize
    spades = "\u2660".encode('utf-8')
    clubs = "\u2663".encode('utf-8')
    hearts = "\u2665".encode('utf-8')
    diams = "\u2666".encode('utf-8')

    @suits = [ spades, clubs, hearts, diams ]

    @rangs = [ ['2', 2], ['3', 3], ['4', 4],
               ['5', 5], ['6', 6], ['7', 7],
               ['8', 8], ['9', 9], ['10', 10],
               ['J', 10], ['Q', 10], ['K', 10],
               ['A', 11] ]

    rangs.each do |rang|
      suits.each do |suit|
        new_deck(rang[0], rang[1], suit)
      end
    end
  end

  def new_deck(rang, points, suit)
    @deck ||= []
    local_hash = {
      rang: rang,
      points: points,
      suit: suit
    }
    @deck << local_hash
  end

  def remove_card(card)
    @deck.delete(card)
  end
end

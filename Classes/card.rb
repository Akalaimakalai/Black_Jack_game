class Card
  attr_reader :rang, :points, :suit

  spades = "\u2660".encode('utf-8')
  clubs = "\u2663".encode('utf-8')
  hearts = "\u2665".encode('utf-8')
  diams = "\u2666".encode('utf-8')

  SUITS = [ spades, clubs, hearts, diams ]

  RANGS = [ ['2', 2], ['3', 3], ['4', 4],
            ['5', 5], ['6', 6], ['7', 7],
            ['8', 8], ['9', 9], ['10', 10],
            ['J', 10], ['Q', 10], ['K', 10],
            ['A', 11] ]

  def initialize(rang, points, suit)
    @rang = rang
    @points = points
    @suit = suit
  end
end

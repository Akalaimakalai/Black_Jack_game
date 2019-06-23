class Player
  require_relative 'deck'

  attr_reader :name, :card

  def initialize(name)
    @name = name
    @hand = []
  end

  def show_hand
    print "У #{@name} на руке:"
    @hand.each {|i| print "#{i[:rang]}#{i[:suit]} " }
    puts ''
  end

  def draw_card(plying_deck)
    @card = plying_deck.deck.sample
    puts "#{@name} вытянул из колоды: #{@card[:rang]}#{@card[:suit]}"
    @hand << @card
    plying_deck.remove_card(@card)
  end
end

player1 = Player.new('GriwaDK')
deck1 = Deck.new

player1.draw_card(deck1)
player1.draw_card(deck1)
player1.draw_card(deck1)
player1.draw_card(deck1)

player1.show_hand

class Player
  require_relative 'deck'

  attr_accessor :bank, :hand
  attr_reader :name, :card

  def initialize(name, bank = 100)
    @name = name
    @hand = []
    @bank = bank
  end

  def show_hand
    print "У #{@name} на руке:"
    @hand.each {|i| print "#{i[:rang]}#{i[:suit]} " }
    puts ''
  end

  def show_bank
    puts "У вас насчету: #{@bank}$"
  end

  def draw_card(plying_deck)
    @card = plying_deck.deck.sample
    puts "#{@name} вытянул из колоды: #{@card[:rang]}#{@card[:suit]}"
    @hand << @card
    plying_deck.remove_card(@card)
  end
end

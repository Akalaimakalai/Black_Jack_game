class Interface
  require_relative 'deck'
  require_relative 'player'

  attr_accessor :prize, :score
  attr_reader :player, :deck

  def initialize
    @prize = 0
  end

  def start
    puts 'Доброго вечера и приятной игры!'
    puts 'Введите имя игрока:'
    name = gets.chomp
    @player = Player.new(name)
    new_round
  end

  def new_round
    sleep 1
    puts 'Колода перетасована.'
    @deck = Deck.new

    sleep 1
    puts 'Ставки сделаны.'
    @player.bank -= 10
    @prize = 10

    sleep 1
    puts "На кону: #{@prize}$"

    sleep 1
    puts 'Карты розданны!'
    sleep 1
    player.hand = []
    player.draw_card(@deck)
    player.draw_card(@deck)
    player.show_hand
    puts "Сумма очков: #{count_points(@player.hand)}"

    sleep 1
    round_options
  end

  def count_points(hand)
    @score = 0
    hand.each { |card| @score += card[:points] }
    return @score if @score <= 21
    hand.each do |card|
      if card[:points] == 11
        @score -= 10
        return @score if @score <= 21
      end
    end
    @score
  end

  def round_options
    options = { 1 => 'pass', 2 => 'pick_a_card', 3 => 'open_hand' }

    puts 'Что будете делать?'
    puts '1 - пропустить ход.'
    puts '2 - взять ещё одну карту'
    puts '3 - открыть карты'
    choice = gets.chomp.to_i

    send(options[choice]) if options[choice]

    if @player.hand.length < 3
      round_options
    else
      open_hand
    end
  end

  def pick_a_card
    sleep 1
    player.draw_card(@deck)
    player.show_hand
    puts "Сумма очков: #{count_points(@player.hand)}"
  end

  def open_hand
    if score > 21
      puts 'Вы проиграли'
      @player.show_bank
      sleep 1
      puts 'Зато мы выиграли!'
      continue
    else
      puts 'А тут нужно считать'
      @player.show_bank
      continue
    end
  end

  def continue
    if @player.bank != 0
      puts 'Желаете сыграть ещё?'
      puts '1 - да'
      puts '2 - с меня на сегодня хватит'
      choice = gets.chomp.to_i

      return new_round if choice == 1
      exit if choice == 2
      continue
    else
      @player.show_bank
      puts 'Нищим здесь не подают'
      exit
    end
  end
end

game = Interface.new
game.start

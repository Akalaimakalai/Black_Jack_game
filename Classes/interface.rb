class Interface
  require_relative '../Modules/game'

  include Game

  attr_accessor :prize, :score
  attr_reader :player, :deck, :diler

  def start
    puts 'Доброго вечера и приятной игры!'
    puts 'Введите имя игрока:'
    name = gets.chomp
    preparation(name)
    new_round
  end

  def new_round
    sleep 1
    puts 'Колода перетасована.'

    sleep 1
    puts 'Ставки сделаны.'
    

    sleep 1
    puts "На кону: #{@prize}$"

    sleep 1
    puts 'Карты розданны!'
    sleep 1
    
    bets

    show_hand(@player)
    puts "Сумма очков: #{count_points(@player.hand)}"

    sleep 1
    round_options
  end

  def card_pull
    2.times do
      @player.draw_card(@deck)
      puts "#{@player.name} вытянул из колоды: #{@player.card.rang}#{@player.card.suit}"
      sleep 1

      diler.draw_card(@deck)
      puts "#{@diler.name} вытянул из колоды: *"
      sleep 1
    end
  end

  def round_options
    options = { 1 => 'pass', 2 => 'pick_a_card', 3 => 'open_hand' }

    open_hand if @player.hand.length >= 3

    puts 'Что будете делать?'
    puts '1 - пропустить ход.'
    puts '2 - взять ещё одну карту'
    puts '3 - открыть карты'
    choice = gets.chomp.to_i

    if options[choice]
      send(options[choice])
    else
      round_options
    end
  end

  def auto_turn
    if @diler.hand.length < 3
      puts 'Дилер спасовал'
    else
      puts 'Дилер добрал ещё одну карту'
    end
    round_options
  end

  def pick_a_card
    sleep 1
    player.draw_card(@deck)
    puts "#{@player.name} вытянул из колоды: #{@player.card.rang}#{@player.card.suit}"
    show_hand(@player)
    puts "Сумма очков: #{count_points(@player.hand)}"
    open_hand if @diler.hand.length == 3
    pass
  end

  def open_hand
    sleep 1
    puts 'Вскрываемся!'

    show_hand(@diler)
    show_hand(@player)
    sum_result
  end

  def show_hand(person)
    print "У #{person.name} на руке:"
    person.hand.each {|card| print "#{card.rang}#{card.suit} " }
    puts ''
  end

  def show_points
    puts "У Дилера #{@dil_points} очков, а у вас #{@player_points}."
  end

  def win
    puts 'Вы выиграли!'
    sum_win
    puts "У вас на счету: #{@player.bank}"
    continue
  end

  def lose
    puts 'Вы проиграли'
    puts "У вас на счету: #{@player.bank}"
    sleep 1
    puts 'Зато мы выиграли!'
    sum_lose
    puts "У дилера: #{@diler.bank}"
    continue
  end

  def draw
    puts 'Ничья'
    sum_draw
    puts "У вас на счету: #{@player.bank}"
    continue
  end

  def continue
    if @diler.bank.zero?
      puts 'Заведение закрыто. Для вас навсегда.'
      exit
    elsif @player.bank.zero?
      puts "У вас на счету: #{@player.bank}"
      puts 'Нищим здесь не подают'
      exit
    else
      puts 'Желаете сыграть ещё?'
      puts '1 - да'
      puts '2 - с меня на сегодня хватит'
      choice = gets.chomp.to_i

      return new_round if choice == 1
      exit if choice == 2
      continue
    end
  end
end

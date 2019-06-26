class Interface
  attr_reader :player, :deck, :diler, :dil_points, :player_points

  def start
    puts 'Доброго вечера и приятной игры!'
    puts 'Введите имя игрока:'
    name = gets.chomp
    @game = Game.new(name)
    new_round
  end

  def new_round
    sleep 1
    puts 'Колода перетасована.'

    sleep 1
    puts 'Ставки сделаны.'

    sleep 1
    puts "На кону: #{@game.prize}$"

    sleep 1
    puts 'Карты розданны!'
    sleep 1

    @game.bets
    card_pull

    show_hand(@game.player)
    puts "Сумма очков: #{@game.count_points(@game.player.hand)}"

    sleep 1
    round_options
  end

  def card_pull
    2.times do
      @game.player.draw_card(@game.deck)
      puts "#{@game.player.name} взял из колоды: #{@game.player.card.rang}#{@game.player.card.suit}"
      sleep 1

      @game.diler.draw_card(@game.deck)
      puts "#{@game.diler.name} взял из колоды: *"
      sleep 1
    end
  end

  def round_options
    options = { 1 => 'pass', 2 => 'pick_a_card', 3 => 'open_hand' }

    open_hand if @game.player.hand.length >= 3

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

  def pass
    @dil_points = @game.count_points(@game.diler.hand)
    if @dil_points <= 17 && @game.diler.hand.length < 3
      @game.diler.draw_card(@game.deck)
      puts 'Дилер добрал ещё одну карту'
    else
      puts 'Дилер спасовал'
    end
    round_options
  end

  def pick_a_card
    sleep 1
    @game.player.draw_card(@game.deck)
    puts "#{@game.player.name} взял из колоды: #{@game.player.card.rang}#{@game.player.card.suit}"
    show_hand(@game.player)
    puts "Сумма очков: #{@game.count_points(@game.player.hand)}"
    open_hand if @game.diler.hand.length == 3
    pass
  end

  def open_hand
    sleep 1
    puts 'Вскрываемся!'

    show_hand(@game.diler)
    show_hand(@game.player)

    @dil_points = @game.count_points(@game.diler.hand)
    @player_points = @game.count_points(@game.player.hand)

    puts "У Дилера #{@dil_points} очков, а у вас #{@player_points}."

    send(@game.logic_count(@player_points, @dil_points))
  end

  def show_hand(person)
    print "У #{person.name} на руке:"
    person.hand.each {|card| print "#{card.rang}#{card.suit} " }
    puts ''
  end

  def win
    puts 'Вы выиграли!'
    @game.sum_win
    puts "У вас на счету: #{@game.player.bank}"
    continue
  end

  def lose
    puts 'Вы проиграли'
    puts "У вас на счету: #{@game.player.bank}"
    sleep 1
    puts 'Зато мы выиграли!'
    @game.sum_lose
    puts "У дилера: #{@game.diler.bank}"
    continue
  end

  def draw
    puts 'Ничья'
    @game.sum_draw
    puts "У вас на счету: #{@game.player.bank}"
    continue
  end

  def continue
    if @game.diler.bank.zero?
      puts 'Заведение закрыто. Для вас навсегда.'
      exit
    elsif @game.player.bank.zero?
      puts "У вас на счету: #{@game.player.bank}"
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

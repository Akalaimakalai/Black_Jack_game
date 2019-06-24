class Interface
  attr_accessor :prize, :score
  attr_reader :player, :deck, :diler

  def initialize
    @prize = 0
  end

  def start
    puts 'Доброго вечера и приятной игры!'
    puts 'Введите имя игрока:'
    name = gets.chomp
    @player = Player.new(name)
    @diler = Player.new('Diler')
    new_round
  end

  def new_round
    sleep 1
    puts 'Колода перетасована.'
    @deck = Deck.new

    sleep 1
    puts 'Ставки сделаны.'
    @player.bank -= 10
    @diler.bank -= 10
    @prize = 20

    sleep 1
    puts "На кону: #{@prize}$"

    sleep 1
    puts 'Карты розданны!'
    sleep 1
    player.hand = []
    diler.hand = []

    card_pull

    player.show_hand
    puts "Сумма очков: #{count_points(@player.hand)}"

    sleep 1
    round_options
  end

  def card_pull
    2.times do
      @player.draw_card(@deck)
      puts "#{@player.name} вытянул из колоды: #{@player.card[:rang]}#{@player.card[:suit]}"
      sleep 1

      diler.draw_card(@deck)
      puts "#{@diler.name} вытянул из колоды: *"
      sleep 1
    end
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

  def pass
    @dil_points = count_points(@diler.hand)

    if @dil_points >= 17
      puts 'Дилер пасует'
      round_options
    else
      puts 'Дилер добрал ещё одну карту'
      diler.draw_card(@deck)
      round_options
    end
  end

  def pick_a_card
    sleep 1
    player.draw_card(@deck)
    player.show_hand
    puts "Сумма очков: #{count_points(@player.hand)}"
    pass
  end

  def open_hand
    sleep 1
    puts 'Вскрываемся!'

    @diler.show_hand
    @player.show_hand
    @dil_points = count_points(@diler.hand)
    @player_points = count_points(@player.hand)

    puts "У Дилера #{@dil_points} очков, а у вас #{@player_points}."

    if (@dil_points > @player_points) || (@player_points > 21)
      lose
    elsif (@dil_points < @player_points) || (@dil_points > 21)
      win
    else
      draw
    end
    continue
  end

  def lose
    puts 'Вы проиграли'
    puts "У вас на счету: #{@player.bank}"
    sleep 1
    puts 'Зато мы выиграли!'
    @diler.bank += 20
    puts "У дилера: #{@diler.bank}"
  end

  def draw
    puts 'Ничья'
    @player.bank += 10
    @diler.bank += 10
    puts "У вас на счету: #{@player.bank}"
  end

  def win
    puts 'Вы выиграли!'
    @player.bank += 20
    puts "У вас на счету: #{@player.bank}"
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

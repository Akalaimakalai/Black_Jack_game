module Game
  def bets
    @player.bank -= 10
    @diler.bank -= 10
    @prize = 20
  end

  def count_points(hand)
    @score = 0
    hand.each { |card| @score += card.points }
    return @score if @score <= 21
    hand.each do |card|
      if card.points == 11
        @score -= 10
        return @score if @score <= 21
      end
    end
    @score
  end

  def pass
    @dil_points = count_points(@diler.hand)

    if @dil_points >= 17
      puts 'Дилер пасует'
    else
      puts 'Дилер добрал ещё одну карту'
      diler.draw_card(@deck)
    end
    round_options
  end

  def sum_result
    @dil_points = count_points(@diler.hand)
    @player_points = count_points(@player.hand)

    puts "У Дилера #{@dil_points} очков, а у вас #{@player_points}."

    return lose if @player_points > 21
    return win if @dil_points > 21

    if @dil_points > @player_points
      lose
    elsif @dil_points < @player_points
      win
    else
      draw
    end
  end

  def sum_win
    @player.bank += 20
  end

  def sum_lose
    @diler.bank += 20
  end

  def sum_draw
    @player.bank += 10
    @diler.bank += 10
  end
end

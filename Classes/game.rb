class Game
  attr_reader :player, :diler, :prize, :deck, :dil_points, :player_points

  def initialize(input)
    @player = Player.new(input)
    @diler = Player.new('Diler')
    @prize = 20
  end

  def bets
    @player.bank -= 10
    @diler.bank -= 10
    @deck = Deck.new
    player.hand = []
    diler.hand = []
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

  def logic_count(player_points, dil_points)
    return 'lose' if player_points > 21
    return 'win' if dil_points > 21

    if dil_points > player_points
      'lose'
    elsif dil_points < player_points
      'win'
    else
      'draw'
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

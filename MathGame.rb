class MathGame
  def initialize
    @players = []
    @current_player_index = 0
    @game_over = false
  end

  def add_player(player)
    @players << player
  end

  def current_player
    @players[@current_player_index]
  end

  def next_turn
    generate_question
    prompt_question
    validate_answer(gets.chomp.to_i)
    update_game_status
    switch_turns
  end

  require_relative 'Player'

  def generate_question
    @num1 = rand(1..20)
    @num2 = rand(1..20)
  end

  def prompt_question
    puts "#{current_player.name}: What is #{@num1} + #{@num2}?"
  end

  def validate_answer(answer)
    correct_answer = @num1 + @num2
    if answer == correct_answer
      current_player.increase_score
      puts "Correct! #{current_player.name} gets a point."
    else
      current_player.decrease_lives
      puts "Incorrect! #{current_player.name} loses a life."
    end
  end

  def update_game_status
    @game_over = @players.any? { |player| player.lives <= 0 }
  end

  def switch_turns
    @current_player_index = (@current_player_index + 1) % @players.length
  end

  def game_over_message
    if @players[0].score > @players[1].score
      winner = @players[0]
      difference = @players[0].score - @players[1].score
    elsif @players[1].score > @players[0].score
      winner = @players[1]
      difference = @players[1].score - @players[0].score
    else
      return "The game ended in a tie!"
    end

    "#{winner.name} wins by #{difference} points!"
  end

  def print_game_over_message
    puts "Game over!"
    puts game_over_message
  end

  def game_over?
    @game_over
  end

  def print_scores
    @players.each do |player|
      puts "#{player.name}: Score - #{player.score}, Lives - #{player.lives}"
    end
  end
end
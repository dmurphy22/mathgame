require_relative 'MathGame'

# Example usage:
player1 = Player.new("Player 1")
player2 = Player.new("Player 2")

game = MathGame.new
game.add_player(player1)
game.add_player(player2)

until game.game_over?
  game.next_turn
  game.print_scores
end

game.print_game_over_message
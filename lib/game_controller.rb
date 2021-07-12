require 'linked-list'

# The responsibility of GameController is to control the entire game, which includes:
# 1. Determining the order in which players will move.
# 2. Determining who will go next:
# 2.1. Whether the current player will be given another chance (in case of 6).
# 2.2. Whether the current player will skip the next move (in case of 1 twice).
# 3. Updating the state based on the rolled number.
class GameController
	attr_reader :game

	def initialize(n, game)
		@game = game
		@player_order = LinkedList::Conversions::List((1..n).to_a.shuffle)
		@skip_next_move = Array.new(n, false)
		@another_chance = Array.new(n, false)
		@prev_move_points = Array.new(n, 0)
	end

	# Returns the player number who will play next move...
	def next_player_no
		while @player_order.first && @skip_next_move[@player_order.first - 1] do
			@skip_next_move[@player_order.first - 1] = false
			@player_order.push(@player_order.first)
			@player_order.shift
		end
		@player_order.first
	end

	# Plays the next move as rolled number...
	def play_next_move(rolled_number)
		cur_player = next_player_no
		@another_chance[cur_player - 1] = false
		@player_order.shift

		completed_game = @game.add_score(cur_player, rolled_number)

		if !completed_game then
			if rolled_number == 6 then
				@another_chance[cur_player - 1] = true
				@player_order.unshift(cur_player)
			elsif rolled_number == 1 && @prev_move_points[cur_player - 1] == 1 then
				@skip_next_move[cur_player - 1] = true
				@player_order.push(cur_player)
			else
				@player_order.push(cur_player)
			end
		end

		@prev_move_points[cur_player - 1] = rolled_number
	end

	# Whether to skip the next move for player numbered player_no...
	def skip_next_move(player_no)
		@skip_next_move[player_no - 1]
	end

	# Whether to give another chance to player numbered player_no...
	def another_chance(player_no)
		@another_chance[player_no - 1]
	end
end
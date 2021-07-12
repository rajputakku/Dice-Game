require 'linked-list'

# The responsibility of Game is to store the entire state of the game, including
# 1. The ranking table of the players in sorted order
# 2. Updating the ranking table and the score of players when a move is made
class Game
	attr_reader :rank_table

	def initialize(players, target_score)
		@target_score = target_score
		@rank_table = LinkedList::List.new
		@player_nodes = Array.new(players.size)

		players.each_with_index do |player, player_no|
			player_node = LinkedList::Node.new(player)
			@rank_table << player_node
			@player_nodes[player_no] = player_node
		end
	end

	# Update game by incrementing score for player numbered `player_no` by `amount`
	# Returns whether the player has completed the game or not
	def add_score(player_no, amount)
		player_node = @player_nodes[player_no - 1]
		@rank_table.delete(player_node)
		player_node.data.add_score(amount)

		if player_node.data.score >= @target_score
			player_node.data.completed_game = true
		end

		rank = 1
		@rank_table.each_node do |node|
			if node.data.score < [player_node.data.score, @target_score].min then
				player_node.data.final_rank = rank
				@rank_table.insert_before_node(player_node, node)
				return player_node.data.completed_game
			end
			rank += 1
		end
		player_node.data.final_rank = rank
		@rank_table.push(player_node)
		return player_node.data.completed_game
	end
end
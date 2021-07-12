# Player is a model class to store the data for a particular player.
class Player
	# Name of the player
	attr_reader :name
	# Current score of the player
	attr_reader :score
	# Whether player has completed the game
	attr_accessor :completed_game
	# Final rank of the player. Can be invalid if the player has not completed the game yet...
	attr_accessor :final_rank

	def initialize(name)
		@name = name
		@score = 0
		@completed_game = false
	end

	def add_score(amount)
		@score += amount
	end
end
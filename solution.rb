require_relative 'lib/io_helper'
require_relative 'lib/player'
require_relative 'lib/game'
require_relative 'lib/game_controller'

begin
	$stdout.sync = true

	N = IOHelper.get_input_number("Enter N (number of players): ")
	M = IOHelper.get_input_number("Enter M (points to accumulate): ")

	players = Array.new(N)
	(0..N-1).to_a.each do |player_no|
		players[player_no] = Player.new("Player-#{player_no + 1}")
	end

	game = Game.new(players, M)
	gameController = GameController.new(N, game)

	while (player_no = gameController.next_player_no) do
		player = players[player_no - 1]
		IOHelper.get_and_validate_input("#{player.name} its your turn (press ‘r’ to roll the dice): ", "r")

		rolled_number = rand(1..6)
		puts "\nYou rolled #{rolled_number}.\n\n"

		gameController.play_next_move(rolled_number)
		IOHelper.print_ranks(game.rank_table)

		if player.completed_game then
			puts "Congratulations !! #{player.name}, you have completed the game. Your final rank is #{player.final_rank}\n\n"
		elsif gameController.skip_next_move(player_no) then
			puts "Oops, #{player.name} you have rolled 1 two times consecutively. As a penalty you'll skip next turn.\n\n"
		elsif gameController.another_chance(player_no) then
			puts "Yayy !! As you have rolled a 6, you'll get another chance to roll again."
		end
	end
	print "Game Over !!"
end
require_relative '../lib/game_controller'
require_relative '../lib/game'
require_relative '../lib/player'

RSpec.describe GameController do
	before(:each) do
		@game = spy("game")
		allow(@game).to receive(:add_score).and_return(false)
	end

	it "Test game controller give another chance" do
		game_controller = GameController.new(3, @game)
		player_no = game_controller.next_player_no
		game_controller.play_next_move(6)

		expect(game_controller.another_chance(player_no)).to eq(true)
		expect(game_controller.skip_next_move(player_no)).to eq(false)
		expect(game_controller.next_player_no).to eq(player_no)
		expect(@game).to have_received(:add_score).once
	end

	it "Test game controller skip next move" do
		game_controller = GameController.new(2, @game)
		first_player = game_controller.next_player_no
		game_controller.play_next_move(1)
		second_player = game_controller.next_player_no
		game_controller.play_next_move(4)
		game_controller.play_next_move(1)

		expect(game_controller.skip_next_move(first_player)).to eq(true)
		expect(game_controller.skip_next_move(second_player)).to eq(false)
		expect(game_controller.another_chance(first_player)).to eq(false)
		expect(game_controller.another_chance(second_player)).to eq(false)
		expect(game_controller.next_player_no).to eq(second_player)
		game_controller.play_next_move(4)
		expect(game_controller.next_player_no).to eq(second_player)
		game_controller.play_next_move(2)
		expect(game_controller.next_player_no).to eq(first_player)
		expect(@game).to have_received(:add_score).exactly(5).time
	end

	it "Test game controller give another chance when game completed" do
		allow(@game).to receive(:add_score).and_return(true)

		game_controller = GameController.new(3, @game)
		player_no = game_controller.next_player_no
		game_controller.play_next_move(6)

		expect(game_controller.another_chance(player_no)).to eq(false)
		expect(game_controller.skip_next_move(player_no)).to eq(false)
		expect(game_controller.next_player_no).not_to eq(player_no)
		expect(@game).to have_received(:add_score).once
	end

	it "Test game controller skip next move when game completed" do
		game_controller = GameController.new(2, @game)
		first_player = game_controller.next_player_no
		game_controller.play_next_move(1)
		second_player = game_controller.next_player_no
		game_controller.play_next_move(4)

		allow(@game).to receive(:add_score).and_return(true)
		game_controller.play_next_move(1)

		expect(game_controller.skip_next_move(first_player)).to eq(false)
		expect(game_controller.another_chance(first_player)).to eq(false)
		expect(game_controller.next_player_no).to eq(second_player)
		expect(@game).to have_received(:add_score).exactly(3).time
	end
end
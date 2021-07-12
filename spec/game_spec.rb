require_relative '../lib/game'
require_relative '../lib/player'

RSpec.describe Game do
	before(:each) do
		@players = Array.new(3)
		(0..2).to_a.each do |no|
			@players[no] = Player.new("player #{no}")
		end
	end

	it "Test new game without completion" do
		game = Game.new(@players, 30)
		expect(game.add_score(1, 6)).to eq(false)
		expect(game.add_score(2, 4)).to eq(false)
		expect(game.add_score(3, 5)).to eq(false)
		expect(game.add_score(1, 4)).to eq(false)

		expect(@players[0].score).to eq(10)
		expect(@players[1].score).to eq(4)
		expect(@players[2].score).to eq(5)
		(0..2).each do |i|
			expect(@players[i].completed_game).to eq(false)
		end
		expect(game.rank_table.to_a).to eq([@players[0], @players[2], @players[1]])
	end

	it "Test game partial completion" do
		game = Game.new(@players, 10)
		expect(game.add_score(1, 6)).to eq(false)
		expect(game.add_score(2, 6)).to eq(false)
		expect(game.add_score(2, 6)).to eq(true)
		expect(game.add_score(3, 4)).to eq(false)

		expect(@players[0].score).to eq(6)
		expect(@players[1].score).to eq(12)
		expect(@players[2].score).to eq(4)
		expect(@players[0].completed_game).to eq(false)
		expect(@players[1].completed_game).to eq(true)
		expect(@players[2].completed_game).to eq(false)
		expect(@players[1].final_rank).to eq(1)
		expect(game.rank_table.to_a).to eq([@players[1], @players[0], @players[2]])
	end

	it "Test new game completion" do
		game = Game.new(@players, 10)
		expect(game.add_score(3, 6)).to eq(false)
		expect(game.add_score(2, 6)).to eq(false)
		expect(game.add_score(2, 6)).to eq(true)
		expect(game.add_score(1, 5)).to eq(false)
		expect(game.add_score(3, 4)).to eq(true)
		expect(game.add_score(1, 6)).to eq(true)

		expect(@players[0].score).to eq(11)
		expect(@players[1].score).to eq(12)
		expect(@players[2].score).to eq(10)
		(0..2).each do |i|
			expect(@players[i].completed_game).to eq(true)
		end
		expect(@players[0].final_rank).to eq(3)
		expect(@players[1].final_rank).to eq(1)
		expect(@players[2].final_rank).to eq(2)
		expect(game.rank_table.to_a).to eq([@players[1], @players[2], @players[0]])
	end
end
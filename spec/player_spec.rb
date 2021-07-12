require_relative '../lib/player'

RSpec.describe Player do
	name = "player name"

	it "Test create new player" do
		player = Player.new(name)
		expect(player.name).to eq(name)
		expect(player.score).to eq(0)
		expect(player.completed_game).to eq(false)
	end

	it "Test create new player and add score" do
		player = Player.new(name)
		10.times {player.add_score(3)}
		expect(player.score).to eq(30)
	end

	it "Test create new player and set rank" do
		player = Player.new(name)
		player.completed_game = true
		player.final_rank = 2
		expect(player.completed_game).to eq(true)
		expect(player.final_rank).to eq(2)
	end
end
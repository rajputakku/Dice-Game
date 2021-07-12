# Contains helper functions for I/O...
module IOHelper
	def self.get_input_number(prompt)
		print prompt
		while (num = gets.chomp.to_i) == 0 do
			print "Invalid value! " + prompt
		end
		return num
	end

	def self.get_and_validate_input(prompt, val)
		print prompt
		while !((inp = gets.chomp) == val) do
			print "Invalid value - #{inp}! " + prompt
		end
	end

	def self.print_ranks(rank_table)
		rank = 1
		puts "+------|----------|-------+"
		puts "| Rank |  Player  | Score |"
		puts "+------|----------|-------+"
		rank_table.each do |player|
			puts "|" + "#{rank}".center(6) + "|" + "#{player.name}".center(10) + "|" + "#{player.score}".center(7) + "|"
			puts "+------|----------|-------+"
			rank += 1
		end
		puts
	end
end
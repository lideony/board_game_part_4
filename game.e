class
	GAME

create
	make

feature {NONE} -- Initialization

	make (n: INTEGER)
			-- Create a game with `n' players.
		require
			n_in_bounds: Min_player_count <= n and n <= Max_player_count
		local
			i: INTEGER
			p: PLAYER
		do
			create board.make
			create players.make (1, n)
			from
				i := 1
			until
				i > players.count
			loop
				create p.make ("Player" + i.out, board)
				p.transfer (Initial_money)
				players [i] := p
				print (p.name + " joined the game.%N")
				i := i + 1
			end
			create die_1.roll
			create die_2.roll
		end

feature -- Basic operations

	play
			-- Start a game.
		local
			round, i: INTEGER
		do
			from
				winners := Void
				round := 1
				print ("The game begins.%N")
				print_board
			until
				winners /= Void
			loop
				print ("%NRound #" + round.out + "%N%N")
				from
					i := 1
				until
					winners /= Void or else i > players.count
				loop
					if players [i].rounds_in_jail = 0 then
						players [i].play (die_1, die_2)

					else
						-- player[i] in jail
						players [i].in_jail (die_1, die_2)
					end

				if players [i].position > board.Square_count then
						select_winners
				end
					i := i + 1
				end
				print_board
				round := round + 1
			end
		ensure
			has_winners: winners /= Void and then not winners.is_empty
			winners_are_players: across winners as w all players.has (w.item) end
		end

feature -- Constants

	Min_player_count: INTEGER = 2
			-- Minimum number of players.

	Max_player_count: INTEGER = 6
			-- Maximum number of players.

	Initial_money: INTEGER = 1500
			-- Initial amount of money of each player.

feature -- Access

	board: BOARD
			-- Board.

	players: V_ARRAY [PLAYER]
			-- Container for players.

	die_1: DIE
			-- The first die.

	die_2: DIE
			-- The second die.

	winners: V_LIST [PLAYER]
			-- Winners (Void if the game if not over yet).

feature {NONE} -- Implementation
	select_winners
			-- Put players with most money into `winners'.
		local
			i, max: INTEGER
		do
			create {V_LINKED_LIST [PLAYER]} winners
			from
				i := 1
			until
				i > players.count
			loop
				if players [i].money > max then
					max := players [i].money
					winners.wipe_out
					winners.extend_back (players [i])
				elseif players [i].money = max then
					winners.extend_back (players [i])
				end
				i := i + 1
			end
		ensure
			has_winners: winners /= Void and then not winners.is_empty
			winners_are_players: across winners as w all players.has (w.item) end
		end

 	print_board
			-- Output players positions on the board.
		local
			i, j: INTEGER
		do
			io.new_line
			print (board)
			io.new_line
			from
				i := 1
			until
				i > players.count
			loop
				from
					j := 1
				until
					j >= players [i].position
				loop
					print (" ")
					j := j + 1
				end
				print (i)
				io.new_line
				i := i + 1
			end
		end

invariant
	board_exists: board /= Void
	players_exist: players /= Void
	all_players_exist: across players as p all p.item /= Void end
	number_of_players_consistent: Min_player_count <= players.count and players.count <= Max_player_count
	dice_exist: die_1 /= Void and die_2 /= Void
end

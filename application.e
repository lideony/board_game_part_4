class
	APPLICATION

create
	make

feature

	make
			-- Launch the application.
		local
			count : INTEGER
			game: GAME
		do
			from
				count := {GAME}.Min_player_count - 1
			until
				{GAME}.Min_player_count <= count and count <= {GAME}.Max_player_count
			loop
				print ("Enter number of players between " + {GAME}.Min_player_count.out + " and " + {GAME}.Max_player_count.out + ": ")
				io.read_integer
				count := io.last_integer
			end

			create game.make (count)
			game.play
			if game.winners.count = 1 then
				print ("%NAnd the winner is: " + game.winners [1].name + "("+game.winners [1].money.out+" CHF)")
			else
				print ("%NAnd the winners are: ")
				across
					game.winners as c
				loop
					print (c.item.name + "("+c.item.money.out+" CHF)" + " ")
				end
			end
			print ("%N*** Game Over ***")
		end
end

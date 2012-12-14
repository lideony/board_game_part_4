class
	BOARD

inherit
	ANY
		redefine
			out
		end

create
	make

feature {NONE} -- Initialization
	make
			-- Initialize squares.
		local
			i: INTEGER
		do
			create squares.make (1, Square_count)

			squares [1] := create {SQUARE}
			squares [1].set_name("GO")
			squares [2] := create{PROPERTY}.make ("Duebendorfstrasse", 60, 2)
			squares [3] := create{PROPERTY}.make ("Winterthurerstrasse", 60, 4)
			squares [4] := create{INCOME_TAX}.make
			squares [5] := create{PROPERTY}.make ("Schwammendingerplatz", 80, 4)
			squares [6] := create{SQUARE}
			squares [6].set_name("IN JAIL / JUST VISITING")
			squares [7] := create{PROPERTY}.make ("Josefwiese", 100, 6)
			squares [8] := create{PROPERTY}.make ("Escher-Wyss-Platz", 120, 8)
			squares [9] := create{CHANCE}.make
			squares [10] := create{PROPERTY}.make ("Langstrasse",120,8)
			squares [11] := create{SQUARE}
			squares [11].set_name("FREE PARKING")
			squares [12] := create{PROPERTY}.make ("Schaffhauserplatz", 220,18)
			squares [13] := create {CHANCE}.make
			squares [14] := create{PROPERTY}.make ("Universitaetstrasse",260,22)
			squares [15] := create{PROPERTY}.make ("Ircherpark", 260,22)
			squares [16] := create{GO_TO_JAIL}.make
			squares [17] := create{PROPERTY}.make ("Bellevue", 320,28)
			squares [18] := create{PROPERTY}.make ("Niederdorf", 350,35)
			squares [19] := create {CHANCE}.make
			squares [20] := create{PROPERTY}.make ("Bahnhofstrasse", 400,50)

			from
				i:=1
			until
				i = square_count+1
			loop
				print ("["+i.out+"] "+squares[i].name + "%N")
				i := i+ 1
			end
		end

feature -- Access
	squares: V_ARRAY [SQUARE]
			-- Container for squares

feature -- Constants
	Square_count: INTEGER = 20
			-- Number of squares.

feature -- Output
	out: STRING
		do
			Result := ""
			across
				squares as c
			loop
				Result.append (c.item.out)
			end
		end

invariant
	squares_exists: squares /= Void
	squares_count_valid: squares.count = Square_count
end

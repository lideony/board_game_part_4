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
			from
				i := 1
			until
				i > Square_count
			loop
				if i \\ 10 = 5 then
					squares [i] := create {BAD_INVESTMENT_SQUARE}
				elseif i \\ 10 = 0 then
					squares [i] := create {LOTTERY_WIN_SQUARE}
				else
					squares [i] := create {SQUARE}
				end
				i := i + 1
			end
		end

feature -- Access
	squares: V_ARRAY [SQUARE]
			-- Container for squares

feature -- Constants
	Square_count: INTEGER = 40
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

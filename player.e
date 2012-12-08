class
	PLAYER

create
	make

feature {NONE} -- Initialization

	make (n: STRING; b: BOARD)
			-- Create a player with name `n' playing on board `b'.
		require
			name_exists: n /= Void and then not n.is_empty
			board_exists: b /= Void
		do
			name := n.twin
			board := b
			position := b.squares.lower
		ensure
			name_set: name ~ n
			board_set: board = b
			at_start: position = b.squares.lower
		end

feature -- Access
	name: STRING
			-- Player name.

	board: BOARD
			-- Board on which the player in playing.			

	position: INTEGER
			-- Current position on the board.

	money: INTEGER
			-- Amount of money.

feature -- Moving
	move (n: INTEGER)
			-- Advance `n' positions on the board.
		require
			not_beyond_start: n >= board.squares.lower - position
		do
			position := position + n
		ensure
			position_set: position = old position + n
		end

feature -- Money
	transfer (amount: INTEGER)
			-- Add `amount' to `money'.
		do
			money := (money + amount).max (0)
		ensure
			money_set: money = (old money + amount).max (0)
		end

feature -- Basic operations
	play (d1, d2: DIE)
			-- Play a turn with dice `d1', `d2'.
		require
			dice_exist: d1 /= Void and d2 /= Void
		do
			d1.roll
			d2.roll
			move (d1.face_value + d2.face_value)
			if position <= board.squares.upper then
				board.squares [position].affect (Current)
			end
			print (name + " rolled " + d1.face_value.out + " and " + d2.face_value.out +
				". Moves to " + position.out +
				". Now has " + money.out + " CHF.%N")
		end

invariant
	name_exists: name /= Void and then not name.is_empty
	board_exists: board /= Void
	position_valid: position >= board.squares.lower -- Token can go beyond the finish position, but not the start
	money_non_negative: money >= 0
end
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
	rounds_in_jail: INTEGER
			-- 0 if player is not in jail otherwise number of rounds in jail.

feature -- Moving

	move (n: INTEGER)
			-- Advance `n' positions on the board.
		require
			--	not_beyond_start: n >= board.squares.lower - position
		do
			position := position + n
		ensure
			position_set: position = old position + n
		end

	set_position (a_position: INTEGER)
		do
			position := a_position
		ensure
			position_set: position = a_position
		end

feature -- Money

	transfer (amount: INTEGER)
			-- Add `amount' to `money'.
		do
			money := (money + amount).max (0)
		ensure
			money_set: money = (old money + amount).max (0)
		end

	offer_property (a_property: PROPERTY)
		require
			property_already_owned: a_property.owner = void
		do
			if money >= a_property.price then
				print ("[-] Do you want to buy " + a_property.name + " for " + a_property.price.out + " CHF?" + PROMPT)
				Io.read_line
				if (Io.laststring.has ('y')) then
					buy_property (a_property)
				end
			else
				print ("[-] You don't have enough money to buy this property.%N")
			end
		end

	buy_property (a_property: PROPERTY)
		require
			property_unowned: a_property.owner = void
		do
				-- withdraw property price
			transfer (-a_property.price)
				-- set property owner
			a_property.set_owner (Current)
			print("[-] "+name + " bought "+a_property.name+ " for " + a_property.price.out + " CHF and has " +money.out+ " CHF left. %N")
		end

	pay_rent (a_property: PROPERTY)
		do
				-- Remove rent of property visitor
			transfer (-a_property.rent)
				-- Add rent to owner's money
			a_property.owner.transfer (a_property.rent)
			print ("[!] This property is owned by " + a_property.owner.name + ". You are paying " + a_property.rent.out + " CHF rent and have now " + money.out + "CHF left.%N")
		end

feature -- Basic operations

	play (d1, d2: DIE)
			-- Play a turn with dice `d1', `d2'.

		require
			dice_exist: d1 /= Void and d2 /= Void
		local
					go_money: STRING
		do
			d1.roll
			d2.roll
				-- Check if player did pass Go
			if position + d1.face_value + d2.face_value > 20 then
				money := money + 200
				move (d1.face_value + d2.face_value - 20)
				go_money := name + " passed Go and gains 200 CHF and has now " + money.out + " CHF.%N"
			else
				move (d1.face_value + d2.face_value)
			end
			print (name + " rolled " + d1.face_value.out + " and " + d2.face_value.out + ". Moves to " + board.squares [position].name + ".%N")
			print (go_money); go_money := ""
			board.squares [position].affect (Current)
		end

feature -- Jail

	set_round_in_jail(r: INTEGER)
	require
		r < 4
	do
		rounds_in_jail := r
		ensure
			rounds_in_jail = r
	end

	in_jail(d1,d2: DIE)
	-- Play a turn with dice `d1', `d2'.

	require
		dice_exist: d1 /= Void and d2 /= Void
	do
		if rounds_in_jail = 3 then
				-- pay fine
			transfer (-50)
				-- reset jail variable
			rounds_in_jail := 0
			print("[J] You payed a fine of 50 CHF and are now out of jail. You have " + money.out + " CHF left.%N")
			play (d1, d2)
			elseif rounds_in_jail < 3 then
				print("[J] You are in jail. Do you want to pay a fine of 50 CHF to get free? "+prompt)
		end
	end

feature -- Const

	PROMPT: STRING = " <y/N> %N"

invariant
	name_exists: name /= Void and then not name.is_empty
	board_exists: board /= Void
	--position_valid: position >= board.squares.lower -- Token can go beyond the finish position, but not the start
	--money_non_negative: money >= 0

end

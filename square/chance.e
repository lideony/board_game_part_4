note
	description: "Summary description for {CHANCE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CHANCE

inherit

	SQUARE
		rename
			affect as chance
		redefine
			chance,
			out
		end

create
	make

feature -- Init

	make
		do
			name := "Chance"
		end

feature

	chance (p: PLAYER)
		local
			amount: INTEGER
		do
				-- Calculate random amount of money between -300 and 200 CHF
			random.forth
			amount := random.bounded_item (-30, 20) * 10
			p.transfer (amount)
			if amount > 0 then
				print ("Chance! " + p.name + " was lucky and gained " + amount.out + " CHF and has now " + p.money.out + " CHF. %N")
			elseif amount = 0 then
				print ("Chance! " + p.name + " didn't lose or win any money and still has " + p.money.out + " CHF. %N")
			else
				print ("Chance! " + p.name + " had bad luck and looses " + amount.abs.out + " CHF and has now " + p.money.out + " CHF left.%N")
			end
		end

	out: STRING
		do
			Result := "[C]"
		end

	random: V_RANDOM
			-- Random sequence.
		once
			create Result
		end

end

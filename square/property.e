note
	description: "Summary description for {PROPERTY_SQUARE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PROPERTY

inherit

	SQUARE
		rename
			affect as land
		redefine
			out,
			land
		end

create
	make

feature -- Access

	price: INTEGER

	rent: INTEGER

	owner: PLAYER

feature -- Init

	make (a_name: STRING; a_price: INTEGER; a_rent: INTEGER)
		do
			name := a_name.twin
			price := a_price
			rent := a_rent
		end

feature

	out: STRING
		do
			Result := "P"
		end

	land (p: PLAYER)
		local
			owner_string: STRING
		do
			if owner /= void then
				owner_string := owner.name
			else
				owner_string := "none"
			end
			print ("[property details*: " + "price: " + price.out + " CHF, rent: " + rent.out + " CHF, owner: " + owner_string + "]%N")
			if owner = void then
				p.offer_property (Current)
			elseif owner /= p then
				p.pay_rent (Current)
			end
		end

	set_owner(a_player: PLAYER)
		--void if owner retires
	do
		owner := a_player
		ensure
			owner = a_player
	end

end

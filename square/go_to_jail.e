note
	description: "Summary description for {GO_TO_JAIL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GO_TO_JAIL

inherit
	SQUARE
	rename
		affect as imprison
	redefine
		imprison,
		out
	end


create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			name := "Go To Jail"
		end
feature

	imprison(p: PLAYER)
	do
		print ("*!!!*: "+p.name +"was arrested goes directly to Jail.")
		p.set_position (16)
	end

	out: STRING
	do
		Result := "[J]"
	end
end

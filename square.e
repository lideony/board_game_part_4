class
	SQUARE

inherit
	ANY
		redefine
			out
		end


feature -- Init


feature -- Access
	name: STRING

feature

	set_name(a_name: STRING)
	do
		name := a_name
	end

feature -- Basic operations

	affect (p: PLAYER)
			-- Apply square's special effect to `p'.
		require
			p_exists: p /= Void
		do
			-- For a normal square do nothing.
		end

feature -- Output

	out: STRING
			-- Textual representation.
		do
			Result := "[ ]"
		end

end

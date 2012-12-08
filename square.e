class
	SQUARE

inherit
	ANY
		redefine
			out
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
			Result := "."
		end

end

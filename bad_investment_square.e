class
	BAD_INVESTMENT_SQUARE

inherit
	SQUARE
		redefine
			affect,
			out
		end

feature -- Basic operations

	affect (p: PLAYER)
			-- Apply square's special effect to `p'.
		do
			p.transfer (-5)
		end

feature -- Output

	out: STRING
			-- Textual representation.
		do
			Result := "#"
		end

end

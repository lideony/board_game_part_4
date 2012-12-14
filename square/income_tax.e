note
	description: "Summary description for {INCOME_TAX}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INCOME_TAX

inherit

	SQUARE
		redefine
			affect,
			out
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			name := "Income tax"
		end

feature
	affect(p: PLAYER)
	local
		inc_tax: INTEGER
	do
		inc_tax := (p.money.to_real*(-0.01)).rounded*10
		p.transfer (inc_tax)
		print(p.name + " pays " + inc_tax.abs.out +" CHF income tax and has now "+p.money.out +" CHF left. %N")
	end

	out: STRING
	do
		Result := "[I]"
	end
end

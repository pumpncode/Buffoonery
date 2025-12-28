--!! No AI was used
-- > Expect Human Error :)
buf_calculations = {
	-- Jokergebra Calcs: 1 - 30
	{ result = 1, calc = "5x - 4 = x" },
	{ result = 1, calc = "x / 2 + 3 = 3.5" },
	{ result = 1, calc = "3 * (x + 1) = 6" },
	{ result = 1, calc = "2x - 5 = -4 + x" },
	{ result = 1, calc = "4x - 56 / 4 = -10" },
	
	{ result = 2, calc = "3x - 4 = x" },
	{ result = 2, calc = "8 * (1 / x) = 2x" }, -- +/-
	{ result = 2, calc = "2 * (x + 3) = 10" },
	{ result = 2, calc = "9x / 5 = 9 * 0.4" },
	{ result = 2, calc = "6x + 3 = 5x + 5" },
	
	{ result = 3, calc = "6x - 4 = 14" },
	{ result = 3, calc = "12 / 9 * x = 4" },
	{ result = 3, calc = "3 * (x + 2) = 5x" },
	{ result = 3, calc = "4 * 3x = 144 / 4" },
	{ result = 3, calc = "3x + 2 = 2 * 4 + x" },
	
	{ result = 4, calc = "3x - 2 = 10" },
	{ result = 4, calc = "2x - 1 = 7x / 4" },
	{ result = 4, calc = "2x - 5 = -1 + x" },
	{ result = 4, calc = "6x + 3 = 5x + 7" },
	{ result = 4, calc = "(5x + 1) / 3 = 7" },
	
	{ result = 5, calc = "3x - 2 = 13" },
	{ result = 5, calc = "7 - x = x - 3" },
	{ result = 5, calc = "2x + 5 = 9x / 3" },
	{ result = 5, calc = "9x / 6 = x + 2.5" },
	{ result = 5, calc = "7x - 8 = 17 + 2x" },
	
	{ result = 6, calc = "3x - 2 = 22 - x" },
	{ result = 6, calc = "2 * (x + 4) = 20" },
	{ result = 6, calc = "4 * 3x = 144 / 2" },
	{ result = 6, calc = "30 * 1.4 = 30 + 2x" },
	{ result = 6, calc = "3 * (x + 1) = x + 15" },
	
	-- Integral Calcs: 31 - 70
	{ result = 7, calc = "3x - 2 = 12 + x" },
	{ result = 7, calc = "7x - 9 = 19 + 3x" },
	{ result = 7, calc = "4 * 3x = 168 / 2" },
	{ result = 7, calc = "12x * 0.5 = 5x + 7" },
	{ result = 7, calc = "3 * (x + 1) = 6 * 4" },
	
	{ result = 1, calc = "(2x + 8) / 2 = 5x" },
	{ result = 1, calc = "7x + 12 = 6 * 3 + x" },
	{ result = 1, calc = "6x * 5 = 12 * 3 - 6" },
	{ result = 1, calc = "12x = 6x + (42 / 7)" },
	{ result = 1, calc = "10x - 9 = 12 / 4 - 2" },
	
	{ result = 2, calc = "7x = (30 - x) / 2" },
	{ result = 2, calc = "(3x + 1) / 2 = 3.5" },
	{ result = 2, calc = "-4x + 30 = 132 / 6" },
	{ result = 2, calc = "12x = 6x + (48 / 4)" },
	{ result = 2, calc = "x / (6 - x) = 1 / 2" },
	
	{ result = 3, calc = "12x * 0.5 = 5x + 3" },
	{ result = 3, calc = "2x * 5 = 12 * x - 6" },
	{ result = 3, calc = "2x - 1 = (7x - 1) / 4" },
	{ result = 3, calc = "(x + 4) / 2 = 10.5 / 3" },
	{ result = 3, calc = "(2x + 4) / 4 = x - 0.5" },
	
	{ result = 4, calc = "6x - 12 = 4x - 4" },
	{ result = 4, calc = "(5x - 3) / 2 = 8.5" },
	{ result = 4, calc = "4x / 8 = 98 - 12 * 8" },
	{ result = 4, calc = "(3x + 2) / 2 = 2x - 1" },
	{ result = 4, calc = "x * (x + 3) = 16 + 3x" }, -- +/-
	
	{ result = 5, calc = "(2x + 4) + 1 = 3x" },
	{ result = 5, calc = "3 * (x + 4) = 6x - 3" },
	{ result = 5, calc = "(3x + 1) / 2 = x + 3" },
	{ result = 5, calc = "10x - 1 = 7 * (x + 2)" },
	{ result = 5, calc = "x + 12 = (10x + 1) / 3" },
	
	{ result = 6, calc = "12 / 9 * x = x + 2" },
	{ result = 6, calc = "9x / 6 = 2x - 3" },
	{ result = 6, calc = "4x / 8 = 99 - 12 * 8" },
	{ result = 6, calc = "11x = 9x + (48 / 4)" },
	{ result = 6, calc = "3 * (x + 2) = 4x" },
	
	{ result = 7, calc = "2 * (x + 3) = 3x - 1" },
	{ result = 7, calc = "x*x - 9 = 8 * 15 / 3" }, -- +/-
	{ result = 7, calc = "(5x + 1) / 3 = 2x - 2" },
	{ result = 7, calc = "7 * (x + 3) = 14 + 8x" },
	{ result = 7, calc = "30 * (x / 5) = 28 + 2x" },
}

-- Table-Size is Hardcoded:
-- Jokergebra:  1 - 30
-- Integral: + 31 - 70
function buf_get_calculation(skip_result, full_table)
	local index = pseudorandom('buf_calculation', 1, full_table and 70 or 30)
	if skip_result and buf_calculations[index].result == skip_result then
		-- Not perfect, skews chances;
		index = index + 5 -- Groups of 5.
		if full_table then
			if index > 70 then index = index - 70 end
		else
			if index > 30 then index = index - 30 end
		end
	end
	return buf_calculations[index]
end

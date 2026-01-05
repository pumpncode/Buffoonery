SMODS.Joker {
    key = "jokergebra",
    name = "JokerGebra",
	atlas = "buf_jokers",
	pos = { x = 7, y = 2 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 7,
	config = {
		extra = {
			xchips = 2.0,
			calculation = { result = 0, calc = "x = 0" },
			tests = { success = 0, limit = 8 }
		}
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			'1', --> Hardcoded Play Limit
			card.ability.extra.xchips,
			-- Get Calc. JokerGebra (or Random)
			(card.ability.extra.calculation.result == 0
			and buf_get_calculation(nil, false).calc --> functions/jokergebra_calcs.lua
			or card.ability.extra.calculation.calc)
			--..' ['..card.ability.extra.calculation.result..']' --> Debug: Show Answer
			-- Special Req.
			, card.ability.extra.tests.limit - card.ability.extra.tests.success
		} }
	end,
    add_to_deck = function(self, card, from_debuff)
		SMODS.change_play_limit(1) --> Hardcoded Play Limit
		if not from_debuff then
			-- Resets when copied
			if card.ability.extra.tests.success ~= 0 then
				SMODS.calculate_effect({
					message = localize('k_reset'),
					colour = G.C.BUF_SPC
				}, card)
			end
			card.ability.extra.tests.success = 0
			-- Give new Calc.
			if G.GAME.blind and G.GAME.blind.in_blind then
				card.ability.extra.calculation = buf_get_calculation(nil, false) --> functions/jokergebra_calcs.lua
				SMODS.calculate_effect({
					message = localize('buf_test_start'),
					colour = G.C.BLUE
				}, card)
			else
				-- Dummy Calc., just shows Random Calcs.
				card.ability.extra.calculation = { result = 0, calc = "x = 0" }
			end
		end
    end,
    remove_from_deck = function(self, card, from_debuff)
		SMODS.change_play_limit(-1) --> Hardcoded Play Limit
	end,
    calculate = function(self, card, context)
        if context.joker_main then
			if #context.full_hand == card.ability.extra.calculation.result then
				-- Correct!
				if not context.blueprint then
					card.ability.extra.tests.success = card.ability.extra.tests.success + 1
				end
				return {
					message = localize('buf_test_correct'),
					colour = G.C.GREEN,
					size = 1.2,
					extra = {
						xchips = card.ability.extra.xchips
					}
				}
			else
				-- Wrong: Announce Reset if needed
				local extra = nil
				if not context.blueprint then
					if card.ability.extra.tests.success ~= 0 then
						extra = {
							message = localize('k_reset'),
							colour = G.C.BUF_SPC
						}
					end
					card.ability.extra.tests.success = 0
				end
				return {
					message = localize('buf_test_wrong'),
					colour = G.C.RED,
					extra = extra
				}
			end
        end
		if not context.blueprint then
			if context.setting_blind and not self.getting_sliced then
				card.ability.extra.calculation = buf_get_calculation(nil, false) --> functions/jokergebra_calcs.lua
				return {
					message = localize('buf_test_start'),
					colour = G.C.BLUE
				}
			end
			if context.after then
				if card.ability.extra.tests.success >= card.ability.extra.tests.limit then
					expire_card(card) --> functions/expire.lua
					G.E_MANAGER:add_event(Event({
						func = function()
							local integral = SMODS.add_card({key = 'j_buf_integral'})
							integral.ability.extra.score.current = card.ability.extra.tests.success
							return true
						end
					}))
					return {
						message = localize('buf_test_upgrade'),
						colour = G.C.BUF_SPC,
						size = 0.8
					}
				else
					card.ability.extra.calculation = buf_get_calculation(card.ability.extra.calculation.result, false) --> functions/jokergebra_calcs.lua
					return {
						message = localize('buf_test_new'),
						colour = G.C.BLUE
					}
				end
			end
			if context.end_of_round and context.game_over == false and context.main_eval then
				-- Dummy Calc., just shows Random Calcs.
				card.ability.extra.calculation = { result = 0, calc = "x = 0" }
			end
		end
    end
}

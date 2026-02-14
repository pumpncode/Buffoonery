SMODS.Joker {
    key = "integral",
    name = "Integral",
	atlas = "buf_jokers",
	pos = { x = 7, y = 3 },
    unlocked = false,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = 'buf_spc',
    cost = 7,
	config = {
		extra = {
			echips = 1.2, -- Set to 1.1 to reflect texture
			echip_mod = 0.02,
			calculation = { result = 0, calc = "x = 0" },
			score = { current = 0, success = 1, failure = 3 },
			spawned = true --> First spawn is silent
		}
	},
	loc_vars = function(self, info_queue, card)
		if Buffoonery.config.show_info then
			info_queue[#info_queue+1] = {set = 'Other', key = 'special_info'}
		end
		return { vars = {
			'2', --> Hardcoded Play Limit
			card.ability.extra.echips + (card.ability.extra.echip_mod * card.ability.extra.score.current),
			-- Get Calc. Integral (or Random)
			(card.ability.extra.calculation.result == 0
			and buf_get_calculation(nil, true).calc --> functions/jokergebra_calcs.lua
			or card.ability.extra.calculation.calc)
			--..' ['..card.ability.extra.calculation.result..']' --> Debug: Show Answer
			-- Score:
			, card.ability.extra.score.current --* 5.0
		} }
	end,
    add_to_deck = function(self, card, from_debuff)
		SMODS.change_play_limit(2) --> Hardcoded Play Limit
		if not from_debuff then
			-- Give new Calc.
			if G.GAME.blind and G.GAME.blind.in_blind then
				card.ability.extra.calculation = buf_get_calculation(nil, true) --> functions/jokergebra_calcs.lua
				if card.ability.extra.spawned then
					-- Don't yap when getting spawned,
					-- but DO yap when copied after!
					card.ability.extra.spawned = nil
				else
					SMODS.calculate_effect({
						message = localize('buf_test_start'),
						colour = G.C.BLUE
					}, card)
				end
			else
				-- Dummy Calc., just shows Random Calcs.
				card.ability.extra.calculation = { result = 0, calc = "x = 0" }
			end
		end
    end,
    remove_from_deck = function(self, card, from_debuff)
		SMODS.change_play_limit(-2) --> Hardcoded Play Limit
	end,
    calculate = function(self, card, context)
        if context.joker_main then
			if #context.full_hand == card.ability.extra.calculation.result then
				return {
					message = localize('buf_test_correct'),
					colour = G.C.GREEN,
					size = 1.2,
					extra = {
						echips = card.ability.extra.echips + (card.ability.extra.echip_mod * card.ability.extra.score.current)
					}
				}
			else
				return {
					message = localize('buf_test_wrong'),
					colour = G.C.RED
				}
			end
        end
		if not context.blueprint then
			if context.setting_blind and not self.getting_sliced then
				card.ability.extra.calculation = buf_get_calculation(nil, true) --> functions/jokergebra_calcs.lua
				return {
					message = localize('buf_test_start'),
					colour = G.C.BLUE
				}
			end
			if context.after then
				if #context.full_hand == card.ability.extra.calculation.result then
					card.ability.extra.score.current = card.ability.extra.score.current + card.ability.extra.score.success
				else
					card.ability.extra.score.current = math.max(card.ability.extra.score.current - card.ability.extra.score.failure, 0)
				end
				card.ability.extra.calculation = buf_get_calculation(card.ability.extra.calculation.result, true) --> functions/jokergebra_calcs.lua
				return {
					message = localize('buf_test_new'),
					colour = G.C.BLUE
				}
			end
			if context.end_of_round and context.game_over == false and context.main_eval then
				-- Dummy Calc., just shows Random Calcs.
				card.ability.extra.calculation = { result = 0, calc = "x = 0" }
			end
		end
    end,
	-- HIDE JOKER IN COLLECTION (THANKS, EREMEL) --
	inject = function(self)
		if not Buffoonery.config.show_spc then
			SMODS.Joker.super.inject(self)
			G.P_CENTER_POOLS.Joker[#G.P_CENTER_POOLS.Joker] = nil
		else
			SMODS.Joker.super.inject(self)
		end
	end
}

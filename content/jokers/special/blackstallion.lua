SMODS.Joker {
	key = "blackstallion",
	name = "Black Stallion",
	atlas = "buf_jokers",
	pos = { x = 1, y = 3 },
    unlocked = false,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = "buf_spc",
	cost = 6,
	config = {
		extra = {
			mult = 1,
			mult_mod = 2.0
		}
	},
	pools = {
		--["Numetal"] = true,
		["Numetal_Special"] = true
    },
	loc_vars = function(self, info_queue, card)
		if Buffoonery.config.show_info then
			info_queue[#info_queue+1] = {set = 'Other', key = 'special_info'}
			info_queue[#info_queue+1] = {set = 'Other', key = 'nu_metal_info'}
		end
		return { vars = {
			card.ability.extra.mult,
			card.ability.extra.mult_mod
		} }
	end,
    calculate = function(self, card, context)
        if context.joker_main then
            return { mult = card.ability.extra.mult }
        end
		if context.end_of_round and context.main_eval and context.game_over == false
		and G.GAME.blind.boss and not context.blueprint then
            card.ability.extra.mult = card.ability.extra.mult * card.ability.extra.mult_mod
            return {
                message = localize('buf_doubled'),
                colour = G.C.MULT
            }
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

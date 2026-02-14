SMODS.Joker {
    key = "camarosa",
    name = "Camarosa",
    atlas = 'buf_jokers',
	pos = { x = 5, y = 1 },
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
	yes_pool_flag = 'gfondue_licked',
	config = {
		extra = {
			emult = 1.25,
			chance = 1000
		}
	},
	pools = {
        ["Food"] = true
    },
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.chance, 'buf_camarosa')
		return { vars = {
			card.ability.extra.emult,
			numerator, denominator
		} }
	end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
				-- Talisman-Mod or "functions/e_calculation.lua" and "lovely/e_calculation.toml"
				e_mult = card.ability.extra.emult
			}
        end
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			if SMODS.pseudorandom_probability(card, 'buf_camarosa', 1, card.ability.extra.chance) then
				expire_card(card) --> functions/expire.lua
				return {
					message = localize('k_eaten_ex'),
					colour = G.C.FILTER
				}
			else
				return {
					message = localize('k_safe_ex'),
					colour = G.C.GREEN
				}
			end
		end
	end
}

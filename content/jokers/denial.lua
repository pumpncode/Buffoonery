SMODS.Joker {
    key = "denial",
    name = "Arstotzkan Denial",
	atlas = "buf_jokers",
	pos = { x = 2, y = 1 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
	config = {
		extra = {
			mult_mod = 5,
			chips_mod = 30
		}
	},
	loc_vars = function(self, info_queue, card)
		local mult = 0
		local chips = 0
        for _, playing_card in ipairs(G.playing_cards or {}) do
			if playing_card:get_seal() == "Red" then mult = mult + card.ability.extra.mult_mod end
			if playing_card:get_seal() == "Blue" then chips = chips + card.ability.extra.chips_mod end
        end
		return { vars = {
			card.ability.extra.mult_mod,
			card.ability.extra.chips_mod,
			mult,
			chips
		} }
	end,
    calculate = function(self, card, context)
        if context.joker_main then
			local mult = 0
			local chips = 0
			for _, playing_card in ipairs(G.playing_cards or {}) do
				if playing_card:get_seal() == "Red" then mult = mult + card.ability.extra.mult_mod end
				if playing_card:get_seal() == "Blue" then chips = chips + card.ability.extra.chips_mod end
			end
            return {
				mult = mult,
                chips = chips
            }
        end
    end
}

SMODS.Joker {
	key = "laidback",
	name = "Laidback Joker",
	atlas = "buf_jokers",
	pos = { x = 3, y = 1 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	rarity = 1,
	cost = 5,
	config = {
		extra_slots_used = 1,
		extra = {
			xmult = 2
		}
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.xmult
		} }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return { xmult = card.ability.extra.xmult }
		end
	end
}

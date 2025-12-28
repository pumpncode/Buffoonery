SMODS.Joker {
    key = "afan",
    name = "Adoring Fan",
	atlas = "buf_jokers",
	pos = { x = 3, y = 2 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = 1,
    cost = 0,
	config = {
		extra = {
			mult = 15,
			chance = 2,
			count = 0,
			bitter = 3
		},
		buf_price_mod = -6
	},
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.chance, 'buf_afan')
		return { vars = {
			card.ability.extra.mult,
			numerator, denominator
		} }
	end,
    calculate = function(self, card, context)
        if context.joker_main then
            return { mult = card.ability.extra.mult }
        end
		if context.selling_self and not context.blueprint then
			if card.ability.extra.count > card.ability.extra.bitter then
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.5,
					func = function() 
						SMODS.add_card({key = 'j_buf_afan_spc'})
						return true
					end
				}))
				return {
					message = localize('buf_disilluison'),
					colour = G.C.BUF_SPC
				}
			elseif SMODS.pseudorandom_probability(card, 'buf_afan', 1, card.ability.extra.chance) then
				card.ability.extra.count = card.ability.extra.count + 1
				card.ability.extra_value = 0 -- Remove any gained Value
				for i = 1, #G.jokers.cards do
					if G.jokers.cards[i] == card then
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							delay = 0.5,
							func = function() 
								local copy_fan = copy_card(G.jokers.cards[i], nil, nil, nil, false)
								copy_fan:add_to_deck()
								G.jokers:emplace(copy_fan)
								copy_fan:start_materialize()
								return true
							end
						}))
						return {
							message = localize('buf_afan_annoy'..math.random(1,4)),
							colour = G.C.RED
						}
					end
				end
			end
		end
    end
}

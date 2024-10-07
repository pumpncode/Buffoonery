SMODS.Joker {
    key = "rerollin",
    name = "Rerollin'",
    atlas = 'maggitsjokeratlas',
    pos = {
        x = 0,
        y = 3,
    },
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {
        extra = 20, rcount = 0     
    },
    loc_txt = {
        name = "Rerollin'",
        text = {"Earn {C:money}$20{} for your",           -- Earn $20 on the fifth reroll
                "{C:attention}5th reroll{} each shop"}    -- each shop.
    },
    calculate = function(self, card, context)
		if card.ability.rcount < 5 then
			if context.reroll_shop then
				card.ability.rcount = card.ability.rcount + 1
				if card.ability.rcount == 5 then 
					ease_dollars(card.ability.extra)
					card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Rerollin'", colour = G.C.GOLD})
				end
			end
		end
		if context.ending_shop then
			card.ability.rcount = 0
		end
    end
}

-- DONE
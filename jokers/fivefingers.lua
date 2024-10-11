SMODS.Joker {
    key = "fivefingers",
    name = "Five Fingers",
    atlas = 'maggitsjokeratlas',
    pos = {
        x = 1,
        y = 3,
    },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {
        extra = { Xmult = 2.5 }        
    },
    loc_txt = {
        name = "Five Fingers",
        text = {"{X:mult,C:white}X#1#{} Mult if you have",
                "exactly {C:attention}5 Jokers{} and scored",
				"hand has exactly {C:attention}5 cards{}"}
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.Xmult}
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
			if #context.scoring_hand == 5 and #G.jokers.cards == 5 then
				return {
					message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
					Xmult_mod = card.ability.extra.Xmult
				}
			end
        end
    end
}
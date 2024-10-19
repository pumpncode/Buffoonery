SMODS.Joker{
	key = "laidback",
    name = "Laidback Joker",
    atlas = 'maggitsjokeratlas',
    pos = {
        x = 0,
        y = 0,
    },
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {
        extra = { Xmult = 2 }        
    },
    loc_txt = { 
        name = "Laidback Joker",
        text = {
			"{X:mult,C:white}X#1#{} Mult",
            "Occupies 2 slots",
        },
    },
	loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.Xmult}
        }
    end,
    add_to_deck = function(from_debuff)
        if G.jokers then
            G.jokers.config.card_limit = G.jokers.config.card_limit - 1  -- Removes a joker slot when added 
        end
    end,
    remove_from_deck = function(from_debuff)
        if G.jokers then
            G.jokers.config.card_limit = G.jokers.config.card_limit + 1  -- Adds the slot back when sold or otherwise removed
        end
    end,
	calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
                Xmult_mod = card.ability.extra.Xmult
            }
        end
	end
}
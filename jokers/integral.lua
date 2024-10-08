SMODS.Joker {
    key = "integral",
    name = "Integral",
    atlas = 'maggitsjokeratlas',
    pos = {
        x = 0,
        y = 0,
    },
    rarity = 3,
    cost = 10,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {
        extra = { emult = 1, emult_gain = 0.1 }        
    },
    loc_txt = {
        name = "Integral",
        text = {"This Joker gains{X:clubs,C:mult}^#2#{} Mult",
				"for each triggered {X:mult,C:white}X1{} Mult",
				"resets after hand scores",
                "{C:inactive}(Currently{} {X:clubs,C:mult}^#2#{} {C:inactive}Mult){}"
		}
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.emult, card.ability.extra.emult_gain}
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.emult } },
                mult_mod = card.ability.extra.emult
            }
        end
        if context.end_of_round and not context.blueprint and not context.repetition and not context.other_card and G.GAME.blind.boss then
            card.ability.extra.emult = card.ability.extra.emult + card.ability.extra.emult_gain
            return {
                message = 'Doubled!',
                colour = G.C.MULT,
                card = card
            }
        end
    end
}

--DONE
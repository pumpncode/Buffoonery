SMODS.Joker {
    key = "whitepony",
    name = "White Pony",
    atlas = 'maggitsjokeratlas',
    pos = {
        x = 0,
        y = 1,
    },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {
        extra = { mult = 3, mult_gain = 2 },
		numetal = true
    },
    loc_txt = {
        name = "White Pony",
        text = {"{C:mult}+#1#{} Mult",
                "Doubles each Ante"}
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.mult, card.ability.extra.mult_gain}
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                mult_mod = card.ability.extra.mult
            }
        end
        if context.end_of_round and not context.blueprint and not context.repetition and not context.other_card and G.GAME.blind.boss then
            card.ability.extra.mult = card.ability.extra.mult * card.ability.extra.mult_gain
            return {
                message = 'Doubled!',
                colour = G.C.MULT,
                card = card
            }
        end
    end
}

--DONE
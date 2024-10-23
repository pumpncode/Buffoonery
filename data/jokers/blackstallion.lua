SMODS.Joker {
    key = "blackstallion",
    name = "Black Stallion",
    atlas = 'maggitsmiscatlas',
    pos = {
        x = 1,
        y = 2,
    },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	in_pool = false,
    config = {
        extra = { mult = 1, mult_gain = 2 },
		numetal = true
    },
    loc_txt = {set = 'Joker', key = 'j_buf_blackstallion'},
    loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {set = 'Other', key = 'special_info'}
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
    end,
	
	-- HIDE JOKER IN COLLECTION (THANKS, EREMEL) --
	inject = function(self)
		SMODS.Joker.super.inject(self)
		G.P_CENTER_POOLS.Joker[#G.P_CENTER_POOLS.Joker] = nil
	end
	
}

--DONE
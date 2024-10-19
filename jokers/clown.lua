SMODS.Joker {
    key = "clown",
    name = "Clown",
    atlas = 'maggitsjokeratlas',
    pos = {
        x = 2,
        y = 2,
    },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {
        extra = { chip_mod = 20, jokers = 0, chips = 20 },
		numetal = true
    },
    loc_txt = {
        name = "Clown",
        text = {"This Joker gains {C:chips}+#1#{} Chips ",
                "when another Joker is added",
				"{C:inactive}(Currently{} {C:chips}+#2#{} {C:inactive}Chips){}",
				"{C:inactive,s:0.7}Jimbo = Chips{}"
		}
    },
    loc_vars = function(self, info_queue, center)
        return {
            vars = { center.ability.extra.chip_mod, center.ability.extra.chips }
        }
    end,
    calculate = function(self, card, context)
        local num_jokers = #G.jokers.cards
        local free = 0
        if num_jokers > card.ability.extra.jokers then
            free = num_jokers - card.ability.extra.jokers
        end
        if free ~= 0 then
            card.ability.extra.chips = card.ability.extra.chips + (card.ability.extra.chip_mod * free)
        end
        card.ability.extra.jokers = num_jokers
		if context.joker_main then
		chip_mod = card.ability.extra.chips
		return {
                message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
                chip_mod = card.ability.extra.chips
        }
		end		
	end,
    add_to_deck = function(self, card, from_debuff)
		card.ability.extra.jokers = #G.jokers.cards + 1
    end
}

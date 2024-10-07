SMODS.Joker {
    key = "korny",
    name = "Korny Joker",
    atlas = 'maggitsjokeratlas',
    pos = {
        x = 1,
        y = 0,
    },
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = true,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = true,
    config = {
        extra = { 
		chips = 50, 
		bgchips = 90, 
		bschips = 160, 
		odds = 7 
		}        
    },
    loc_txt = {
        name = "Korny Joker",
        text = {"{C:chips}+#1#{} Chips during {C:attention}Small Blind{}",
                "{C:chips}+#2#{} Chips during Big Blind and {C:chips}+#3#{} during {C:attention}Boss Blind{}",
				"{C:green}Unknown{} chance to die at the end of round",
				"{C:inactive}You don't know the chances...{}"
				}
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.chips, 
					card.ability.extra.bgchips,
					card.ability.extra.bschips,
					G.GAME.probabilities.normal,
					card.ability.extra.odds
					}
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
			if G.GAME.blind:get_type() == 'Small' then
				return {
					message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
					chip_mod = card.ability.extra.chips
				}
			end
			if G.GAME.blind:get_type() == 'Big' then
				return {
					message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.bgchips } },
					chip_mod = card.ability.extra.bgchips
				}
			end
			if G.GAME.blind:get_type() == 'Boss' then
				return {
					message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.bschips } },
					chip_mod = card.ability.extra.bschips
				}
			end
		end
		if context.end_of_round and not context.blueprint and not (context.individual or context.repetition) then
            if pseudorandom("korny") < G.GAME.probabilities.normal/card.ability.extra.odds then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3,0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                                                    func = function()
                                                        G.jokers:remove_card(card)
                                                        card:remove()
                                                        card = nil
                                                        return true; end }))
                        return true
                    end
                }))

                return {
                    message = "Dead!",
                    colour = G.C.RED,
                    card = card
                }
            else
                return {
                    message = "He's okay",
                    colour = G.C.GREEN,
                    card = card
                }
            end
        end
    end
}

-- TODO: ADD FLAGS TO PREVENT RESPAWN
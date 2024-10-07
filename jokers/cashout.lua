SMODS.Joker {
    key = "cashout",
    name = "Cashout Voucher",
    atlas = 'maggitsjokeratlas',
    pos = {
        x = 0,
        y = 2,
    },
    rarity = 1,
    cost = 2,
    unlocked = true,
    discovered = true,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
    config = {
        extra = { money = 0.0025, xscore = 3 }        
    },
    loc_txt = {
        name = "Cashout Voucher",
        text = {"If {C:attention}winning hand{} triples the Blind's",
				"score {C:attention}requirement{}, earn 0.25% of it",
				"as {C:money}money{} and destroy this Joker",
				"{C:inactive}(Max of{} {C:money}$50{}{C:inactive}){}"}
    },
    calculate = function(self, card, context)
		if context.after and not context.blueprint and not context.repetition and not context.other_card then
			if (hand_chips * mult) > (card.ability.extra.xscore * G.GAME.blind.chips) then
				local earned = card.ability.extra.money * G.GAME.blind.chips
				if earned > 50 then
					earned = 50
				end
				ease_dollars(earned)
				G.E_MANAGER:add_event(Event({
					func = function()
					play_sound('tarot1')
					card.T.r = -0.2
					card:juice_up(0.3, 0.4)
					card.states.drag.is = true
					card.children.center.pinch.x = true
					G.E_MANAGER:add_event(Event({
					  trigger = 'after',
					  delay = 0.3,
					  blockable = false,
					  func = function()
						G.jokers:remove_card(card)
						card:remove()
						card = nil
						return true;
					  end
					}))
					return true
				  end
				}))
				return {
					message = localize('$')..earned,
                    colour = G.C.MONEY,
				}
			end
		end
    end
}

-- SHOULD I PREVENT RESPAWN WITH FLAGS?
-- IF SO THEN
--     TODO: ADD FLAGS
-- ELSE
--     DONE
-- END
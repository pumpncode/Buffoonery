SMODS.Joker {
    key = "afan_spc",
    name = "Bitter Ex-Fan",
	atlas = "buf_jokers",
	pos = { x = 3, y = 3 },
    unlocked = false,
    discovered = false,
    eternal_compat = false, --> I think it would be a bit too mean....
    perishable_compat = true,
    blueprint_compat = false,
    rarity = 'buf_spc',
    cost = 0,
	config = {
		extra = {
			rounds = 5,
			active = false
		},
		buf_price_mod = -25
	},
	loc_vars = function(self, info_queue, card)
		if Buffoonery.config.show_info then
			info_queue[#info_queue+1] = {set = 'Other', key = 'special_info'}
		end
		return { vars = {
			card.ability.extra.rounds
		} }
	end,
	load = function(self, card, card_table, other_card)
		-- When defeated, continue Wigglin'
		G.E_MANAGER:add_event(Event({
			func = function()
				if card.ability.extra.defeated then
					local eval = function(card) return not card.REMOVED end
					juice_card_until(card, eval, true)
				end
				return true
			end
		}))
	end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			-- When defeated & Copied: Continue Wigglin'
			-- You could also Reset the cost and be mean...
			if card.ability.extra.defeated then
				local eval = function(card) return not card.REMOVED end
				juice_card_until(card, eval, true)
			end
		end
	end,
    remove_from_deck = function(self, card, from_debuff)
		-- When Removed or Debuffed, Reset:
		buf_shuffle_area(G.hand, 'back', true)
		buf_shuffle_area(G.jokers, 'back', true)
    end,
    calculate = function(self, card, context)
		if not context.blueprint then
			if context.first_hand_drawn then
				card.ability.extra.active = false
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.5,
					func = function()
						buf_choose_shuffle()
						return true
					end
				}))
				return {
					message = localize('buf_afan_monologue'..math.random(1,3)),
					colour = G.C.FILTER
				}
			end
			if context.after then
				card.ability.extra.active = true
			end
            if context.hand_drawn or (G.deck and #G.deck.cards == 0 and context.after) then
				if card.ability.extra.active then
					card.ability.extra.active = false
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						func = function()
							if G.STATE == G.STATES.SHOP then return true end
							if G.STATE ~= G.STATES.SELECTING_HAND then return false end
							-- START: Nested Event
							-- For the rare case of "#G.deck.cards == 0", because;
							-- "hand_drawn" doesn't trigger when the Deck is empty >:(
							G.E_MANAGER:add_event(Event({
								trigger = "after",
								delay = 0.5,
								func = function()
									if buf_choose_shuffle() then
										card:juice_up(0.8, 0.5)
									end
									--!! Save Run due to Nested Event:
									save_run()
									return true
								end
							}))
							-- END: Nested Event
							return true
						end
					}), "other" )
				end
				return
			end
			if context.end_of_round and context.game_over == false and context.main_eval and not card.ability.extra.defeated then
				card.ability.extra.rounds = card.ability.extra.rounds - 1
				if card.ability.extra.rounds <= 0 then
					card.ability.extra.defeated = true
					card.ability.buf_price_mod = card.ability.buf_price_mod * -1
					card:set_cost() --> Update Cost
					-- Pause and then Wiggle
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.5,
						func = function()
							local eval = function(card) return not card.REMOVED end
							juice_card_until(card, eval, true)
							return true
						end
					}))
					return {
						message = localize('buf_defeated'),
						colour = G.C.GREEN
					}
				else
					return {
						message = tostring(card.ability.extra.rounds),
						colour = G.C.FILTER
					}
				end
			end
		end
    end,
	-- HIDE JOKER IN COLLECTION (THANKS, EREMEL) --
	inject = function(self)
		if not Buffoonery.config.show_spc then
			SMODS.Joker.super.inject(self)
			G.P_CENTER_POOLS.Joker[#G.P_CENTER_POOLS.Joker] = nil
		else
			SMODS.Joker.super.inject(self)
		end
	end
}

function buf_shuffle_area(area, face, reset)
	if area and #area.cards > 0 then
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.3,
			func = function()
				for i = 1, #area.cards do
					if area.cards[i].facing == face then 
						area.cards[i]:flip() 
					end
				end
				if face == 'front' and not reset then
					area:shuffle()
				end
				return true
			end
		}))
	end
end

function buf_choose_shuffle()
	if pseudorandom('buf_shuffle', 0, 1) == 1 then
		buf_shuffle_area(G.hand, 'back')
		buf_shuffle_area(G.jokers, 'front')
		return false --> Don't Juice
	else
		buf_shuffle_area(G.jokers, 'back')
		buf_shuffle_area(G.hand, 'front')
		return true --> Juice
	end
end

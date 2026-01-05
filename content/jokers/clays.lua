SMODS.Joker {
    key = "clays",
    name = "Clay Shooting",
	atlas = "buf_jokers",
	pos = { x = 1, y = 1 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    rarity = 1,
    cost = 4,
	config = {
		extra = {
			money = 8,
			target = 0,
			success = false
		}
	},
	loc_vars = function(self, info_queue, card)
		if card.ability.extra.target ~= 0 then
            return {
				key = self.key .. '_alt',
				vars = {
					card.ability.extra.money,
					card.ability.extra.target
				}
			}
		else
			return { vars = {
				card.ability.extra.money
			} }
		end
	end,
    calculate = function(self, card, context)
		if not context.blueprint then
			if context.setting_blind and not self.getting_sliced then
				card.ability.extra.target = pseudorandom('buf_clays', 1, G.GAME.current_round.hands_left)
				-- Show new Target *ontop* of the Joker:
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					blocking = false,
					func = function()
						--card:juice_up(0.2, (math.random() < 0.5) and 0.2 or -0.2)
						--play_sound('generic1')
						attention_text({
							text = tostring(card.ability.extra.target),
							backdrop_colour = G.C.BUF_SPC, scale = 1.2, hold = 1.5,
							major = card, align = 'cm', offset = { x = 0, y = 0 }
						})
						return true
					end
				}))
				return { message = localize('k_active_ex') }
			end
			if context.first_hand_drawn or context.after then
				-- Will jiggle when the current hand is relevant
				local eval = function()
					return card.ability.extra.target ~= 0 and G.GAME.current_round.hands_played == (card.ability.extra.target - 1)
				end
				juice_card_until(card, eval, true)
			end
			if context.end_of_round and context.main_eval and context.game_over == false then
				if card.ability.extra.target == G.GAME.current_round.hands_played then
					card.ability.extra.success = true
				end
				card.ability.extra.target = 0
				if card.ability.extra.success then
					return {
						message = localize('buf_hit'),
						colour = G.C.GREEN,
						sound = 'buf_roul2',
						volume = 0.5
					}
				else
					return {
						message = localize('buf_miss'),
						colour = G.C.RED,
						sound = 'buf_roul1',
						volume = 0.8
					}
				end
			end
		end
    end,
	calc_dollar_bonus = function(self, card)
		if card.ability.extra.success then
			card.ability.extra.success = false
			return (card.ability.extra.money)
		end
	end
}

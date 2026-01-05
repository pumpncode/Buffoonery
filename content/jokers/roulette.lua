SMODS.Joker {
    key = "roulette",
    name = "Russian Roulette",
    atlas = 'buf_jokers',
	pos = { x = 7, y = 0 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    rarity = 2,
    cost = 6,
	config = {
		extra = {
			money = 15, money_mod = 5,
			chance = 6, chance_mod = 1,
			alt_pos = { x = 7, y = 1 }
		}
	},
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.chance, 'buf_roulette')
		return { vars = {
			numerator, denominator,
			card.ability.extra.money
		} }
	end,
    calculate = function(self, card, context)
		if context.setting_blind and not (self.getting_sliced or context.blueprint) then
			-- Initial Animate
			G.E_MANAGER:add_event(Event({
				func = function()
					card:juice_up(0.2, 0.2)
					return true
				end
			}))
			if SMODS.pseudorandom_probability(card, 'buf_roulette', 1, card.ability.extra.chance) then
				-- Animate
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.5, --> A lil' extra Tension
					func = function()
						-- Effect & Sound
						card:juice_up(0.8, 0.5)
						play_sound('buf_roul2', 0.96 + math.random() * 0.08, 0.5)
						-- Set Texture (Single time)
						card.children.center:set_sprite_pos(card.ability.extra.alt_pos)
						-- Raw Message
						attention_text({
							text = localize('buf_ydead'),
							backdrop_colour = G.C.RED,
							scale = 0.8, hold = 1.0,
							major = card, align = 'bm',
							offset = { x = 0, y = 0 }
						})
						return true
					end
				}))
				-- "End Run" --> Thanks WilsontheWolf for the help! (and code!)
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.5,
					func = function()
						if G.STATE == G.STATES.SHOP then return true end --> Cancels Duplicate Events
						if G.STATE ~= G.STATES.SELECTING_HAND then return false end --> Keeps Event up till' Hand is drawn.
						G.STATE = G.STATES.HAND_PLAYED
						G.STATE_COMPLETE = true
						end_round()
						return true
					end
				}), "other" )
				delay(0.5)
				-- Destroy Joker (Bug-Fix & Prevention)
				expire_card(card) --> functions/expire.lua
			else
				-- Animate
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.5, --> A lil' extra Tension
					func = function()
						-- Effect & Sound
						card:juice_up(0.8, 0.5)
						play_sound('buf_roul1', 0.96 + math.random() * 0.08, 0.8)
						-- Raw Message
						attention_text({
							text = localize('buf_dry'),
							backdrop_colour = G.C.GREEN,
							scale = 0.8, hold = 0.5,
							major = card, align = 'bm',
							offset = { x = 0, y = 0 }
						})
						return true
					end
				}))
				if card.ability.extra.chance <= 2 then
					-- Create a Legendary (Shimmerberry "Quest"-Code):
					-- If "Legendary" is Jimbo, retry with duplicates allowed
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.5,
						func = function()
							local legend = SMODS.create_card({ set = 'Joker', legendary = true })
							if legend.config.center_key == 'j_joker' then
								legend:start_dissolve(nil, true, 0, true)
								legend = SMODS.create_card({ set = 'Joker', legendary = true, allow_duplicates = true })
							end
							legend:add_to_deck()
							G.jokers:emplace(legend)
							play_sound('timpani')
							SMODS.calculate_effect({message = localize('k_legendary'), colour = G.C.RARITY.Legendary}, legend)
							check_for_unlock { type = 'spawn_legendary' }
							return true
						end
					}))
					-- Destroy Joker (Bug-Fix & Prevention)
					expire_card(card) --> functions/expire.lua
				else
					delay(0.5)
					-- Give Money
					ease_dollars(card.ability.extra.money)
					-- Sneakily Upgrade
					G.E_MANAGER:add_event(Event({
						func = function()
							card.ability.extra.money = card.ability.extra.money + card.ability.extra.money_mod
							return true
						end
					}))
				end
			end
			-- Lower Odds with every Trigger
			card.ability.extra.chance = math.max(card.ability.extra.chance - card.ability.extra.chance_mod, 1)
		end
	end
}

SMODS.Joker {
	key = "lemmesolo",
    name = "Let Me Solo Her",
	atlas = "buf_jokers",
	pos = { x = 4, y = 1 },
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
    rarity = 3,
    cost = 8,
	no_pool_flag = 'lemmesolo_blocked', --> So it won't spawn itself.
	config = {
		extra = {
			mult = 20,
			joker = {
				amount = 5,
				upgrade = 2
			},
			can_debuff = true
		}
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.mult,
			card.ability.extra.joker.amount,
			card.ability.extra.joker.upgrade
		} }
	end,
	add_to_deck = function(self, card, from_debuff)
		-- In case this gets Copied after Destruction:
		if not from_debuff then
			card.ability.extra.can_debuff = true
		end
	end,
    calculate = function(self, card, context)
        if context.joker_main then
            return { mult = card.ability.extra.mult }
        end
		if context.end_of_round and context.main_eval and context.game_over == false
		and G.GAME.blind.boss and not context.blueprint then
			card.ability.extra.can_debuff = false --> Doesn't get Debuffed while giving other Jokers
            local jokers_to_create = math.min(card.ability.extra.joker.amount, G.jokers.config.card_limit)
			local jokers_to_upgrade = card.ability.extra.joker.upgrade
            G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
			G.GAME.pool_flags.lemmesolo_blocked = true
            G.E_MANAGER:add_event(Event({
                func = function()
					-- This code doesn't handle Jokers that take up more than 1 slot:
					-- Main reason why I didn't fix this is: I'm lazy.
                    for _ = 1, jokers_to_create do
                        SMODS.add_card {
                            set = 'Joker',
							rarity = jokers_to_upgrade > 0 and 'Rare' or nil,
                            key_append = 'buf_lemmesolo'
                        }
						jokers_to_upgrade = jokers_to_upgrade - 1
                    end
                    G.GAME.joker_buffer = G.GAME.joker_buffer - jokers_to_create
					G.GAME.pool_flags.lemmesolo_blocked = nil
                    return true
                end
            }))
            return {
                message = localize('buf_lemmesolo'),
                colour = G.C.PURPLE,
				func = function()
					expire_card(card) --> functions/expire.lua
					return true
				end
            }
		end
    end,
	update = function(self, card)
		-- Mimicking original behaviour: Will ignore other Debuff-Sources.
        if G.jokers and card.area == G.jokers then
			card.debuff = (#G.jokers.cards ~= 1) and card.ability.extra.can_debuff
		end
    end
}

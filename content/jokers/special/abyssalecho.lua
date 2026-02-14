SMODS.Joker {
    key = "abyssalecho",
    name = "Echo of The Abyss",
    atlas = 'buf_jokers',
    pos = { x = 5, y = 3 },
    unlocked = false,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = "buf_spc",
    cost = 0,
	config = {
		extra = {
			-- Logic
			mult = 0,
			mult_mod = 6,
			-- Memory
			link_id = nil
		},
		card_limit = 1,
		eternal = true,
		buf_price_mod = 0
	},
	loc_vars = function(self, info_queue, card)
		if Buffoonery.config.show_info then
			info_queue[#info_queue+1] = {set = 'Other', key = 'special_info'}
		end
		return { vars = {
			card.ability.extra.mult,
			card.ability.extra.mult_mod
		} }
	end,
    remove_from_deck = function(self, card, from_debuff)
		-- Delete Parent(s)
		if card.ability.extra.link_id and not from_debuff then
			G.E_MANAGER:add_event(Event({
				func = function()
					for index = #G.jokers.cards, 1, -1 do
						if G.jokers.cards[index].config.center.key == "j_buf_abyssalp"
						and G.jokers.cards[index].ability.extra.link_id == link_id then
							G.jokers.cards[index]:start_dissolve({HEX("9a45f5")}, nil, 2.0)
						end
					end
					return true
				end
			}))
		end
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return { mult = card.ability.extra.mult }
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

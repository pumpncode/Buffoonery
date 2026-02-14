SMODS.Joker {
    key = "dorkshire",
    name = "Dorkshire Tea",
    atlas = 'buf_jokers',
	pos = { x = 2, y = 2 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    rarity = 3,
    cost = 7,
	config = {
		extra = {
			ranks = {
				-- Vanilla
				'2', '3', '10',
				-- UnStable
				'unstb_12', 'unstb_13', 'unstb_21', 'unstb_25',
				-- Others...
				-- The Description could just show all valid ranks (2s, 3s, 10s, 12s, ...),
				-- without having to have a seperate description for every mod and combo.
			}
		}
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = { set = 'Other', key = 'porc_info' }
		if Buffoonery.compat.unstable then
            return { key = self.key .. '_alt' }
		end 
    end,
    calculate = function(self, card, context)
        if context.before and context.scoring_name == "Three of a Kind" and not context.blueprint then
			local converted = false
			for _, playing_card in ipairs(context.scoring_hand) do
				if playing_card.base.value then -- Should always be true
					for _, rank in ipairs(card.ability.extra.ranks) do
						if SMODS.Ranks[playing_card.base.value].key == rank then
							if not (SMODS.has_enhancement(playing_card, 'm_buf_porcelain') --> Ignore self
							or SMODS.has_enhancement(playing_card, 'm_buf_porcelain_g')) --> Don't transform gold
							then
								converted = true
								playing_card:set_ability(G.P_CENTERS.m_buf_porcelain, nil, true)
								G.E_MANAGER:add_event(Event({
									func = function()
										playing_card:juice_up()
										return true
									end
								}))
							end
							break
						end
					end
				end
			end
			if converted then SMODS.calculate_effect({ message = localize('buf_tea'), colour = G.C.GREEN }, card) end
        end
    end
}

if Buffoonery.compat.sleeves then
SMODS.Joker {
    key = "dorkshire_g",
    name = "Dorkshire Gold",
    atlas = 'buf_jokers',
	pos = { x = 2, y = 3 },
    unlocked = false,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    rarity = 'buf_spc',
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
		info_queue[#info_queue+1] = { set = 'Other', key = 'porcg_info' }
		if Buffoonery.config.show_info then
			info_queue[#info_queue+1] = {set = 'Other', key = 'special_info'}
		end
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
							if not (SMODS.has_enhancement(playing_card, 'm_buf_porcelain_g')) --> Ignore self
							then
								converted = true
								playing_card:set_ability(G.P_CENTERS.m_buf_porcelain_g, nil, true)
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
end -- Sleeve-Check

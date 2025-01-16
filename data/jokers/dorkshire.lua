SMODS.Joker {
    key = "dorkshire",
    name = "Dorkshire Tea",
    atlas = 'buf_jokers',
    pos = {
        x = 4,
        y = 1,
    },
    rarity = 3,
    cost = 7,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = false,
    loc_txt = {set = 'Joker', key = 'j_buf_dorkshire'},
    calculate = function(self, card, context)
        if context.before and context.scoring_name == "Three of a Kind" and not context.blueprint then
			local tcards = {}
			for k, v in ipairs(context.scoring_hand) do
				if v:get_id() == 2 or v:get_id() == 3 or v:get_id() == 10 then 
					tcards[#tcards+1] = v
					v:set_ability(G.P_CENTERS.m_buf_porcelain, nil, true)
					G.E_MANAGER:add_event(Event({
						func = function()
							v:juice_up()
							return true
						end
					})) 
				end
			end
			SMODS.calculate_effect({message = localize('buf_tea'), colour = G.C.GREEN}, card)
        end
    end
}
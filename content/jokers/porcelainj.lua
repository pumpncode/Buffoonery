SMODS.Joker {
    key = "porcelainj",
    name = "Porcelain Joker",
	atlas = "buf_jokers",
	pos = { x = 4, y = 0 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
	config = {
		extra = {
			xchip_mod = 0.75,
			every = 3
		}
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {set = 'Other', key = 'porc_info'}
		local tally = 0
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_buf_porcelain')
			or SMODS.has_enhancement(playing_card, 'm_buf_porcelain_g')
			then tally = tally + 1 end
        end
		return { vars = {
			card.ability.extra.xchip_mod,
			card.ability.extra.every,
			1.0 + (math.floor(tally / card.ability.extra.every) * card.ability.extra.xchip_mod)
		} }
	end,
    calculate = function(self, card, context)
        if context.joker_main then
			local tally = 0
			for _, playing_card in ipairs(G.playing_cards or {}) do
				if SMODS.has_enhancement(playing_card, 'm_buf_porcelain')
				or SMODS.has_enhancement(playing_card, 'm_buf_porcelain_g')
				then tally = tally + 1 end
			end
            return {
				xchips = 1.0 + (math.floor(tally / card.ability.extra.every) * card.ability.extra.xchip_mod)
            }
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_buf_porcelain')
			or SMODS.has_enhancement(playing_card, 'm_buf_porcelain_g')
			then return true end
        end
        return false
    end
}

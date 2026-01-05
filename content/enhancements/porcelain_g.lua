local card_isfaceref = Card.is_face
function Card:is_face(from_boss)
    if self.debuff and not from_boss then return end
	if self.config.center == G.P_CENTERS.m_buf_porcelain_g then
		return true
	end
	return card_isfaceref(self, from_boss)
end

SMODS.Enhancement {
	key = "porcelain_g",
	name = "Royal Porcelain Card",
	atlas = "buf_enhancements",
	pos = { x = 1, y = 0 },
    replace_base_card = false,
    no_suit = false,
    no_rank = false,
    always_scores = false,
	in_pool = function(self, args)
		return false
    end,
	config = {
		extra = {
			Xchips = 2.0,
			limit = 3
		}
	},
	loc_vars = function(self, info_queue, card)
        return { vars = {
			card.ability.extra.Xchips,
			card.ability.extra.limit
		} }
    end,
	calculate = function(self, card, context, ret)
		if context.cardarea == G.play and context.main_scoring then
			return { xchips = card.ability.extra.Xchips }
		end
        if context.destroy_card and (context.cardarea == G.play or context.cardarea == 'unscored')
		and (#context.full_hand or 0) > card.ability.extra.limit and context.destroy_card == card
		then
			context.destroy_card.shattered = true
            return { remove = true }
        end
	end,
	-- HIDE CARD IN COLLECTION (THANKS, EREMEL) --
	inject = function(self)
		if not Buffoonery.config.show_spc then
			SMODS.Joker.super.inject(self)
			--SMODS.Enhancement.super.inject(self)
			G.P_CENTER_POOLS.Enhanced[#G.P_CENTER_POOLS.Enhanced] = nil
		else
			SMODS.Enhancement.super.inject(self)
		end
	end
}

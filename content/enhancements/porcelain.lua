SMODS.Enhancement {
	key = "porcelain",
	name = "Porcelain Card",
	atlas = "buf_enhancements",
	pos = { x = 0, y = 0 },
    replace_base_card = false,
    no_suit = false,
    no_rank = false,
    always_scores = false,
	config = {
		extra = {
			Xchips = 1.75,
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
	end
}

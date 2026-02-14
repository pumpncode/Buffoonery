SMODS.Joker {
    key = "cashout",
    name = "Cashout Voucher",
    atlas = 'buf_jokers',
	pos = { x = 0, y = 1 },
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
    rarity = 1,
    cost = 2,
	config = {
		extra = {
			money = 4, --> 0.004
			limits = { score = 3, money = 50 }
		}
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { math.floor(card.ability.extra.money + 0.5) / 10 } }
	end,
    calculate = function(self, card, context)
		if context.after and not context.blueprint then
			local hand_score = hand_chips * mult
			local req_chips = G.GAME.blind.chips
			if Buffoonery.compat.talisman then
				hand_score = to_number(hand_score)
				req_chips = to_number(req_chips)
			end
			if hand_score >= card.ability.extra.limits.score * req_chips then
				local earned = hand_score * card.ability.extra.money / 1000 + 0.5
				if Buffoonery.compat.talisman then earned = to_number(earned) end
				earned = math.floor(math.min(earned, card.ability.extra.limits.money))
				expire_card(card) --> functions/expire.lua
				return { dollars = earned }
			end
		end
	end
}

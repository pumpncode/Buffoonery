SMODS.Joker {
    key = "supportive",
    name = "Supportive Joker",
	atlas = "buf_jokers",
	pos = { x = 4, y = 3 },
    unlocked = false,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = "buf_spc",
    cost = 6,
	config = {
		extra = {
			xchips = 4.0
		}
	},
	loc_vars = function(self, info_queue, card)
		if Buffoonery.config.show_info then
			info_queue[#info_queue+1] = {set = 'Other', key = 'special_info'}
		end
		if G.deck and G.GAME.blind and G.GAME.blind.in_blind then
			local scry_cards = {} -- ex. { id = 13, rank = 'King', suit = 'Spades', text = 'King of Spades' }
			for index = 0, 2 do --> 3 cards
				if G.deck.cards[#G.deck.cards - index] then
					local scry = {}
					scry.id = G.deck.cards[#G.deck.cards - index].base.id
					scry.rank = G.deck.cards[#G.deck.cards - index].base.value
					scry.suit = G.deck.cards[#G.deck.cards - index].base.suit
					if scry.rank and scry.suit then
						scry.text = localize(scry.rank, 'ranks')..localize('buf_of')..localize(scry.suit, 'suits_plural')
					end
					scry_cards[#scry_cards + 1] = scry
				end
			end
			return { key = self.key .. '_alt', vars = {
				card.ability.extra.xchips,
				-- Can technically support an endless amount with "main_end"
				(scry_cards[1] and scry_cards[1].text or localize('k_none')), --> "Topmost" Card
				(scry_cards[2] and scry_cards[2].text or localize('k_none')), --> Second Card
				(scry_cards[3] and scry_cards[3].text or localize('k_none')), --> Third Card
			} }
		else
			return { vars = { card.ability.extra.xchips } }
		end
	end,
    calculate = function(self, card, context)
        if context.joker_main then
            return { xchips = card.ability.extra.xchips }
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

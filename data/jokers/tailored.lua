SMODS.Joker {
    key = "tailored",
    name = "Tailored Suit",
    atlas = 'buf_jokers',
    pos = {
        x = 7,
        y = 3,
    },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {
        extra = { init_xmult = 4, xmult = 1, tsuit = '-', percent = 0, suit_counts = {} },
    },
    loc_txt = {set = 'Joker', key = 'j_buf_tailored'},
    loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.extra.init_xmult, card.ability.extra.xmult, card.ability.extra.tsuit}
        }
    end,
	update = function(self, card, context)
		if G.playing_cards then -- prevents a crash when looking at this joker's page in the collection
			-- Count occurrences of each suit
			for k in pairs(card.ability.extra.suit_counts) do
				card.ability.extra.suit_counts[k] = nil
			end
			for k, v in ipairs(G.playing_cards) do
				local suit = SMODS.Suits[v.base.suit].key
				if suit then
					card.ability.extra.suit_counts[suit] = (card.ability.extra.suit_counts[suit] or 0) + 1
				end
			end
			
			-- Calculate percentages
			local leng = 0
			for _ in pairs(card.ability.extra.suit_counts) do -- manually counts the length of the suit_counts table
				leng = leng + 1
			end
			for suit, count in pairs(card.ability.extra.suit_counts) do
				local percentage = (count / #G.playing_cards)
				if percentage > card.ability.extra.percent then
					card.ability.extra.percent = percentage
					if card.ability.extra.percent == 1/leng then  -- If all suits have the same amount of cards, it'll say the deck is 'uniform'
						card.ability.extra.tsuit = localize('buf_uniform')
					else
						card.ability.extra.tsuit = suit
					end
				end
			end
		
			-- Apply percentage to xmult
			card.ability.extra.xmult = card.ability.extra.percent * card.ability.extra.init_xmult
		else
			card.ability.extra.xmult = 1  -- Shows X1 xmult as current in the collection, alluding to the fact that the initial deck is (likely) uniform
		end
	end, 
    calculate = function(self, card, context)
		if context.joker_main then
			return {
                xmult = card.ability.extra.xmult
            }
		end
    end
}
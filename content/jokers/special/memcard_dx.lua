if Buffoonery.compat.sleeves then
SMODS.Joker {
    key = "dxmemcard",
    name = "Deluxe Memory Card",
    atlas = 'buf_jokers',
    pos = { x = 0, y = 3 },
    pixel_size = { w = 71, h = 83.354 },
    unlocked = false,
    discovered = false,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
    rarity = 'buf_spc',
    cost = 8,
	config = {
		extra = {
			-- Last Card
			tsuit = "-",
			trank = "-",
			-- Memory
			mem_max = 16,
			memory = {}
		}
	},
    loc_txt = {set = 'Joker', key = 'j_buf_memcard'},
	loc_vars = function(self, info_queue, card)
		if Buffoonery.config.show_info then
			info_queue[#info_queue+1] = {set = 'Other', key = 'special_info'}
		end
		return { vars = {
			(card.ability.extra.memory and #card.ability.extra.memory or 0),
			card.ability.extra.tsuit, 
			card.ability.extra.trank,
			card.ability.extra.mem_max
		} }
	end,
    calculate = function(self, card, context)
		-- MEMORIZE FIRST SCORING CARD
		if context.before and not context.blueprint then
			if (card.ability.extra.memory and #card.ability.extra.memory or 0) < card.ability.extra.mem_max then
				-- Create Memory
				local memory_object = {}
				memory_object.base = context.scoring_hand[1].config.card
				memory_object.ability = context.scoring_hand[1].config.center
				memory_object.edition = context.scoring_hand[1].edition
				memory_object.seal = context.scoring_hand[1].seal
				if context.scoring_hand[1].params then -- Safety-Check
					memory_object.params = context.scoring_hand[1].params
				end
				-- Save Memory
				card.ability.extra.memory[#card.ability.extra.memory+1] = memory_object
				
				-- Keep Track of last saved Object
				card.ability.extra.tsuit = localize((SMODS.Suits[context.scoring_hand[1].base.suit].key or 'Spades'), 'suits_plural') --suits_singular
				card.ability.extra.trank = localize((SMODS.Ranks[context.scoring_hand[1].base.value].key or 'King'), 'ranks') .. localize('buf_of')
				
				return { message = localize('buf_memory'), colour = G.C.GREEN }
			else
				return { message = localize('buf_memfull'), colour = G.C.RED }
			end
		end
		-- CONVERT INTO MEMORIZED CARDS WHEN SELLING
		if context.selling_self and #G.hand.cards ~= 0 and not context.blueprint then
			local mem_count = math.min((card.ability.extra.memory and #card.ability.extra.memory or 0), #G.hand.cards)
			if mem_count ~= 0 then
				for i = 1, mem_count do
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.05,
						func = function()
							G.hand.cards[i]:flip()
							play_sound('card1', 1.15)
							return true 
						end
					}))
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.05,
						func = function()
							-- Convert Card
							local mem_write = G.hand.cards[i]
							mem_write:set_base(card.ability.extra.memory[i].base)
							mem_write:set_ability(card.ability.extra.memory[i].ability)
							mem_write:set_edition(card.ability.extra.memory[i].edition or {}, nil, true)
							mem_write:set_seal(card.ability.extra.memory[i].seal, true)
							if card.ability.extra.memory[i].params then
								mem_write.params = card.ability.extra.memory[i].params
							else mem_write.params = {} end
							mem_write.params.playing_card = playing_card
							-- Animation stuff
							play_sound('tarot2', percent, 0.6)
							G.hand.cards[i]:juice_up(0.3, 0.3)
							return true 
						end
					}))
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.05,
						func = function()
							G.hand.cards[i]:flip()
							play_sound('tarot2', 0.85, 0.6)
							return true 
						end
					}))
				end
			end
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

SMODS.Joker {
	key = "maggit",
    name = "Maggit",
	atlas = "buf_jokers",
	pos = { x = 6, y = 0 },
	soul_pos = { x = 6, y = 1 },
    unlocked = false,
    unlock_condition = {hidden = true},
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = 4,
    cost = 20,
	config = {
		extra = {
			emult = 1.5,
			created = false
		}
	},
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {set = 'Other', key = 'maggit_info'} --> Changed: Will always be shown.
		return {
			key = self.key .. (card.ability.extra.created and '_alt' or ''),
			vars = { card.ability.extra.emult }
		}
	end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			-- New Copies can create new Cards:
			card.ability.extra.created = false
		end
    end,
    calculate = function(self, card, context)
        if context.joker_main then
			for index = 1, #G.jokers.cards do
				if G.jokers.cards[index].config.center.pools
				and (G.jokers.cards[index].config.center.pools.Numetal or G.jokers.cards[index].config.center.pools.Numetal_Special)
				then return { emult = card.ability.extra.emult } end
			end
        end
		if context.setting_blind and not (card.ability.extra.created) and not (context.blueprint or self.getting_sliced)
		and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
			for index = 1, #G.jokers.cards do
				if G.jokers.cards[index].config.center.pools
				and (G.jokers.cards[index].config.center.pools.Numetal or G.jokers.cards[index].config.center.pools.Numetal_Special)
				then return end --> Exit
			end
			card.ability.extra.created = true
			G.GAME.joker_buffer = (G.GAME.joker_buffer or 0) + 1
			G.E_MANAGER:add_event(Event({
				func = function()
					G.GAME.joker_buffer = G.GAME.joker_buffer - 1
					SMODS.add_card({ set = 'Numetal', allow_duplicates = true })
					play_sound('tarot2')
					return true 
				end
			}))
			return {
				message = localize('k_plus_joker'),
				colour = G.C.BLUE
			}
		end
    end
}

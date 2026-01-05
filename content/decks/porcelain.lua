SMODS.Back{
    key = 'porcelain',
    unlocked = true,
    discovered = true,
    atlas = 'buf_decks',
    pos = { x = 2, y = 0 },
    config = {
		extra = {
			suits = { 'Clubs', 'Diamonds', 'Hearts', 'Spades' }
		}
	},
	loc_vars = function(self, info_queue, back)
		return { vars = {
			localize{type = 'name_text', key = 'j_buf_dorkshire', set = 'Joker'}
		} }
	end,
    apply = function(self)
		if not (G.GAME.selected_sleeve and G.GAME.selected_sleeve == 'sleeve_buf_porcelain') then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.8,
				func = function()
					-- Add Joker
					play_sound('timpani')
					SMODS.add_card({
						key = 'j_buf_dorkshire',
						no_edition = true
					})
					-- Modify Deck
					local target_suit = pseudorandom_element(self.config.extra.suits)
					local keys_to_remove = {}
					for _, card in pairs(G.playing_cards) do
						if card.base.suit == target_suit then
							table.insert(keys_to_remove, card)
						end
					end
					for i = 1, #keys_to_remove do
						keys_to_remove[i]:remove()
					end
					G.GAME.starting_deck_size = #G.playing_cards
					return true
				end
			}))
		end
    end
}

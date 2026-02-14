CardSleeves.Sleeve {
    key = 'porcelain',
    unlocked = false,
    unlock_condition = { deck = "b_buf_porcelain", stake = "stake_orange" },
    atlas = 'buf_sleeves',
    pos = { x = 2, y = 0 },
    config = {
		extra = {
			suits = { 'Clubs', 'Diamonds', 'Hearts', 'Spades' }
		}
	},
    loc_vars = function(self)
        if self.get_current_deck_key() == "b_buf_porcelain" then
			return { key = self.key .. '_alt', vars = {
				localize{type = 'name_text', key = 'j_buf_dorkshire_g', set = 'Joker'}
			} }
        else
			return { vars = {
				localize{type = 'name_text', key = 'j_buf_dorkshire', set = 'Joker'}
			} }
		end
    end,
    apply = function(self)
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.8,
			func = function()
				-- Add Joker
				play_sound('timpani')
				if self.get_current_deck_key() == "b_buf_porcelain" then
					SMODS.add_card({ key = 'j_buf_dorkshire_g', no_edition = true })
				else
					SMODS.add_card({ key = 'j_buf_dorkshire', no_edition = true })
				end
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
}

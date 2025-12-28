CardSleeves.Sleeve {
    key = "galloping",
    unlocked = false,
    unlock_condition = { deck = "b_buf_galloping", stake = "stake_green" },
    atlas = 'buf_sleeves',
    pos = { x = 1, y = 0 },
	config = {
		extra = {
			hands = -2
		}
	},
    loc_vars = function(self)
        if self.get_current_deck_key() == "b_buf_galloping" then
			return { key = self.key .. '_alt', vars = {
				localize{type = 'name_text', key = 'j_buf_whitepony', set = 'Joker'}
			} }
        else
			return { vars = {
				localize{type = 'name_text', key = 'j_buf_blackstallion', set = 'Joker'}
			} }
		end
    end,
    apply = function(self)
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.8,
			func = function()
				if self.get_current_deck_key() == "b_buf_galloping" then
					-- Give special Joker
					play_sound('timpani')
					SMODS.add_card({
						key = 'j_buf_whitepony',
						no_edition = true
					})
					-- Reduce Hands (Animated)
					G.GAME.round_resets.hands = G.GAME.round_resets.hands + self.config.extra.hands
					G.GAME.starting_params.hands = G.GAME.starting_params.hands + self.config.extra.hands
					G.GAME.current_round.hands_left = G.GAME.current_round.hands_left + self.config.extra.hands
				else
					-- Give normal Joker
					play_sound('timpani')
					SMODS.add_card({
						key = 'j_buf_blackstallion',
						no_edition = true
					})
				end
				return true
			end
		}))
    end
}

CardSleeves.Sleeve {
    key = 'jstation',
    unlocked = false,
    unlock_condition = { deck = "b_buf_jstation", stake = "stake_blue" },
    atlas = 'buf_sleeves',
    pos = { x = 0, y = 0 },
    loc_vars = function(self)
        if self.get_current_deck_key() == "b_buf_jstation" then
			return { key = self.key .. '_alt', vars = {
				localize{type = 'name_text', key = 'j_buf_dxmemcard', set = 'Joker'}
			} }
        else
			return { vars = {
				localize{type = 'name_text', key = 'j_buf_memcard', set = 'Joker'}
			} }
		end
    end,
    apply = function(self)
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.8,
			func = function()
				G.hand:change_size(1)
				play_sound('timpani')
				if self.get_current_deck_key() == "b_buf_jstation" then
					SMODS.add_card({ key = 'j_buf_dxmemcard', no_edition = true })
				else
					SMODS.add_card({ key = 'j_buf_memcard', no_edition = true })
				end
				return true
			end
		}))
    end
}

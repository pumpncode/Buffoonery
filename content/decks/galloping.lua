SMODS.Back{
    key = 'galloping',
    unlocked = false,
	unlock_condition = { type = 'ante_up', ante = 10 },
    atlas = 'buf_decks',
    pos = { x = 1, y = 0 },
	loc_vars = function(self, info_queue, back)
		return { vars = {
			localize{type = 'name_text', key = 'j_buf_blackstallion', set = 'Joker'}
		} }
	end,
    apply = function(self)
		if not (G.GAME.selected_sleeve and G.GAME.selected_sleeve == 'sleeve_buf_galloping') then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.8,
				func = function()
					play_sound('timpani')
					SMODS.add_card({
						key = 'j_buf_blackstallion',
						no_edition = true
					})
					return true
				end
			}))
		end
    end
}

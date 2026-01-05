SMODS.Back{
    key = 'jstation',
    unlocked = true,
    discovered = true,
    atlas = 'buf_decks',
    pos = { x = 0, y = 0 },
	loc_vars = function(self, info_queue, back)
		return { vars = {
			localize{type = 'name_text', key = 'j_buf_memcard', set = 'Joker'}
		} }
	end,
    apply = function(self)
		if not (G.GAME.selected_sleeve and G.GAME.selected_sleeve == 'sleeve_buf_jstation') then
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.8,
				func = function()
					G.hand:change_size(1)
					play_sound('timpani')
					SMODS.add_card({
						key = 'j_buf_memcard',
						no_edition = true
					})
					return true
				end
			}))
		end
    end
}

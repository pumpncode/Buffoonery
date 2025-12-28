SMODS.Back{
    key = 'sandstone',
    unlocked = false,
	unlock_condition = {type = 'win_stake', stake = Buffoonery.compat.bunco and 13 or 10},
    atlas = 'buf_decks',
    pos = { x = 3, y = 0 },
    config = {
		extra = {
			ante_mod = 0.75,
			scaling_mod = 2.0
		}
	},
	loc_vars = function(self, info_queue, back)
		return { vars = {
			(1 - self.config.extra.ante_mod) * 100,
			self.config.extra.scaling_mod
		} }
	end,
    apply = function(self)
		if not (G.GAME.selected_sleeve and G.GAME.selected_sleeve == 'sleeve_buf_sandstone') then
			G.GAME.win_ante = math.floor(G.GAME.win_ante * self.config.extra.ante_mod + 0.5)
			G.GAME.starting_params.ante_scaling = (G.GAME.starting_params.ante_scaling or 1) * self.config.extra.scaling_mod
		end
    end
}

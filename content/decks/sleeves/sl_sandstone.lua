CardSleeves.Sleeve {
    key = 'sandstone',
    unlocked = false,
    unlock_condition = { deck = "b_buf_sandstone", stake = "stake_buf_palladium" },
    atlas = 'buf_sleeves',
    pos = { x = 3, y = 0 },
	config = {
		extra = {
			normal = { ante_mod = 0.75, scaling_mod = 2.0 },
			sleeve = { ante_mod = 0.625, scaling_mod = 3.0 }
		}
	},
    loc_vars = function(self)
        if self.get_current_deck_key() == "b_buf_sandstone" then
			return { key = self.key .. '_alt', vars = {
				(1 - self.config.extra.sleeve.ante_mod) * 100,
				self.config.extra.sleeve.scaling_mod
			} }
        else
			return { vars = {
				(1 - self.config.extra.normal.ante_mod) * 100,
				self.config.extra.normal.scaling_mod
			} }
		end
    end,
    apply = function(self)
		if self.get_current_deck_key() == "b_buf_sandstone" then
			G.GAME.win_ante = math.floor(G.GAME.win_ante * self.config.extra.sleeve.ante_mod + 0.5)
			G.GAME.starting_params.ante_scaling = (G.GAME.starting_params.ante_scaling or 1) * self.config.extra.sleeve.scaling_mod
		else
			G.GAME.win_ante = math.floor(G.GAME.win_ante * self.config.extra.normal.ante_mod + 0.5)
			G.GAME.starting_params.ante_scaling = (G.GAME.starting_params.ante_scaling or 1) * self.config.extra.normal.scaling_mod
		end
    end
}

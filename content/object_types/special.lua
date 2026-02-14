-- Special
SMODS.Rarity{
	key = "spc",
	loc_txt = { name = localize('k_buf_spc') },
	badge_colour = HEX('ee8f8d'),
	pools = { ["Joker"] = false },
	get_weight = function(self, weight, object_type)
		return weight
	end
}

Buffoonery.config_tab = function()
	return {n = G.UIT.ROOT, config = {r = 0.1, minw = 4, align = "tm", padding = 0.2, colour = G.C.BLACK}, nodes = {
		{ n=G.UIT.R, config = {align = 'cm'}, nodes={
			create_toggle({label = localize('buf_cf_show_spc'), ref_table = Buffoonery.config, info = localize('buf_cf_req_restart'), ref_value = 'show_spc', active_colour = Buffoonery.badge_colour, right = true}),
			{n=G.UIT.R, config={ align = "cm", padding = 0.25 }},
			create_toggle({label = localize('buf_cf_show_info'), ref_table = Buffoonery.config, info = localize('buf_cf_info_info'), ref_value = 'show_info', active_colour = Buffoonery.badge_colour, right = true}),
		}},
	}}
end

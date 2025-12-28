SMODS.Consumable {
    key = "nobility",
	name = "Nobility",
    set = "Tarot",
	atlas = "buf_consumables",
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            --count = 1,
			royal = 50
        }
    },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = {set = 'Other', key = 'porc_info'} --G.P_CENTERS.m_buf_porcelain
		info_queue[#info_queue + 1] = {set = 'Other', key = 'porcg_info'} --G.P_CENTERS.m_buf_porcelain_g
		return { vars = {
			--card and card.ability.extra.count or self.config.extra.count,
			card and card.ability.extra.royal or self.config.extra.royal
		} }
	end,
	set_card_type_badge = function(self, card, badges)
        badges[1] = create_badge(localize("k_tarot").."!?", get_type_colour(self or card.config, card), nil, 1.2)
    end,
	use = function(self, card, area, copier)
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.4,
			func = function()
				play_sound('tarot1')
				card:juice_up(0.3, 0.5)
				return true
			end
		}))
		
		local newcenter = 'm_buf_porcelain'
		local gmoney = G.GAME.dollars
		if Buffoonery.compat.talisman then gmoney = to_number(gmoney) end
		if gmoney >= card.ability.extra.royal then
			newcenter = newcenter..'_g'
		end
		
		-- Modified from Kirbio's UnStable Mod
		-- With permission, thanks Kirbio!
		for i=1, #G.hand.highlighted do
			local percent = 1.15 - (i-0.999)/(#G.hand.highlighted-0.998)*0.3
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					G.hand.highlighted[i]:flip()
					play_sound('card1', percent)
					G.hand.highlighted[i]:juice_up(0.3, 0.3)
					return true
				end
			}))
		end
		delay(0.2)
		for i=1, #G.hand.highlighted do
			local percent = 0.85 + (i-0.999)/(#G.hand.highlighted-0.998)*0.3
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.1,
				func = function()
					G.hand.highlighted[i]:set_ability(G.P_CENTERS[newcenter])
					return true
				end
			}))
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.15,
				func = function()
					G.hand.highlighted[i]:flip()
					play_sound('tarot2', percent, 0.6)
					G.hand.highlighted[i]:juice_up(0.3, 0.3)
					return true
				end
			}))
		end
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.2,
			func = function()
				G.hand:unhighlight_all()
				return true
			end
		}))
		delay(0.5)
	end,
	can_use = function(self, card)
		return G.hand and #G.hand.highlighted == 1 --(card.ability.extra.count or 1)
	end
}

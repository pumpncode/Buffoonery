local saya_powers = {
	['0'] = {
		retfunc = { chips = 40 },
		lvl = '0', next_lvl = '1',
		need = 1, score = 5000,
		pos = { x = 8 , y = 0 }
	},
	['1'] = {
		retfunc = { mult = 20 },
		lvl = '1', next_lvl = '2',
		need = 3, score = 50000,
		pos = { x = 8 , y = 1 }
	},
	['2'] = {
		retfunc = { xmult = 3.0 },
		lvl = '2', next_lvl = '3',
		need = 5, score = 100000,
		pos = { x = 8 , y = 2 }
	},
	['3'] = {
		retfunc = { emult = 1.3 },
		lvl = '3', next_lvl = 'MAX',
		need = 0, score = 0,
		pos = { x = 8 , y = 3 }
	},
}

local function buf_saya_power(key)
	-- Default Fallback is "Lvl. 1"
	if key then return saya_powers[key] or saya_powers['1']
	else return buf_kerman_atlas['1'] end
end

SMODS.Joker {
    key = "sayajimbo",
    name = "Sayajimbo",
	atlas = "buf_jokers",
	pos = { x = 8, y = 0 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
	config = {
		extra = {
			power = buf_saya_power('0'),
			progress = 0
		}
	},
	loc_vars = function(self, info_queue, card)
		-- Get Current Value
		local current_power_value = '--'
		for ret_type, ret_value in pairs(card.ability.extra.power.retfunc) do
			--print(ret_type); print(ret_value);
			if ret_type and ret_type ~= "colour" then
			--	current_power_type = ret_type    --> ex: "chips"
				current_power_value = ret_value  --> ex: "40"
				break
			end
		end
		-- Get Next Value (if possible)
		local next_power_value = '--'
		if card.ability.extra.power.next_lvl ~= 'MAX' then
			local next_power = buf_saya_power(card.ability.extra.power.next_lvl)
			for next_type, next_value in pairs(next_power.retfunc) do
				if next_type and next_type ~= "colour" then
					next_power_value = next_value
					break
				end
			end
		end
		-- Return State
		return {
			key = self.key..(card.ability.extra.power.lvl ~= '0' and '_s'..card.ability.extra.power.lvl or ''),
			vars = {
				-- Current Ability
				current_power_value,
				-- Progress
				card.ability.extra.power.score,
				card.ability.extra.power.need,
				card.ability.extra.progress,
				-- Next Ability
				next_power_value
			}
		}
	end,
	load = function(self, card, card_table, other_card)
		G.E_MANAGER:add_event(Event({
			func = function()
				if card.ability.extra.power and card.ability.extra.power.pos then
					card.children.center:set_sprite_pos(card.ability.extra.power.pos)
				end
				return true
			end
		}))
	end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			if card.ability.extra.power and card.ability.extra.power.pos then
				card.children.center:set_sprite_pos(card.ability.extra.power.pos)
			end
		end
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return card.ability.extra.power.retfunc
        end
		if context.after and not context.blueprint then
			-- Simple check if there's even a next level;
			if card.ability.extra.power.next_lvl ~= 'MAX' then
				local hand_score = hand_chips * mult
				if Buffoonery.compat.talisman then
					hand_score = to_number(hand_score)
				end
				if hand_score >= card.ability.extra.power.score then
					card.ability.extra.progress = card.ability.extra.progress + 1
					if card.ability.extra.progress >= card.ability.extra.power.need then
						-- Level Up
						card.ability.extra.power = buf_saya_power(card.ability.extra.power.next_lvl)
						card.ability.extra.progress = 0
						-- Flip
						G.E_MANAGER:add_event(Event({ func = function() card:flip() return true end }))
						-- Texture + Animate & Flip
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.3,
							func = function()
								card.children.center:set_sprite_pos(card.ability.extra.power.pos)
								-- Animate (Wiggle + Flip)
								play_sound('buf_emult', 1.0, 0.6)
								card:juice_up(0.3, 0.3)
								card:flip()
								return true
							end
						}))
						-- Return
						return {
							message = localize('k_upgrade_ex'),
							colour = G.C.BUF_SPC
						}
					else
						return {
							message = card.ability.extra.progress..'/'..card.ability.extra.power.need,
							colour = G.C.DARK_EDITION
						}
					end
				end
			end
		end
    end
}

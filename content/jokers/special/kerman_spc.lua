-- The Kermans could also share one non-local Atlas, when this Kerman offsets the "x" by 3.
local buf_reborn_atlas = {
	-- Default
	['Default']  = { x = 5, y = 4 },
	-- Vanilla
	['Mercury']  = { x = 5, y = 5 },
	['Venus']    = { x = 5, y = 6 },
	['Earth']    = { x = 5, y = 7 },
	['Mars']     = { x = 5, y = 8 },
	['Jupiter']  = { x = 6, y = 4 },
	['Saturn']   = { x = 6, y = 5 },
	['Uranus']   = { x = 6, y = 6 },
	['Neptune']  = { x = 6, y = 7 },
	['Pluto']    = { x = 6, y = 8 },
	['Planet X'] = { x = 7, y = 4 },
	['Ceres']    = { x = 7, y = 5 },
	['Eris']     = { x = 7, y = 6 },
	-- Unknown (by Flowire)
	['Unknown']  = { x = 7, y = 8 },
	-- Modded
	--Free: {x = 7, y = 7}
}

local function buf_reborn_texture(key)
	if key then return buf_reborn_atlas[key] or buf_reborn_atlas['Unknown']
	else return buf_reborn_atlas['Default'] end
end

SMODS.Joker { -- Evil Jeb
    key = "kerman_spc",
    name = "Jebediah Reborn",
	atlas = "buf_jokers",
	pos = buf_reborn_texture(),
    unlocked = false,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = 'buf_spc',
    cost = 4,
	config = {
		extra = {
			mult = 0,
			mult_mod = 8,
			mult_xmod = 0.25,
			-- Texture & Flair
			pos_overwrite = buf_reborn_texture(),
			spawned = true --> Yap first Spawn
		}
	},
	loc_vars = function(self, info_queue, card)
		if Buffoonery.config.show_info then
			info_queue[#info_queue+1] = {set = 'Other', key = 'special_info'}
		end
		return { vars = {
			card.ability.extra.mult,
			card.ability.extra.mult_mod,
			card.ability.extra.mult_xmod * 100
		} }
	end,
	load = function(self, card, card_table, other_card)
		-- Just load Texture.
		G.E_MANAGER:add_event(Event({
			func = function()
				if card.ability.extra.pos_overwrite then
					card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
				end
				return true
			end
		}))
	end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			card.ability.extra.pos_overwrite = buf_reborn_texture('Default')
			card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
			-- Pure Visual Flair
			if card.ability.extra.spawned then
				card.ability.extra.spawned = nil
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						SMODS.calculate_effect({
							message = localize('buf_krakened'),
							colour = G.C.BUF_SPC
						}, card)
						card:juice_up(0.8, 0.8)
						return true
					end
				}))
			end
		end
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return { mult = card.ability.extra.mult }
        end
        if context.using_consumeable and not context.blueprint then
			if context.consumeable.ability.set == 'Planet' then
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
				-- Texture + Animate
				G.E_MANAGER:add_event(Event({
					func = function()
						card.ability.extra.pos_overwrite = buf_reborn_texture(context.consumeable.ability.name)
						card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
						play_sound('tarot2')
						card:juice_up(0.75, 0.5)
						return true
					end
				}))
				return {
					message = localize('k_upgrade_ex'),
					colour = G.C.MULT
				}
			elseif context.consumeable.ability.name == 'Black Hole' then
				card.ability.extra.mult = card.ability.extra.mult * (1.0 + card.ability.extra.mult_xmod)
				-- Texture + Animate
				G.E_MANAGER:add_event(Event({
					func = function()
						card.ability.extra.pos_overwrite = buf_reborn_texture('Default')
						card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
						play_sound('highlight2', 0.8, 0.4)
						card:juice_up(1.0, -0.5)
						return true
					end
				}))
				return {
					message = localize('buf_supergrade'),
					colour = G.C.SECONDARY_SET.Spectral
				}
			end
		end
    end,
	-- HIDE JOKER IN COLLECTION (THANKS, EREMEL) --
	inject = function(self)
		if not Buffoonery.config.show_spc then
			SMODS.Joker.super.inject(self)
			G.P_CENTER_POOLS.Joker[#G.P_CENTER_POOLS.Joker] = nil
		else
			SMODS.Joker.super.inject(self)
		end
	end
}

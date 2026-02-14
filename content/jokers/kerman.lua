-- Kerman Atlas-List is currently *not* shared.
local buf_kerman_atlas = {
	-- Default
	['Default']  = { x = 2, y = 4 },
	-- Vanilla
	['Mercury']  = { x = 2, y = 5 },
	['Venus']    = { x = 2, y = 6 },
	['Earth']    = { x = 2, y = 7 },
	['Mars']     = { x = 2, y = 8 },
	['Jupiter']  = { x = 3, y = 4 },
	['Saturn']   = { x = 3, y = 5 },
	['Uranus']   = { x = 3, y = 6 },
	['Neptune']  = { x = 3, y = 7 },
	['Pluto']    = { x = 3, y = 8 },
	['Planet X'] = { x = 4, y = 4 },
	['Ceres']    = { x = 4, y = 5 },
	['Eris']     = { x = 4, y = 6 },
	-- Unknown (by Flowire)
	['Unknown']  = { x = 4, y = 8 },
	-- Modded
	--Free: {x = 4, y = 7}
}

local function buf_kerman_texture(key)
	if key then return buf_kerman_atlas[key] or buf_kerman_atlas['Unknown']
	else return buf_kerman_atlas['Default'] end
end

SMODS.Joker { -- Jeb
    key = "kerman",
    name = "Jebediah Kerman",
	atlas = "buf_jokers",
	pos = buf_kerman_texture(),
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
	config = {
		extra = {
			mult = 0,
			mult_mod = 8,
			chance = 6,
			-- Texture
			pos_overwrite = buf_kerman_texture()
		}
	},
	loc_vars = function(self, info_queue, card)
		local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.chance, 'buf_kerman')
		return { vars = {
			card.ability.extra.mult,
			card.ability.extra.mult_mod,
			numerator, denominator
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
			card.ability.extra.pos_overwrite = buf_kerman_texture('Default')
			card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
		end
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return { mult = card.ability.extra.mult }
        end
        if context.using_consumeable and not context.blueprint then
			if context.consumeable.ability.set == 'Planet' then
				if SMODS.pseudorandom_probability(card, 'buf_kerman', 1, card.ability.extra.chance) then
					-- EMBODIES THE FULL KERBAL EXPERIENCE
					-- ... Destroy Jeb.
					G.E_MANAGER:add_event(Event({
						func = function()
							play_sound('buf_explosion')
							card:juice_up(2.0, 0.0)
							return true
						end
					}))
					expire_card(card, true) --> functions/expire.lua
					return {
						message = localize('buf_blowup'),
						colour = G.C.FILTER
					}
				else -- Upgrade Jeb
					card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
					-- Texture + Animate
					G.E_MANAGER:add_event(Event({
						func = function()
							card.ability.extra.pos_overwrite = buf_kerman_texture(context.consumeable.ability.name)
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
				end
			elseif context.consumeable.ability.name == 'Black Hole' then
				-- Also give the Mult-Bonus!
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
				-- Get Jeb Reborn with fancy Animations
				local jeb_reborn = SMODS.create_card({
					key = 'j_buf_kerman_spc',
					skip_materialize = true,
					no_edition = true
				})
				jeb_reborn:add_to_deck()
				jeb_reborn.states.visible = nil
				if card.edition then jeb_reborn:set_edition(card.edition, nil, true) end
				jeb_reborn.ability.extra.mult = jeb_reborn.ability.extra.mult + card.ability.extra.mult
				G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('magic_crumple3', math.random()*0.3 + 1.4, 0.8)
						card:start_dissolve({{0, 0, 0, 1}, {0, 0, 0, 1}}, nil, 2.0)
						G.jokers:emplace(jeb_reborn)
						jeb_reborn:start_materialize({{0, 0, 0, 1}, {0, 0, 0, 1}}, true, 2.0)
						return true
					end
				}))
				return {
					message = localize('buf_prism_eor1'),
					colour = G.C.BUF_SPC
				}
			end
		end
    end
}

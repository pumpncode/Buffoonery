local buf_tailored_atlas = {
	-- Default
	['Default']  = { x = 0, y = 4 },
	-- Vanilla
	['Spades']   = { x = 0, y = 5 },
	['Hearts']   = { x = 0, y = 6 },
	['Clubs']    = { x = 0, y = 7 },
	['Diamonds'] = { x = 0, y = 8 },
	-- Unknown (by Flowire)
	['Unknown']  = { x = 1, y = 4 },
	-- Modded
	['Stars']    = { x = 1, y = 5 },
	['Halberds'] = { x = 1, y = 6 },
	['Crowns']   = { x = 1, y = 7 },
	['Fleurons'] = { x = 1, y = 8 },
}

local function buf_tailored_texture(key)
	if key then return buf_tailored_atlas[key] or buf_tailored_atlas['Unknown']
	else return buf_tailored_atlas['Default'] end
end

local function buf_tailored_percentages()
	local ret_percent = 0.0
	local ret_suit_key = 'Default'
	local ret_pos_key = 'Default'

	if G.playing_cards then
		local suit_counts = {}
		for _, playing_card in ipairs(G.playing_cards) do
			local suit = SMODS.Suits[playing_card.base.suit].key
			if suit then suit_counts[suit] = (suit_counts[suit] or 0) + 1 end
		end

		local val_valid = false
		for suit, count in pairs(suit_counts) do
			local percent = math.floor((count / #G.playing_cards)*100)
			if percent == ret_percent then
				val_valid = false
			elseif percent > ret_percent then
				val_valid = true
				ret_percent = percent
				ret_suit_key = suit
			end
		end
		ret_percent = ret_percent / 100

		if val_valid then
			-- Texture: Try to remove mod-prefix in suit-key (using original behaviour)
			local underscore_pos = string.find(ret_suit_key, "_")
			if underscore_pos then
				ret_pos_key = string.sub(ret_suit_key, underscore_pos + 1)
			else
				ret_pos_key = ret_suit_key
			end
		else -- Reset:
			ret_suit_key = 'Default'
			ret_percent = 0.0
		end
	end

	return { ret_percent, ret_suit_key, ret_pos_key }
end

SMODS.Joker {
    key = "tailored",
    name = "Tailored Suit",
	atlas = "buf_jokers",
	pos = buf_tailored_texture(),
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
	config = {
		extra = {
			-- Effect
			xmult = 4.0,
			percent = 0.0, --> Only for "joker_main"
			suit_key = 'Default',
			-- Texture
			pos_overwrite = buf_tailored_texture()
		}
	},
	loc_vars = function(self, info_queue, card)
		local tailor = (buf_tailored_percentages() or {0, 'Default', 'Default'})
		return { vars = {
			card.ability.extra.xmult,
			math.max(card.ability.extra.xmult * tailor[1], 1.0),
			tailor[2] ~= 'Default' and localize(tailor[2], 'suits_plural') or '--'
		} }
	end,
	load = function(self, card, card_table, other_card)
		-- Load Texture
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
		local tailor = (buf_tailored_percentages() or {0, 'Default', 'Default'})
		card.ability.extra.percent = tailor[1]
		card.ability.extra.pos_overwrite = buf_tailored_texture(tailor[3])
		if from_debuff then
			if (tailor[2] ~= card.ability.extra.suit_key) then
				-- Update Texture with tiny Animation:
				G.E_MANAGER:add_event(Event({ func = function() card:flip() return true end }))
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.15,
					func = function()
						card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
						card:flip()
						return true
					end
				}))
			end
		else --> Just load new Texture:
			card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
		end
		card.ability.extra.suit_key = tailor[2]
    end,
    calculate = function(self, card, context)
        if context.joker_main then
			-- Handles the possibility of having a predominant suit with <25% dominance
            return { xmult = math.max(card.ability.extra.xmult * card.ability.extra.percent, 1.0) }
        end
		if not context.blueprint then
			-- Get accurate reading for Mult before scoring
			-- & update internal values at specific points:
			if (context.setting_blind and not self.getting_sliced) or context.before
			or context.playing_card_added or context.remove_playing_cards
			or context.starting_shop or context.ending_shop then --context.reroll_shop
				local tailor = (buf_tailored_percentages() or {0, 'Default', 'Default'})
				card.ability.extra.percent = tailor[1]
				if tailor[2] ~= card.ability.extra.suit_key then
					-- Update Texture and Announce change
					card.ability.extra.suit_key = tailor[2]
					-- Flip
					G.E_MANAGER:add_event(Event({ func = function() card:flip() return true end }))
					-- Texture + Animate & Flip
					G.E_MANAGER:add_event(Event({
						trigger = 'after',
						delay = 0.3,
						func = function()
							card.ability.extra.pos_overwrite = buf_tailored_texture(tailor[3])
							card.children.center:set_sprite_pos(card.ability.extra.pos_overwrite)
							-- Animate (Wiggle + Flip)
							play_sound('tarot2')
							card:juice_up(0.3, 0.3)
							card:flip()
							return true
						end
					}))
					return {
						message = localize('buf_suit_change'),
						colour = (tailor[2] == "Default" and G.C.RED or G.C.GREEN)
					}
				end
				return
			end
		end
    end
}

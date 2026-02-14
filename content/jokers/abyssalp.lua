SMODS.Joker {
    key = "abyssalp",
    name = "Abyssal Prism",
    atlas = 'buf_jokers',
    pos = { x = 5, y = 2 },
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = true,
    blueprint_compat = false,
    rarity = 3,
    cost = 8,
	config = {
		extra = {
			-- Logic
			every = 3,
			progress = 0,
			-- "Easy Description"
			total = 0,
			negative = 0,
			pre_negative = 0,
			-- Memory
			memory = {}, -- 1: { key, ability, edition(?), negative(?) }
			link_id = nil
		}
	},
	loc_vars = function(self, info_queue, card)
		if Buffoonery.config.show_info then
			info_queue[#info_queue+1] = {set = 'Other', key = 'banish_info'}
		end
		return { vars = {
			card.ability.extra.every,
			card.ability.extra.progress,
			card.ability.extra.negative,
			card.ability.extra.total --> Not visible.
		} }
	end,
	load = function(self, card, card_table, other_card)
		-- Juice card when full:
		G.E_MANAGER:add_event(Event({
			func = function()
				if card.ability.extra.juiced then
					local eval = function(card) return not card.REMOVED end
					juice_card_until(card, eval, true)
				end
				return true
			end
		}))
	end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			-- Juice Copy when full:
			if card.ability.extra.juiced then
				local eval = function(card) return not card.REMOVED end
				juice_card_until(card, eval, true)
			end
		end
		-- Create Echo
		--> DON'T store Echo in ability-table, makes any Prism copy hardcrash.
		local echo_card = SMODS.create_card({
			key = 'j_buf_abyssalecho',
			skip_materialize = true,
			no_edition = true
		})
		-- Store ID's:
		echo_card.ability.extra.link_id = 'echo'..card.sort_id..echo_card.sort_id
		card.ability.extra.link_id = 'echo'..card.sort_id..echo_card.sort_id
		-- Add to Deck (Step 1)
		echo_card:add_to_deck()
		echo_card.states.visible = nil
		-- Add to Deck (Step 2, with Animation)
		G.E_MANAGER:add_event(Event({
			func = function()
				card:juice_up(0.8, 0.8)
				G.jokers:emplace(echo_card)
				echo_card:start_materialize({HEX("9a45f5")}, true, 2.0)
				play_sound('buf_phase', math.random()*0.08 + 0.96)
				return true
			end
		}))
		-- Eat all other Jokers, only if
		-- you haven't already eaten Jokers:
		if not card.ability.extra.active then
			card.ability.extra.active = true
			-- Announce...
			SMODS.calculate_effect({
				message = localize("buf_prism_sck"),
				colour = G.C.DARK_EDITION
			}, card)
			-- Save Jokers
			for index = 1, #G.jokers.cards do
				-- Skip echos, otherwise they'd be orphaned later
				if not (G.jokers.cards[index].config.center.key == "j_buf_abyssalecho") then
					-- Update "Easy Description" Value
					card.ability.extra.total = card.ability.extra.total + 1
					-- Create Memory
					local memory = {} -- key, ability, edition(?), negative(?)
					memory.key = G.jokers.cards[index].config.center.key
					memory.ability = G.jokers.cards[index].ability
					if G.jokers.cards[index].edition then
						memory.edition = G.jokers.cards[index].edition
						-- Update "Easy Description" Value
						if G.jokers.cards[index].edition.negative then
							memory.negative = true --> Makes it a lil' easier
							card.ability.extra.negative = card.ability.extra.negative + 1
							card.ability.extra.pre_negative = card.ability.extra.pre_negative + 1
						end
					end
					-- Save Memory
					card.ability.extra.memory[#card.ability.extra.memory+1] = memory
				end
			end
			-- Delete Jokers (with Animation)
			for index = #G.jokers.cards, 1, -1 do
				G.GAME.joker_buffer = G.GAME.joker_buffer - 1
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.1,
					func = function()
						G.GAME.joker_buffer = G.GAME.joker_buffer + 1
						if card then card:juice_up(0.8, 0.8) end
						if G.jokers.cards[index] then G.jokers.cards[index]:start_dissolve({HEX("9a45f5")}, nil, 2.0) end
						return true
					end
				}))
			end
			-- Safety: Reset Buffer
			G.E_MANAGER:add_event(Event({ func = function() G.GAME.joker_buffer = 0 return true end }))
		end
		-- Update Echo-Mult
		echo_card.ability.extra.mult = echo_card.ability.extra.mult + (echo_card.ability.extra.mult_mod * card.ability.extra.total)
    end,
    remove_from_deck = function(self, card, from_debuff)
		-- Delete Child(ren)
		-- Even when just Debuffed
		if card.ability.extra.link_id then
			local link_id = card.ability.extra.link_id
			if from_debuff then
				--> This way, the Child doesn't destroy the Parent
				card.ability.extra.link_id = nil
			end
			G.E_MANAGER:add_event(Event({
				func = function()
					for index = #G.jokers.cards, 1, -1 do
						if G.jokers.cards[index].config.center.key == "j_buf_abyssalecho"
						and G.jokers.cards[index].ability.extra.link_id == link_id then
							G.jokers.cards[index]:start_dissolve({HEX("9a45f5")}, nil, 2.0)
						end
					end
					return true
				end
			}))
		end
    end,
    calculate = function(self, card, context)
		if not context.blueprint then
			-- Update Progress
			if context.end_of_round and context.game_over == false and context.main_eval then
				if card.ability.extra.negative < card.ability.extra.total then
					card.ability.extra.progress = card.ability.extra.progress + 1
					if card.ability.extra.progress >= card.ability.extra.every then
						card.ability.extra.progress = card.ability.extra.progress - card.ability.extra.every
						card.ability.extra.negative = card.ability.extra.negative + 1
						-- When all Jokers are Negative, Juice up:
						if card.ability.extra.negative >= card.ability.extra.total then
							card.ability.extra.juiced = true
							local eval = function(card) return not card.REMOVED end
							juice_card_until(card, eval, true)
						end
						return { message = localize("buf_prism_eor2"), colour = G.C.DARK_EDITION }
					end
					return { message = localize("buf_prism_eor1"), colour = G.C.DARK_EDITION }
				end
			end
			-- Return Jokers
			if context.selling_self then
				-- Ignore self, unless Negative
				G.GAME.joker_buffer = (G.GAME.joker_buffer or 0) - (card.edition and card.edition.negative and 0 or 1)
				-- Ignore Slots given by Negative Child(ren):
				for index = #G.jokers.cards, 1, -1 do
					if G.jokers.cards[index].config.center.key == "j_buf_abyssalecho"
					and G.jokers.cards[index].ability.extra.link_id == card.ability.extra.link_id
					and G.jokers.cards[index].edition and G.jokers.cards[index].edition.negative
					then G.GAME.joker_buffer = G.GAME.joker_buffer + 1 end
				end
				-- Finally Return Joker:
				card.ability.extra.negative = card.ability.extra.negative - card.ability.extra.pre_negative
				for index = 1, #card.ability.extra.memory do
					local memory = card.ability.extra.memory[index] --> { key, ability, edition(?), negative(?) }
					-- Spawn Joker (with Animation)
					if (#G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit)
					or (card.ability.extra.negative > 0) or memory.negative then
						-- Create Card and give back Abilities
						local memory_card = SMODS.create_card({
							key = memory.key,
							skip_materialize = true,
							no_edition = true
						})
						if card.ability.extra.negative > 0 then
							memory_card.ability = memory.ability
							card.ability.extra.negative = card.ability.extra.negative - 1
							memory_card:set_edition({ negative = true }, nil, true)
						elseif memory.negative then
							-- This is a weird Edge-Case where SMODS "+1 Area Slot"
							-- gets applied twice, unless you do it in this order:
							memory_card:set_edition({ negative = true }, nil, true)
							memory_card.ability = memory.ability
						else
							G.GAME.joker_buffer = G.GAME.joker_buffer + 1
							memory_card.ability = memory.ability
							if memory.edition then
								memory_card:set_edition(memory.edition, nil, true)
							end
						end
						-- Add to Deck (Step 1)
						memory_card:add_to_deck()
						memory_card.states.visible = nil
						-- Add to Deck (Step 2, with Animation)
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.1,
							func = function()
								--card:juice_up(0.8, 0.8)
								G.jokers:emplace(memory_card)
								memory_card:start_materialize({HEX("9a45f5")}, true, 2.0)
								play_sound('buf_phase', math.random()*0.08 + 0.96, 0.75)
								return true
							end
						}))
					end
				end
				-- Safety: Reset Buffer
				G.E_MANAGER:add_event(Event({ func = function() G.GAME.joker_buffer = 0 return true end }))
			end
		end
	end
}

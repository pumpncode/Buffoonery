-- Fixes Bunco incompatibility;
-- Bunco modifies "card_area.add_to_highlighted()"
local VanillaHighlight = CardArea.add_to_highlighted
function buf_add_to_highlighted(card, silent)
    VanillaHighlight(G.hand, card, silent)
end

SMODS.Joker {
    key = "patronizing",
    name = "Patronizing Joker",
	atlas = "buf_jokers",
	pos = { x = 4, y = 2 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = 3,
    cost = 10,
	config = {
		extra = {
			xchips = 5.0,
			hand = "Full House",
			--forced_amount = 5 --> Hardcoded
		}
	},
	loc_vars = function(self, info_queue, card)
		return { vars = {
			card.ability.extra.xchips,
			localize(card.ability.extra.hand, 'poker_hands')
		} }
	end,
	load = function(self, card, card_table, other_card)
		-- When reloading, re-select all cards
		G.E_MANAGER:add_event(Event({
			func = function()
				if G.hand.cards and #G.hand.cards ~= 0 then
					for _, playing_card in ipairs(G.hand.cards) do
						if playing_card.ability.forced_selection and not playing_card.highlighted then
							buf_add_to_highlighted(playing_card, true)
						end
					end
				end
				return true
			end
		}))
	end,
    remove_from_deck = function(self, card, from_debuff)
		-- When Removed or Debuffed, Reset:
		local bell_active = (G.GAME.blind and G.GAME.blind.in_blind and G.GAME.blind.name == 'Cerulean Bell' and not G.GAME.blind.disabled)
		G.E_MANAGER:add_event(Event({
			func = function()
				for _, playing_card in ipairs(G.hand.cards) do
					if playing_card.ability.forced_selection then
						if bell_active then
							bell_active = false --> Keep one selected
						else
							playing_card.ability.forced_selection = nil
						end
					end
				end
				G.hand:unhighlight_all()
				return true
			end
		}))
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return { xchips = card.ability.extra.xchips }
        end
		if not context.blueprint then
			-- Choose Hand:
			if context.setting_blind and not self.getting_sliced then
				-- Only Allow: Hands with exactly "5" cards, Hand called "Four of a Kind", Hand isn't last chosen Hand
				local poker_hands = {}
				for hand, attribute in pairs(G.GAME.hands) do
					if attribute.visible and hand ~= card.ability.extra.hand then
						if hand == "Four of a Kind" then
							poker_hands[#poker_hands+1] = hand
							--print("Allowed: "..hand)
						else
							local amount = 0
							if attribute.example then for index = 1, #attribute.example do
								if attribute.example[index] and attribute.example[index][2]
								then amount = amount + 1 end
							end end
							if amount == 5 then
								poker_hands[#poker_hands+1] = hand
								--print("Allowed: "..hand)
							end
						end
					end
				end
				card.ability.extra.hand = pseudorandom_element(poker_hands, pseudoseed('buf_patronizing'))
			end
			-- Transform Joker
			if context.after and context.scoring_name == card.ability.extra.hand then
				-- Doubled Event for better Timing:
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						expire_card(card) --> functions/expire.lua
						G.E_MANAGER:add_event(Event({ func = function()
							SMODS.add_card({key = 'j_buf_supportive'})
							return true
						end }))
						return true
					end
				}))
				return {
					message = localize('buf_patspc'),
					colour = G.C.BUF_SPC
				}
			end
			-- Force Select Cards
            if context.hand_drawn or (G.deck and #G.deck.cards == 0 and (context.after or context.pre_discard)) then
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					func = function()
						if G.STATE == G.STATES.SHOP then return true end
						if G.STATE ~= G.STATES.SELECTING_HAND then return false end
						-- START: Nested Event
						-- For the rare case of "#G.deck.cards == 0", because;
						-- "hand_drawn" doesn't trigger when the Deck is empty >:(
						G.E_MANAGER:add_event(Event({
							trigger = "after",
							func = function()
								-- Animate
								card:juice_up(0.8, 0.5)
								-- Vars.
								local forced_amount = 5 --> Hardcoded
								local temp_hand = {}
								-- Ignore "forced" & get Cards
								for _, playing_card in ipairs(G.hand.cards) do
									-- Let's go and ignore 'Cerulean Bell' :3
									playing_card.ability.forced_selection = nil
									-- Random Hand: Setup
									temp_hand[#temp_hand + 1] = playing_card
								end
								G.hand:unhighlight_all()
								if temp_hand[1] then
									-- Get random card-set (Immolate code):
									table.sort(temp_hand, function(a, b) return not a.playing_card or not b.playing_card or a.playing_card < b.playing_card end)
									pseudoshuffle(temp_hand, 'buf_patronizing')
									-- Force Highlight
									temp_hand[1].ability.forced_selection = true
									buf_add_to_highlighted(temp_hand[1], false) --> Makes sound (In Bell, the Sound happens twice /shrug)
									for index = 2, forced_amount do
										if temp_hand[index] then
											temp_hand[index].ability.forced_selection = true
											buf_add_to_highlighted(temp_hand[index], true)
										end
									end
								end
								--!! Save Run due to Nested Event:
								save_run()
								return true
							end
						}))
						-- END: Nested Event
						return true
					end
				}), "other" )
            end
			-- De-Select Cards @ EoR (Technically Obsolete)
			if context.end_of_round and context.main_eval and context.game_over == false then
				G.E_MANAGER:add_event(Event({
					func = function() 
						for _, playing_card in ipairs(G.hand.cards) do
							playing_card.ability.forced_selection = nil
						end
						--G.hand:unhighlight_all()
						return true
					end
				}))
			end
		end
    end
}

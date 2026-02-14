-- I know it was planned, that "Pertinent Argument" changes your Pokerhand to "Full House"...
-- But now that I think about it, I honestly don't wanna implement that Idea.
-- No, actually: I recommend NOT implementing it. :)
-- > Flowire
SMODS.Joker {
    key = "argument",
    name = "Pertinent Argument",
    atlas = 'buf_jokers',
	pos = { x = 3, y = 0 },
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = 2,
    cost = 6,
    calculate = function(self, card, context)
		-- Note: I re-build this function with 6+ played cards in mind.
		if context.before and context.scoring_name == "Two Pair" and #context.full_hand > 4 then
			-- Get all unscored cards
			local unscored_cards = {}
			for index = 1, #context.full_hand do
				if not SMODS.in_scoring(context.full_hand[index], context.scoring_hand) then
					-- Extra Support for Blueprint/Duplicate Joker:
					if context.full_hand[index].ability and not context.full_hand[index].ability.buf_argument then
						unscored_cards[#unscored_cards+1] = context.full_hand[index]
					end
				end
			end
			-- Transform a random unscored card
			if #unscored_cards ~= 0 then
				-- Get Card
				local advocated_card = pseudorandom_element(unscored_cards)
				advocated_card.ability.buf_argument = true --> Blueprint/Duplicate Joker Support
				-- Flip
				G.E_MANAGER:add_event(Event({
					func = function()
						advocated_card:flip()
						return true
					end
				}))
				-- Execute Transform
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.1,
					func = function()
						-- Transform
						copy_card(pseudorandom_element(context.scoring_hand), advocated_card)
						advocated_card.buf_argument = true --> Making sure.
						-- Animate
						play_sound('tarot2', 1.0, 0.6)
						advocated_card:juice_up(0.3, 0.3)
						-- Flip
						advocated_card:flip()
						return true
					end
				}))
				-- Return :3
				return {
					message = localize('buf_convert'),
					colour = G.C.RED
				}
			end
		end
		if context.after and not context.blueprint then
			-- Clear "Transformed" Mark
			for index = 1, #context.full_hand do
				if context.full_hand[index].ability then
					context.full_hand[index].ability.buf_argument = nil
				end
			end
		end
    end
}

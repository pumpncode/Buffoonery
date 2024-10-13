SMODS.Joker {
    key = "memcard",
    name = "Memory Card",
    atlas = 'maggitsjokeratlas',
    pos = {
        x = 1,
        y = 1,
    },
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {
		mcount = 0,
		tsuit = "ne",
		trank = "No",
		cards = {}
    },
    loc_txt = {
        name = "Memory Card",
        text = {"Memorizes up to {C:attention}8{} of the {C:attention}first{} scored",  
                "card each round. Sell to convert a card",
				"in hand into each memorized card, {C:attention}in order{}",
				"{C:inactive}Memorized #1#. Last: #3##2#{}",
				}
    },
	loc_vars = function(self, info_queue, card)
        return {
            vars = {
					card.ability.mcount,
					card.ability.tsuit, 
					card.ability.trank
			}
        }
    end,
    calculate = function(self, card, context)
		-- MEMORIZE FIRST SCORING CARD
		if context.before and G.GAME.current_round.hands_played == 0 then
			if card.ability.mcount < 8 then  --limits to 8 cards memorized
				card.ability.mcount = card.ability.mcount + 1 
				card.ability.cards[card.ability.mcount] = context.scoring_hand[1]  -- [UPDATE]:changed from local variable to table value, in order to store card edition and/or enhancement.
				local _card = context.scoring_hand[1]
				local underscore_pos = string.find(SMODS.Suits[_card.base.suit].key, "_")  -- Checks for mod prefixes in suit keys and removes them from printed string
				if underscore_pos then
					card.ability.tsuit = string.sub(SMODS.Suits[_card.base.suit].key, underscore_pos + 1)  
				else
					card.ability.tsuit = SMODS.Suits[_card.base.suit].key  -- [UPDATE] Now uses SMODS functionality to improve mod compatibility
				end
				card.ability.trank = SMODS.Ranks[_card.base.value].key..' of '
				return {
					message = "Memorized!",
					colour = G.C.GREEN 
				}
			elseif card.ability.mcount >= 8 then
				return {
					message = "Memory Full!",
					colour = G.C.RED
				}
			end
		end
		
		-- CONVERT INTO MEMORIZED CARDS WHEN SELLING
		if context.selling_self then
			local j = math.min((card.ability.mcount), 8) -- prevents getting a nil value for suit[i] and rank[i]
			if j > 0 then
				for i = 1, j do
					G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
						local hcard = G.hand.cards[i]
						local mcard = card.ability.cards[i]
						copy_card(mcard, hcard)
						G.hand.cards[i]:flip();play_sound('tarot2', percent, 0.6);G.hand.cards[i]:juice_up(0.3, 0.3);G.hand.cards[i]:flip(); -- Animation stuff
						return true 
					end }))
				end
			else
				return true
			end
		end
    end
}
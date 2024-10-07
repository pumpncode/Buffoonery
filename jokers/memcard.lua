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
		suit = {},
		rank = {},
		mcount = 1
    },
    loc_txt = {
        name = "Memory Card",
        text = {"Memorizes the {C:attention}first{} scored card",  
                "each round up to {C:attention}8 times{}",
				"Sell this Joker to convert a card in hand",
				"into each memorized card, in order"
				}
    },
	loc_vars = function(self, info_queue, card)
        return {
            vars = {card.ability.suit, card.ability.rank, card.ability.mcount}
        }
    end,
    calculate = function(self, card, context)
		-- MEMORIZE FIRST SCORING CARD
		if context.before and G.GAME.current_round.hands_played == 0 then
			if card.ability.mcount <= 8 then  --limits to 8 cards memorized
				local _card = context.scoring_hand[1]  --see Strength code @ card.lua
				card.ability.suit[card.ability.mcount] = string.sub(_card.base.suit, 1, 1)..'_'
				card.ability.rank[card.ability.mcount] = _card.base.id
				if card.ability.rank[card.ability.mcount] < 10 then card.ability.rank[card.ability.mcount] = tostring(card.ability.rank[card.ability.mcount])
				elseif card.ability.rank[card.ability.mcount] == 10 then card.ability.rank[card.ability.mcount] = 'T'
				elseif card.ability.rank[card.ability.mcount] == 11 then card.ability.rank[card.ability.mcount] = 'J'
				elseif card.ability.rank[card.ability.mcount] == 12 then card.ability.rank[card.ability.mcount] = 'Q'
				elseif card.ability.rank[card.ability.mcount] == 13 then card.ability.rank[card.ability.mcount] = 'K'
				elseif card.ability.rank[card.ability.mcount] == 14 then card.ability.rank[card.ability.mcount] = 'A'
				end
				card.ability.mcount = card.ability.mcount + 1 
				return {
					message = "Memorized!",
					colour = G.C.GREEN 
				}
			elseif card.ability.mcount > 8 then
				return {
					message = "Memory Full!",
					colour = G.C.RED
				}
			end
		end
		
		-- CONVERT INTO MEMORIZED CARDS WHEN SELLING
		if context.selling_self then
			local j = math.min((card.ability.mcount - 1), 8) -- prevents getting a nil value for suit[i] and rank[i] because of line 71
			if j > 0 then
				for i = 1, j do
					G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function()
						local hcard = G.hand.cards[i]
						local msuit = card.ability.suit[i]
						local mrank = card.ability.rank[i]
						hcard:set_base(G.P_CARDS[msuit..mrank])
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

-- Relevant vanilla (card.lua) code:
-- Strength, Death, Hanging Chad, Sixth Sense
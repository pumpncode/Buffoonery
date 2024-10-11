SMODS.Joker {
    key = "argument",
    name = "Pertinent Argument",
    atlas = 'maggitsjokeratlas',
    pos = {
        x = 1,
        y = 2,
    },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {
        extra = 2 
    },
    loc_txt = {
        name = "Pertinent Argument",
        text = {"{C:green}1 in 2{} chance to convert",
				"an unscored card into one",
				"of the scored ones, if",
                "played hand is a {C:attention}Two Pair{}"}  
    },
	loc_vars = function(self, info_queue, card)
		return { 
			vars = { G.GAME.probabilities.normal or 1, card.ability.extra}
		}
	end,
	
    calculate = function(self, card, context)
		if context.before and not context.blueprint then
			if not next(context.poker_hands["Full House"]) and next(context.poker_hands["Two Pair"]) and #context.full_hand == 5 then  -- Full House crashes the game without the first condition (if not next..."Full House"...)
				if pseudorandom('argument'..G.GAME.round_resets.ante) < G.GAME.probabilities.normal / card.ability.extra then
					local played_ranks = {}
					local index_map = {}
					
					for i = 1, #context.full_hand do  -- Stores the numerical values of the ranks of each played card, in order
						local _card = context.full_hand[i]
						played_ranks[i] = _card.base.id
					end
					
					for i = 1, #played_ranks do -- Finds the unpaired rank in the played cards
					  local value = played_ranks[i]
					  if index_map[value] then
						-- If the value exists, mark it as "paired" by removing the stored index
						index_map[value] = nil
					  else
						-- If the value doesn't exist, store its index
						index_map[value] = i
					  end
					end
					
					local single = nil
					for value, index in pairs(index_map) do  -- stores the index of the unpaired rank in the played_ranks table
						single = index
					end
					
					local rand_index = math.random(1, 4)
					G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                        copy_card(context.scoring_hand[rand_index], context.full_hand[single])  -- Transforms the unpaired rank card into a random scored one.
						context.full_hand[single]:flip();play_sound('tarot2', percent, 0.6);context.full_hand[single]:juice_up(0.3, 0.3);context.full_hand[single]:flip(); -- Animation
                    return true end }))
					
					return {
                      message = "Converted!",
                      colour = G.C.RED
					}	
				end
			end
		end
	end
}
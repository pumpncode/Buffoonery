SMODS.Joker {
    key = "interpreter",
    name = "Interpreter",
    atlas = 'buf_jokers',
    pos = {
        x = 5,
        y = 0,
    },
    rarity = 2,
    cost = 7,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {
        extra = { check = true, mult_amount = 0, mult_joker = nil },
    },
    loc_txt = {set = 'Joker', key = 'j_buf_interpreter'},
    calculate = function(self, card, context)  -- BEWARE: JANKY ASS CODE BELOW
		local origCalcIndiv = SMODS.calculate_individual_effect
		local function moddedCalcIndiv(effect, scored_card, key, amount, from_edition)  -- Hooked this func to get the amount of mult provided by the scoring joker
			origCalcIndiv(effect, scored_card, key, amount, from_edition)
			if scored_card == card.ability.extra.mult_joker then  -- prevents playing cards from interfering, eg. Mult cards
				if (key == 'mult' or key == 'h_mult' or key == 'mult_mod') and amount then
					if from_edition then  -- if the scored joker has an edition that adds mult, add the amount to calculation
						card.ability.extra.mult_amount = amount * 5
					elseif card.ability.extra.check and card.ability.extra.mult_amount ~= nil then
						card.ability.extra.mult_amount = (card.ability.extra.mult_amount) + amount * 5
						card.ability.extra.check = false
					end
				end
			end
		end
	
        if context.before and not card.getting_sliced then  -- switch to modified scoring func before scoring
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then card.ability.extra.mult_joker = G.jokers.cards[i-1] end
			end
			if not context.blueprint then
				SMODS.calculate_individual_effect = moddedCalcIndiv
			end
		end
		
		if context.joker_main and not card.getting_sliced then
			return {
				chips = card.ability.extra.mult_amount
			}
        end
		
		if context.after and not context.blueprint then  -- go back to original func at EoR
			SMODS.calculate_individual_effect = origCalcIndiv
			card.ability.extra.check = true
			card.ability.extra.mult_amount = 0
			card.ability.extra.mult_joker = nil
		end
    end,
}
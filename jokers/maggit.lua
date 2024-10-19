SMODS.Joker{
	key = "maggit",
    name = "Maggit",
    atlas = 'maggitsjokeratlas',
    pos = {
        x = 3,
        y = 2,
    },
	soul_pos = {
		x = 3,
		y = 3,
	},
    rarity = 4,
    cost = 5,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {
        extra = { Emult = 1.5, once = "Not yet" }        
    },
    loc_txt = { 
        name = "Maggit",
        text = {
			"{X:dark_edition,C:white}^#1#{} Mult if you own a",
			"{C:dark_edition}Nu Metal{} Joker. Otherwise,",
			"{C:attention}only once{}, create one",
			"when {C:attention}Blind{} is selected{}",
			"{C:inactive,s:0.7}(Must have room. #2# created.){}",
        },
    },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {set = 'Other', key = 'maggit_info'}
        return {
            vars = {card.ability.extra.Emult, card.ability.extra.once}
        }
    end,
	calculate = function(self, card, context)
		local check = false
		if context.setting_blind and not self.getting_sliced then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].ability.numetal then
					check = true
					break
				else
					check = false
				end
			end
			if not check and card.ability.extra.once == "Not yet" and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
				local nujokies = { "j_buf_korny", "j_buf_whitepony", "j_buf_rerollin", "j_buf_fivefingers", "j_buf_clown" }
				local jokers_to_create = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
                G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        for i = 1, jokers_to_create do
                            local card = create_card('Joker', G.jokers, nil, nil, nil, nil, nujokies[math.random(1,#nujokies)], 'mag')
                            card:add_to_deck()
                            G.jokers:emplace(card)
                            card:start_materialize()
                            G.GAME.joker_buffer = 0
                        end
                        return true
                    end}))   
                    card_eval_status_text(context.blueprint_card or self, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE})
					card.ability.extra.once = "Already"
			end
		end
        if context.joker_main then
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i].ability.numetal then
					check = true
					break
				else
					check = false
				end
			end
			if check then
				return {
					message = "^"..card.ability.extra.Emult.." Mult",
					colour = G.C.DARK_EDITION,
					buf_Emult_mod = card.ability.extra.Emult
				}
			end
		end
	end
}


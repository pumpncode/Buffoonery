SMODS.Joker {
    key = "sayajimbo",
    name = "Sayajimbo",
    atlas = 'sayatlas',
    pos = {
        x = 0,
        y = 0,
    },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {
        extra = { chips = 20, mult = 25, xmult = 3, emult = 1.35, curr = 0, need = 1, hand = 'Pair', level = 0},
		check1 = true
    },
    loc_txt = {set = 'Joker', key = 'j_buf_sayajimbo'},
    loc_vars = function(self, info_queue, card)
		if card.ability.extra.level ~= 0 then
			return {
				key = self.key..'_s'..tostring(card.ability.extra.level),
				vars = {
					card.ability.extra.mult, card.ability.extra.xmult, card.ability.extra.emult, 
					card.ability.extra.curr, card.ability.extra.need, localize(card.ability.extra.hand, 'poker_hands')
				}
			}
		else
			return {
				vars = {
					card.ability.extra.chips, localize(card.ability.extra.hand, 'poker_hands')
				}
			}
		end
    end,
	update = function(self, card)
		if card.ability.check1 then
			local _poker_hands = {}
			for k, v in pairs(G.GAME.hands) do
				if v.visible and k ~= card.ability.extra.hand and k ~= 'High Card' then _poker_hands[#_poker_hands+1] = k end
			end
			card.ability.extra.hand = pseudorandom_element(_poker_hands, pseudoseed('ssj'))
			card.ability.check1 = nil
		end
    end,
    calculate = function(self, card, context)
        if context.joker_main then
			local level = {
				[0] = {chips = card.ability.extra.chips},
				[1] = {mult = card.ability.extra.mult},
				[2] = {xmult = card.ability.extra.xmult},
				[3] = {emult = card.ability.extra.emult}
			}
            return level[card.ability.extra.level]
        end
		if context.after and context.scoring_name == card.ability.extra.hand then
		card.ability.extra.curr = card.ability.extra.curr + 1
			if card.ability.extra.curr >= card.ability.extra.need then
				card.ability.extra.curr = 0
				card.ability.extra.need = card.ability.extra.need + 2
				local _poker_hands = {}
					for k, v in pairs(G.GAME.hands) do
						if v.visible and k ~= card.ability.extra.hand and k ~= 'High Card' then _poker_hands[#_poker_hands+1] = k end
					end
				card.ability.extra.hand = pseudorandom_element(_poker_hands, pseudoseed('ssj'))
				card.ability.extra.level = card.ability.extra.level + 1
				G.E_MANAGER:add_event(Event({
					func = function()
					G.E_MANAGER:add_event(Event({
						func = function()
						card:juice_up(1, 0.5)
						card.config.center.pos.x = card.ability.extra.level
					return true end}))
					SMODS.calculate_effect({message = localize('k_upgrade_ex'), colour = G.C.FILTER}, card)
					return true
					end
				}))
				return
			end
		end
    end
}
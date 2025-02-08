SMODS.Joker {
    key = "kerman_spc",
    name = "Jebediah Reborn",
    atlas = 'buf_special',
    pos = {
        x = 3,
        y = 0,
    },
    rarity = 'buf_spc',
    cost = 4,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	in_pool = false,
    config = {
        extra = { mult = 0, gain = 8, check = false, supergain = 1.5},
    },
    loc_txt = {set = 'Joker', key = 'j_buf_kerman'},
    loc_vars = function(card, info_queue, card)
		if Buffoonery.config.show_info then
			info_queue[#info_queue+1] = {set = 'Other', key = 'special_info'}
		end
        return {
            vars = {card.ability.extra.mult, card.ability.extra.gain}
        }
    end,
	
	add_to_deck = function(self, card, context)
		card.ability.extra.mult = G.GAME.pool_flags.kermans_mult or 0 -- Uses the mult value Jeb had before he went boom
		G.GAME.pool_flags.kerman_is_krakened = true -- Prevents spawning again if another black hole is used
	end,
	
    calculate = function(card, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
        if context.using_consumeable and not context.blueprint then
			if context.consumeable.ability.set == 'Planet' then      
				card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.gain
				G.E_MANAGER:add_event(Event({
					func = function() SMODS.calculate_effect({message = localize('k_upgrade_ex'), colour = G.C.MULT}, card); return true
					end}))
				return
			elseif context.consumeable.ability.name == 'Black Hole' then
				if not card.ability.extra.check then
					card.ability.extra.check = true
				else
					card.ability.extra.mult = card.ability.extra.mult * card.ability.extra.supergain
					G.E_MANAGER:add_event(Event({
						func = function() SMODS.calculate_effect({message = localize('buf_supergrade'), colour = G.C.MULT}, card); return true
						end}))
					return
				end
			end
		end
    end,
	
		-- HIDE JOKER IN COLLECTION (THANKS, EREMEL) --
	inject = function(self)
		if not Buffoonery.config.show_spc then
			SMODS.Joker.super.inject(self)
			G.P_CENTER_POOLS.Joker[#G.P_CENTER_POOLS.Joker] = nil
		else
			SMODS.Joker.super.inject(self)
		end
	end
}
SMODS.Joker {
	key = "van",
	name = "Van",
	atlas = "buf_jokers",
	pos = { x = 6, y = 3 },
    unlocked = false,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = 'buf_spc',
	cost = 6,
	config = {
		extra = {
			chips = 0,
			chip_mod = 15,
			clowns = 2
		}
	},
	pools = {
		--["Numetal"] = true,
		["Numetal_Special"] = true
    },
    loc_txt = { set = 'Joker', key = 'j_buf_clown' },
    loc_vars = function(self, info_queue, card)
		if Buffoonery.config.show_info then
			info_queue[#info_queue+1] = {set = 'Other', key = 'special_info'}
			info_queue[#info_queue+1] = {set = 'Other', key = 'nu_metal_info'}
		end
		if card.area == G.jokers then
            return { key = self.key .. '_alt', vars = {
				card.ability.extra.chip_mod * card.ability.extra.clowns,
				card.ability.extra.chips
			}}
		else return { vars = { } } end
    end,
    add_to_deck = function(self, card, from_debuff)
		if not from_debuff then
			SMODS.calculate_effect({
				message = localize('buf_hopin'),
				colour = G.C.BUF_SPC
			}, card)
		end
	end,
	calculate = function(self, card, context)
		if context.joker_main then
        	return {
        		chips = card.ability.extra.chips
        	}
        end
		if context.card_added and context.card.ability.set == "Joker" then
			card.ability.extra.chips = card.ability.extra.chips + (card.ability.extra.chip_mod * card.ability.extra.clowns)
			return {
				message = localize('k_upgrade_ex'),
				colour = G.C.CHIPS
			}
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

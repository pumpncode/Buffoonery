-- defs --
Buffoonery = SMODS.current_mod

-- ATLASES --
buf = {}
SMODS.Atlas {
	key = 'buf_jokers',
	path = "jokers.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = 'buf_special',
	path = "special.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "buf_consumables",
	path = "consumables.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = 'buf_enhancements',
	path = "enhancements.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = 'buf_decks',
	path = "decks.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = 'buf_sleeves',
	path = "sleeves.png",
	px = 73,
	py = 95
}
SMODS.Atlas {
	key = 'rouletteatlas',
	path = "roulette.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = 'kermanatlas',
	path = "kerman.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "modicon",
	path = "buf_icon.png",
	px = 34,
	py = 34
}


-- COMPAT SECTION --
buf.compat = {
	sleeves = (SMODS.Mods['CardSleeves'] or {}).can_load,
	unstable = (SMODS.Mods['UnStable'] or {}).can_load,
	talisman = (SMODS.Mods['Talisman'] or {}).can_load,
}

if not buf.compat.talisman then
	NFS.load(Buffoonery.path .. 'notalisman.lua')()
end

-- FUNCTIONS --
local VanillaHighlight = CardArea.add_to_highlighted

function buf_add_to_highlighted(card, silent) -- Fix Bunco incompatibility. Bunco modifies CadArea.add_to_highlighted and breaks Patronizing Joker, so I made a separate function.
    VanillaHighlight(G.hand, card, silent)
end

-- CONFIG --
Buffoonery.config_tab = function()
	return {n = G.UIT.ROOT, config = {r = 0.1, minw = 4, align = "tm", padding = 0.2, colour = G.C.BLACK}, nodes = {
			{ n=G.UIT.R, config = {align = 'cm'}, nodes={
				create_toggle({label = localize('buf_cf_show_spc'), ref_table = Buffoonery.config, info = localize('buf_cf_req_restart'), ref_value = 'show_spc', active_colour = Buffoonery.badge_colour, right = true}),
				create_toggle({label = localize('buf_cf_show_info'), ref_table = Buffoonery.config, info = localize('buf_cf_info_info'), ref_value = 'show_info', active_colour = Buffoonery.badge_colour, right = true}),
				create_toggle({label = localize('buf_cf_memcard_perf'), ref_table = Buffoonery.config, info = localize('buf_cf_perf_info'), ref_value = 'memcard_perf', active_colour = Buffoonery.badge_colour, right = true}),
			},
			},
	}}
end

-- RARITY --
SMODS.Rarity{
	key = "spc",
	loc_txt = {
		name = localize('k_buf_spc')
	},
	badge_colour = HEX('ee8f8d'),
	pools = {["Joker"] = false},
	get_weight = function(self, weight, object_type)
		return weight
	end,
}

-- JOKERS --
-- common
NFS.load(Buffoonery.path .. 'data/jokers/afan.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/special/afan_spc.lua')() -- [SPECIAL]
NFS.load(Buffoonery.path .. 'data/jokers/cashout.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/clays.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/fivefingers.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/gfondue.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/camarosa.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/kerman.lua')()  -- (Jebediah Kerman, a.k.a. Jeb)
NFS.load(Buffoonery.path .. 'data/jokers/special/kerman_spc.lua')() -- [SPECIAL]
NFS.load(Buffoonery.path .. 'data/jokers/korny.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/laidback.lua')()
-- uncommon
NFS.load(Buffoonery.path .. 'data/jokers/denial.lua')() -- (Arstotzkan Denial)
NFS.load(Buffoonery.path .. 'data/jokers/clown.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/argument.lua')() -- (Pertinent Argument)
NFS.load(Buffoonery.path .. 'data/jokers/porcelainj.lua')() 
NFS.load(Buffoonery.path .. 'data/jokers/rerollin.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/roulette.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/whitepony.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/special/blackstallion.lua')()  -- [SPECIAL]
-- rare
NFS.load(Buffoonery.path .. 'data/jokers/abyssalp.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/dorkshire.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/special/dorkshire_g.lua')()  -- [SPECIAL]
NFS.load(Buffoonery.path .. 'data/jokers/lemmesolo.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/memcard.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/special/memcard_dx.lua')()   -- [SPECIAL]
NFS.load(Buffoonery.path .. 'data/jokers/patronizing.lua')()
-- legendary
NFS.load(Buffoonery.path .. 'data/jokers/maggit.lua')()

-- CONSUMABLES
function conversionTarot(hand, newcenter) -- For tarots that change enhancements. Directly stolen from Kirbio's UnStable mod (with his permission, ofc. thanks, Kirbio!)
	for i=1, #hand do
		local percent = 1.15 - (i-0.999)/(#hand-0.998)*0.3
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() hand[i]:flip();play_sound('card1', percent);hand[i]:juice_up(0.3, 0.3);return true end }))
	end
	delay(0.2)
	
	for i=1, #hand do
	G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
				hand[i]:set_ability(G.P_CENTERS[newcenter])
				return true end }))
	end
	
	for i=1, #hand do
		local percent = 0.85 + (i-0.999)/(#hand-0.998)*0.3
		G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() hand[i]:flip();play_sound('tarot2', percent, 0.6);hand[i]:juice_up(0.3, 0.3);return true end }))
	end
	G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2,func = function() G.hand:unhighlight_all(); return true end }))
	delay(0.5)
end

NFS.load(Buffoonery.path .. 'data/consumables/nobility.lua')()

-- DECKS --
NFS.load(Buffoonery.path .. 'data/decks/jstation.lua')()
NFS.load(Buffoonery.path .. 'data/decks/galloping.lua')()
NFS.load(Buffoonery.path .. 'data/decks/porcelain.lua')()

-- ENHANCEMENTS --
NFS.load(Buffoonery.path .. 'data/enhancements/porcelain.lua')()
NFS.load(Buffoonery.path .. 'data/enhancements/porcelain_g.lua')()

-- SLEEVES --
if buf.compat.sleeves then
	NFS.load(Buffoonery.path .. 'data/sleeves/sl_jstation.lua')()
	NFS.load(Buffoonery.path .. 'data/sleeves/sl_galloping.lua')()
	NFS.load(Buffoonery.path .. 'data/sleeves/sl_porcelain.lua')()
end

-- SOUNDS --
SMODS.Sound({key = 'phase', path = 'phase.ogg'})
SMODS.Sound({key = 'explosion', path = 'explosion.ogg'})
SMODS.Sound({key = 'roul1', path = 'roul1.ogg'})
SMODS.Sound({key = 'roul2', path = 'roul2.ogg'})
SMODS.Sound({key = 'emult', path = 'emult.wav'})  -- Sound effect by HexaCryonic

------ CHANGELOG MOVED TO SEPARATE .md FILE ------
-- fixed clown upgrading by 20 the forst time
-- abyssal prism no longer strips upgrades TODO: prevent eternal creation
-- added Jeb reborn
-- fixed clays not updating when added mid-round

-- TODO: Jeb art: venus, earth, jupiter, saturn, uranus, neptune
--		 lemmesolo art
-- 		 8 more Special Jokers
--		 sayajimbo art
-- curr spc: Kerman, Dork, WP, Memcard (4/12)
-- planned: roul, patron, saya, afan(D)

-- patron: if joker contains knife/dagger, transform
-- afan: JYMBROME (SYNDROME) if sold more than 5 times

SMODS.Joker {
    key = "sayajimbo",
    name = "Sayajimbo",
    atlas = 'buf_jokers',
    pos = {
        x = 7,
        y = 3,
    },
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    config = {
        extra = { chips = 20, mult = 25, xmult = 3, emult = 1.4, curr = 0, need = 1, hand = 'Pair', level = 0},
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
				return {
					message = localize('k_upgrade_ex'),
					colour = G.C.FILTER
				}
			end
		end
    end
}

SMODS.Joker {
    key = "cotom",
    name = "COTOM",
    atlas = 'buf_jokers',
    pos = {
        x = 7,
        y = 3,
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
    loc_txt = {set = 'Joker', key = 'j_buf_cotom'},
    calculate = function(self, card, context)  -- BEWARE: JANKY CODE BELOW!!!!1!11
		local origCalcIndiv = SMODS.calculate_individual_effect
		local function moddedCalcIndiv(effect, scored_card, key, amount, from_edition)  -- Hooked this func to get the amount of mult provided by the scoring joker
			origCalcIndiv(effect, scored_card, key, amount, from_edition)
			if scored_card.area ~= G.play then  -- prevents playing cards from interfering, eg. Mult cards
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

SMODS.Joker {
    key = "supportive",
    name = "Supportive Joker",
    atlas = 'buf_special',
    pos = {
        x = 1,
        y = 0,
    },
    rarity = "buf_spc",
    cost = 6,
    unlocked = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
	in_pool = false,
    config = {
        extra = { xchips = 4, peek = {}, scry = false },
    },
    loc_txt = {set = 'Joker', key = 'j_buf_supportive'},
    loc_vars = function(self, info_queue, card)
		if card.ability.extra.scry == true then
			return {
				key = self.key .. '_alt',
				vars = {card.ability.extra.peek[1], card.ability.extra.peek[2], card.ability.extra.peek[3], card.ability.extra.xchips}
			}
		else
			return { vars = { card.ability.extra.xchips } }
		end
    end,
	update = function(self, card, dt)
		for i = 1, 3 do
			card.ability.extra.peek[i] = G.deck.cards[#G.deck.cards-(i-1)].base.name
		end
	end,
	add_to_deck = function(self, card, context)
		if G.STATE == G.STATES.SELECTING_HAND or G.STATE == G.STATES.HAND_PLAYED then
			card.ability.extra.scry = true
		end
	end,
    calculate = function(self, card, context)
		if context.setting_blind then
			card.ability.extra.scry = true
			for i = 1, 3 do
				card.ability.extra.peek[i] = G.deck.cards[#G.deck.cards-(i-1)].base.name
			end
		end
        if context.joker_main then
			return {
				xchips = card.ability.extra.xchips
			}
        end
		if context.end_of_round then
			card.ability.extra.scry = false
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
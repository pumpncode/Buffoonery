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
	key = 'sayatlas',
	path = "sayajimbo.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = 'tailoratlas',
	path = "tailored.png",
	px = 71,
	py = 95
}
SMODS.Atlas {
	key = "modicon",
	path = "buf_icon.png",
	px = 34,
	py = 34
}
SMODS.Atlas {
	key = 'buf_stakes', 
	path = 'stakes.png', 
	px = 29, 
	py = 29
}
SMODS.Atlas {
	key = 'buf_stickers', 
	path = 'stickers.png', 
	px = 71, 
	py = 95
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
local VanillaHighlight = CardArea.add_to_highlighted -- Fix Bunco incompat with Patronizing Joker

function expire_card(_card, msg, color) -- function to remove card with the Cavendish animation and display a message
	G.E_MANAGER:add_event(Event({
		func = function()
			if msg then SMODS.calculate_effect({message = msg, colour = color}, _card) end
			play_sound('tarot1')
			_card.T.r = -0.2
			_card:juice_up(0.3, 0.4)
			_card.states.drag.is = true
			_card.children.center.pinch.x = true
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
				func = function()
						G.jokers:remove_card(_card)
						_card:remove()
						_card = nil
					return true; 
				end})) 
			return true
		end
	}))
end

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
NFS.load(Buffoonery.path .. 'data/jokers/special/van.lua')() -- [SPECIAL]
NFS.load(Buffoonery.path .. 'data/jokers/jokergebra.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/argument.lua')() -- (Pertinent Argument)
NFS.load(Buffoonery.path .. 'data/jokers/porcelainj.lua')() 
NFS.load(Buffoonery.path .. 'data/jokers/rerollin.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/roulette.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/sayajimbo.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/tailored.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/whitepony.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/special/blackstallion.lua')()  -- [SPECIAL]
-- rare
NFS.load(Buffoonery.path .. 'data/jokers/abyssalp.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/special/abyssalecho.lua')()  -- [SPECIAL]
NFS.load(Buffoonery.path .. 'data/jokers/dorkshire.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/special/dorkshire_g.lua')()  -- [SPECIAL]
NFS.load(Buffoonery.path .. 'data/jokers/lemmesolo.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/memcard.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/special/memcard_dx.lua')() -- [SPECIAL]
NFS.load(Buffoonery.path .. 'data/jokers/patronizing.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/special/supportive.lua')() -- [SPECIAL]
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

-- STAKES --
NFS.load(Buffoonery.path .. 'data/stakes.lua')()

-- DECKS --
NFS.load(Buffoonery.path .. 'data/decks/galloping.lua')()
NFS.load(Buffoonery.path .. 'data/decks/sandstone.lua')()
NFS.load(Buffoonery.path .. 'data/decks/jstation.lua')()
NFS.load(Buffoonery.path .. 'data/decks/porcelain.lua')()

-- ENHANCEMENTS --
NFS.load(Buffoonery.path .. 'data/enhancements/porcelain.lua')()
NFS.load(Buffoonery.path .. 'data/enhancements/porcelain_g.lua')()

-- SLEEVES --
if buf.compat.sleeves then
	NFS.load(Buffoonery.path .. 'data/sleeves/sl_galloping.lua')()
	NFS.load(Buffoonery.path .. 'data/sleeves/sl_jstation.lua')()
	NFS.load(Buffoonery.path .. 'data/sleeves/sl_porcelain.lua')()
end

-- SOUNDS --
SMODS.Sound({key = 'phase', path = 'phase.ogg'})
SMODS.Sound({key = 'explosion', path = 'explosion.ogg'})
SMODS.Sound({key = 'roul1', path = 'roul1.ogg'})
SMODS.Sound({key = 'roul2', path = 'roul2.ogg'})
SMODS.Sound({key = 'emult', path = 'emult.wav'})  -- Sound effect by HexaCryonic

-- CHANGELOG MOVED TO SEPARATE .md FILE ------
-- fixed clown upgrading by 20 the forst time
-- fixed clown's scaling bugging out or being lost when starting a new run
-- fixed patronizing joker not selecting cards during Cerulean Bell bossfight
-- fixed erosion not working properly with porcelain deck
-- fixed memory card / clay shooting jiggling too much
-- fixed abyssal prism not properly accounting for already-negative jokers inside it when converting the others into negatives
-- abyssal prism no longer strips upgrades
-- Banish replaced with Exile
-- Added Van
-- Added Abyssal Echo
-- Added Kerman Reborn
-- Added Supportive Joker
-- Added Bitter Fan
-- Added Let Me Solo Her
-- Added Sayajimbo
-- added jokergebra
-- added 2 stakes
-- added sandstone deck

-- TODO: Jeb art: earth, jupiter, saturn, uranus, neptune
	-- sandstone sleeve (ante 5, 3x)
	-- 1 more Special Joker
    -- special jokies discover reqs
	-- fix aprism negatives
-- curr spc: Kerman, Dork, WP, Memcard, Patronizing, Afan, clown, prism (8/9)

-- Only the faceless wear uniforms
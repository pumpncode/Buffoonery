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
    key = "modicon",
    path = "buf_icon.png",
    px = 34,
    py = 34
}


-- COMPAT SECTION --
buf.compat = {
	-- talisman = (SMODS.Mods['Talisman'] or {}).can_load,  -- deprecated, as Talisman became a requirement
	sleeves = (SMODS.Mods['CardSleeves'] or {}).can_load,
}

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
NFS.load(Buffoonery.path .. 'data/jokers/cashout.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/clays.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/fivefingers.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/gfondue.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/camarosa.lua')()
NFS.load(Buffoonery.path .. 'data/jokers/kerman.lua')()  -- (Jebediah Kerman, a.k.a. Jeb)
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


------------------------------------ CHANGELOG (KINDA) ------------------------------------

-- 0.1) INITIAL PRIVATE BUILD WITH 2 WORKING JOKERS
-- 0.2) FIRST PUBLIC RELEASE WITH 5 WORKING JOKERS
--		0.2.2 - Updated README.md to better fit joker descriptions,
--       	  - Added a flag to prevent Korny Joker from respawning
--       	  - Added memorized card counter and last card memorized info to Memory Card's description
--			  - Added Xchips and Emult functionality
--		0.2.3 - updated Memory Card's art (made the 8 higher res)
--			  - Made Korny Joker and Memory Card's descriptions less verbose
-- 0.5) FIRST MAJOR UPDATE WITH 3 JOKERS, MEMORY CARD UPDATE, ARTWORK TWEAKS, DESCRIPTION TWEAKS, AND ARTWORK CREDITS
-- 		0.5.1 - Minor tweaks to some of the artwork to better fit Balatro's artstyle
--				Changed Five Fingers from uncommon ($6) to common ($4) 
--		0.5.2 - Added modded suit compatibility to Memory Card
-- 0.6) MAJOR UPDATE WITH TWO NEW JOKERS. UPDATE IS PRIVATE FOR PLAYTESTING PURPOSES. INTERNAL CHANGES TO 1.0 GOALS AND VERSION NUMBEIRING.
-- 		0.6.1 - Fixed Laidback Joker being able to be purchased when player had less than 2 free slots
--		0.6.2 - Added Talisman compat to Cashout Voucher
-- 0.8) BIGGEST UPDATE YET WITH 3 NEW JOKERS (5 TOTAL WITH 0.6'S). ARTWORK FIXES, BALANCE CHANGES, UPDATED 1.0 GOALS, STARTED WORK ON NEW ENHANCEMENT.
--		0.8.1 - Added Brazilian Portuguese localization
--              Fixed Maggit crashing the game when creating a joker
--				Gave the shading some more work on Jebediah Kerman's artwork
-- 0.9) PRE-1.0 UPDATE FEATURING EVERYTHING PLANNED FOR 1.0 EXCEPT THE LAST TWO JOKERS.
-- 1.0) Final content update for this mod. 2 new jokers, aesthetic fixes, balance changes, made pt_BR loc more thorough. SIKE, I'M ADDING MOAR STUFF LETS GOOOOOOOOOOOOOOOOOOO
-- 		1.0.1 - Artwork and localization polish
-- 			  - Five Fingers costs 5$
--			  - Finally made patronizing joker have its initial planned effect, similar to the Cerulean Bell boss blind

--- GOALS FOR 1.0.0 (in order of priority, descending) ---
-- 1) Have a whole page (15) of fully implemented and working jokers (D O N E)
	-- 1.1) Reserve 5 of 15 jokers for Nu Metal \m/  (D O N E)
-- 3) Add 2 decks to the game with sleeve compat (D O N E)
-- 4) Have locs for at least en-us and pt-br (D O N E)

-- [Enhancement idea scrapped. Should be used in a new mod in the future] ALSO SIKE, WE HAVE SMODS.ENHANCEMENT NOW LETS GOOOOOOOOOOOOOOOOOOOOOO


------------------- LAST UPDATES ------------------------ 16/01/2025, v1.1.0

-- Added config options
-- Fixed stray pixels and wrong spacing in some artworks
-- Made Memory Card's description better fit with Bunco's suit icons if they're present
-- Made Memory Card's description compatible with UnStable's ranks
-- Fixed Memory Card crashing the game with modded enhancements
-- Fixed Clown not upgrading when it should in some instances
-- Fixed Rerrolin' bugging out with Blueprint
-- Rewrote Clown to fix buggy code
-- New Enhancement: Porcelain Cards
-- New Deck / Sleeve: Porcelain
-- New Jokers: Dorkshire Tea and its Special version
-- New Joker: Porcelain Joker
-- New Joker: Adoring Fan
-- New Jokers: Gold Fondue & Camarosa
-- New Joker: Clay Shooting


-- todo: porcelain tarot art, porcelain deck/sleeve royal alt art, locs



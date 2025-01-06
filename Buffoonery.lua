--- STEAMODDED HEADER
--- MOD_NAME: Buffoonery
--- MOD_ID: Buffoonery
--- MOD_DESCRIPTION: A vanilla-adjacent joker pack made with the help of the glorious Balatro modding community.
--- MOD_AUTHOR: [PinkMaggit]
--- DEPENDENCIES: [Steamodded>=1.0.0~ALPHA-1103a]
--- PREFIX: buf
--- BADGE_COLOUR: ee8f8d
--- LOADER_VERSION_GEQ: 1.0.0
--- VERSION: 1.0.2

-- ATLASES --
buf = {}
SMODS.Atlas {
    key = 'maggitsjokeratlas',
    path = "jokers.png",
    px = 71,
    py = 95
}
SMODS.Atlas {
    key = 'maggitsmiscatlas',
    path = "misc.png",
    px = 71,
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
	talisman = (SMODS.Mods['Talisman'] or {}).can_load,
	sleeves = (SMODS.Mods['CardSleeves'] or {}).can_load,
}

-- JOKERS --
-- common
NFS.load(SMODS.current_mod.path .. 'data/jokers/cashout.lua')()
NFS.load(SMODS.current_mod.path .. 'data/jokers/fivefingers.lua')()
NFS.load(SMODS.current_mod.path .. 'data/jokers/kerman.lua')()  -- (Jebediah Kerman, a.k.a. Jeb)
NFS.load(SMODS.current_mod.path .. 'data/jokers/korny.lua')()
NFS.load(SMODS.current_mod.path .. 'data/jokers/laidback.lua')()
-- uncommon
NFS.load(SMODS.current_mod.path .. 'data/jokers/denial.lua')() -- (Arstotzkan Denial)
NFS.load(SMODS.current_mod.path .. 'data/jokers/clown.lua')()
NFS.load(SMODS.current_mod.path .. 'data/jokers/argument.lua')() -- (Pertinent Argument) 
NFS.load(SMODS.current_mod.path .. 'data/jokers/rerollin.lua')()
NFS.load(SMODS.current_mod.path .. 'data/jokers/roulette.lua')()
NFS.load(SMODS.current_mod.path .. 'data/jokers/whitepony.lua')()
-- rare
NFS.load(SMODS.current_mod.path .. 'data/jokers/abyssalp.lua')()
NFS.load(SMODS.current_mod.path .. 'data/jokers/memcard.lua')()
NFS.load(SMODS.current_mod.path .. 'data/jokers/patronizing.lua')()
NFS.load(SMODS.current_mod.path .. 'data/jokers/maggit.lua')()
-- special (won't normally spawn. Given under special circumstanes)
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
NFS.load(SMODS.current_mod.path .. 'data/jokers/blackstallion.lua')()
NFS.load(SMODS.current_mod.path .. 'data/jokers/memcard_dx.lua')() 

-- DECKS --
NFS.load(SMODS.current_mod.path .. 'data/decks/jstation.lua')()
NFS.load(SMODS.current_mod.path .. 'data/decks/galloping.lua')()

-- SLEEVES --
if buf.compat.sleeves then
	NFS.load(SMODS.current_mod.path .. 'data/sleeves/sl_jstation.lua')()
	NFS.load(SMODS.current_mod.path .. 'data/sleeves/sl_galloping.lua')()
end

-- SOUNDS --
SMODS.Sound({key = 'phase', path = 'phase.ogg'})
SMODS.Sound({key = 'explosion', path = 'explosion.ogg'})
SMODS.Sound({key = 'roul1', path = 'roul1.ogg'})
SMODS.Sound({key = 'roul2', path = 'roul2.ogg'})

-- ENHANCEMENT --
SMODS.Enhancement {  -- Porcelain Cards
	key = "porcelain",
	atlas = "maggitsmiscatlas",
	pos = {x=2, y = 0},
	
    replace_base_card = false,
    no_suit = false,
    no_rank = false,
    always_scores = false,
	
	config = {extra = {Xmult = 1.25, limit = 5, played = 0}},
	
	loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.Xmult, card.ability.extra.limit}
        }
    end,
	
	calculate = function(self, card, context, ret)
		if context.cardarea == G.play and not context.repetition then
			card.ability.extra.played = #context.full_hand
			SMODS.eval_this(card, {Xmult_mod = card.ability.extra.Xmult, message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}}} )
			if card.ability.extra.played >= card.ability.extra.limit then
				G.E_MANAGER:add_event(Event({
					trigger = 'after',
					delay = 0.4,
					func = function() 
						card:shatter()
						return true 
					end 
				}))
			end
		end
	end,
	
}

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
-- 1.0) Final content update for this mod. 2 new jokers, aesthetic fixes, balance changes, made pt_BR loc more thorough.                 -- SIKE, I'M ADDING MOAR STUFF LETS GOOOOOOOOOOOOOOOOOOO
-- 		1.0.1 - Artwork and localization polish
-- 			  - Five Fingers costs 5$
--			  - Finally made patronizing joker have its initial planned effect, similar to the Cerulean Bell boss blind

--- GOALS FOR 1.0.0 (in order of priority, descending) ---
-- 1) Have a whole page (15) of fully implemented and working jokers (D O N E)
	-- 1.1) Reserve 5 of 15 jokers for Nu Metal \m/  (D O N E)
-- 3) Add 2 decks to the game with sleeve compat (D O N E)
-- 4) Have locs for at least en-us and pt-br (D O N E)

-- [Enhancement idea scrapped. Should be used in a new mod in the future]    -- ALSO SIKE, WE HAVE SMODS.ENHANCEMENT NOW LETS GOOOOOOOOOOOOOOOOOOOOOO


------------------- LAST UPDATES ------------------------ 06/01/2025, v1.1.0

-- Made Memory Card's description better fit with Bunco's suit icons if they're present
-- Made Memory Card's description compatible with UnStable's ranks
-- Fixed Memory Card crashing the game with modded enhancements
-- Introduced the Porcelain Card enhancement

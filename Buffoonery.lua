--- STEAMODDED HEADER
--- MOD_NAME: Buffoonery
--- MOD_ID: Buffoonery
--- MOD_DESCRIPTION: Listen, I wanted to make jokers too.
--- MOD_AUTHOR: [PinkMaggit]
--- PREFIX: buf
--- BADGE_COLOUR: dd463c
--- LOADER_VERSION_GEQ: 1.0.0
--- VERSION: 0.8.0

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
-- COMPAT SECTION --
buf.compat = {
	talisman = (SMODS.Mods['Talisman'] or {}).can_load,
}


-- JOKERS --
NFS.load(SMODS.current_mod.path .. 'jokers/cashout.lua')()
NFS.load(SMODS.current_mod.path .. 'jokers/fivefingers.lua')()
NFS.load(SMODS.current_mod.path .. 'jokers/kerman.lua')()  -- (Jebediah Kerman, a.k.a. Jeb)
NFS.load(SMODS.current_mod.path .. 'jokers/korny.lua')()
NFS.load(SMODS.current_mod.path .. 'jokers/laidback.lua')()
NFS.load(SMODS.current_mod.path .. 'jokers/denial.lua')() -- (Arstotzkan Denial)
NFS.load(SMODS.current_mod.path .. 'jokers/clown.lua')()
NFS.load(SMODS.current_mod.path .. 'jokers/argument.lua')() -- (Pertinent Argument)
NFS.load(SMODS.current_mod.path .. 'jokers/rerollin.lua')()
NFS.load(SMODS.current_mod.path .. 'jokers/whitepony.lua')()
NFS.load(SMODS.current_mod.path .. 'jokers/memcard.lua')()
NFS.load(SMODS.current_mod.path .. 'jokers/patronizing.lua')()
NFS.load(SMODS.current_mod.path .. 'jokers/maggit.lua')()

------------------------------------ CHANGELOG ------------------------------------

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
-- 0.6) MAJOR UPDATE WITH TWO NEW [WIP] JOKERS. UPDATE IS PRIVATE FOR PLAYTESTING PURPOSES. INTERNAL CHANGES TO 1.0 GOALS AND VERSION NUMBEIRING.
-- 		0.6.1 - Fixed Laidback Joker being able to be purchased when player had less than 2 free slots
--		0.6.2 - Added Talisman compat to Cashout Voucher
-- 0.8) BIGGEST UPDATE YET WITH 3 NEW JOKERS (5 TOTAL WITH 0.6'S). ARTWORK FIXES, BALANCE CHANGES, UPDATED 1.0 GOALS, STARTED WORK ON NEW ENHANCEMENT.

--- GOALS FOR 1.0.0 (in order of priority, descending) ---
-- 1) Have a whole page (15) of fully implemented and working jokers (currently 13)
	-- 1.1) Reserve 5 of 15 jokers for Nu Metal \m/  (D O N E)
	-- 1.2) Get my shit together and find a way to code Integral and COTOM
-- 2) Add an enhancement to the game (IN PROGRESS)
-- 3) Add 2 decks to the game with sleeve compat (THIS IS NEXT)
-- 4) Have locs for at least en-us and pt-br (currently only en-us)


------------------- LAST UPDATES ------------------------ 20/10/2024, v0.8.1

-- Fixed Maggit crashing the game when creating a joker
-- Translated the jokers to brazilian portuguese
-- Made Jeb's art better


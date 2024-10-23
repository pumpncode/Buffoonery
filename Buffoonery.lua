--- STEAMODDED HEADER
--- MOD_NAME: Buffoonery
--- MOD_ID: Buffoonery
--- MOD_DESCRIPTION: Listen, I wanted to make jokers too.
--- MOD_AUTHOR: [PinkMaggit]
--- PREFIX: buf
--- BADGE_COLOUR: dd463c
--- LOADER_VERSION_GEQ: 1.0.0
--- VERSION: 0.9.0

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
	sleeves = (SMODS.Mods['CardSleeves'] or {}).can_load,
}

-- JOKERS --
NFS.load(SMODS.current_mod.path .. 'data/jokers/cashout.lua')()
NFS.load(SMODS.current_mod.path .. 'data/jokers/fivefingers.lua')()
NFS.load(SMODS.current_mod.path .. 'data/jokers/kerman.lua')()  -- (Jebediah Kerman, a.k.a. Jeb)
NFS.load(SMODS.current_mod.path .. 'data/jokers/korny.lua')()
NFS.load(SMODS.current_mod.path .. 'data/jokers/laidback.lua')()
NFS.load(SMODS.current_mod.path .. 'data/jokers/denial.lua')() -- (Arstotzkan Denial)
NFS.load(SMODS.current_mod.path .. 'data/jokers/clown.lua')()
NFS.load(SMODS.current_mod.path .. 'data/jokers/argument.lua')() -- (Pertinent Argument)
NFS.load(SMODS.current_mod.path .. 'data/jokers/blackstallion.lua')()  -- This is a special joker. It won't normally spawn. Play with the galloping deck (but not sleeve) to use it.
NFS.load(SMODS.current_mod.path .. 'data/jokers/whitepony.lua')()
NFS.load(SMODS.current_mod.path .. 'data/jokers/rerollin.lua')()
NFS.load(SMODS.current_mod.path .. 'data/jokers/memcard.lua')()
NFS.load(SMODS.current_mod.path .. 'data/jokers/memcard_dx.lua')() -- This is a special joker. It won't normally spawn. Play with the JimboStation deck and sleeve to use it.
NFS.load(SMODS.current_mod.path .. 'data/jokers/patronizing.lua')()
NFS.load(SMODS.current_mod.path .. 'data/jokers/maggit.lua')()

-- DECKS --
NFS.load(SMODS.current_mod.path .. 'data/decks/jstation.lua')()
NFS.load(SMODS.current_mod.path .. 'data/decks/galloping.lua')()
-- SLEEVES --
if buf.compat.sleeves then
	NFS.load(SMODS.current_mod.path .. 'data/sleeves/sl_jstation.lua')()
	NFS.load(SMODS.current_mod.path .. 'data/sleeves/sl_galloping.lua')()
end
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
--		0.8.1 - Added Brazilian Portuguese localization
--              Fixed Maggit crashing the game when creating a joker
--				Gave the shading some more work on Jebediah Kerman's artwork
-- 0.9) PRE-1.0 UPDATE FEATURING EVERYTHING PLANNED FOR 1.0 EXCEPT THE LAST TWO JOKERS.

--- GOALS FOR 1.0.0 (in order of priority, descending) ---
-- 1) Have a whole page (15) of fully implemented and working jokers (currently 13)
	-- 1.1) Reserve 5 of 15 jokers for Nu Metal \m/  (D O N E)
-- 3) Add 2 decks to the game with sleeve compat (D O N E)
-- 4) Have locs for at least en-us and pt-br (D O N E)

-- [Enhancement idea scrapped. Should be used in a new mod in the future]

------------------- LAST UPDATES ------------------------ 20/10/2024, v0.8.1

-- Added JimboStation Deck and Sleeve
-- Added Galloping Deck and Sleeve
-- Added Deluxe Memory Card [Special Joker]
-- Added Black Stallion [Special Joker]

-- Fixed Memory Card crashing the game when cards to convert > cards in hand
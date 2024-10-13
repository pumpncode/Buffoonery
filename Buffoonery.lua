--- STEAMODDED HEADER
--- MOD_NAME: Buffoonery
--- MOD_ID: Buffoonery
--- MOD_DESCRIPTION: Listen, I wanted to make jokers too.
--- MOD_AUTHOR: [PinkMaggit]
--- PREFIX: buf
--- BADGE_COLOUR: 662222
--- LOADER_VERSION_GEQ: 1.0.0
--- VERSION: 0.5.2

SMODS.Atlas {
    key = 'maggitsjokeratlas',
    path = "atlas.png",
    px = 71,
    py = 95
}

NFS.load(SMODS.current_mod.path .. 'jokers/cashout.lua')()
NFS.load(SMODS.current_mod.path .. 'jokers/fivefingers.lua')()
NFS.load(SMODS.current_mod.path .. 'jokers/korny.lua')()
NFS.load(SMODS.current_mod.path .. 'jokers/laidback.lua')()
NFS.load(SMODS.current_mod.path .. 'jokers/memcard.lua')()
NFS.load(SMODS.current_mod.path .. 'jokers/argument.lua')() -- (Pertinent Argument)
NFS.load(SMODS.current_mod.path .. 'jokers/rerollin.lua')()
NFS.load(SMODS.current_mod.path .. 'jokers/whitepony.lua')()

-- Relevant vanilla (card.lua) code:
-- Strength, Death, Hanging Chad, Sixth Sense
-- copy_card function @ funtions/common_events.lua

-- TODO LIST
-- Code and draw Chip Off The Old Mult
-- Code Integral

--- CHANGES ---
-- 0.1 - initial private build with 2 working jokers
-- 0.2 - first public release with 5 working jokers
--		0.2.2 - Updated README.md to better fit joker descriptions,
--       	  - Added a flag to prevent Korny Joker from respawning
--       	  - Added memorized card counter and last card memorized info to Memory Card's description
--			  - Added Xchips and Emult functionality
--		0.2.3 - updated Memory Card's art (made the 8 higher res)
--			  - Made Korny Joker and Memory Card's descriptions less verbose
-- 0.5 - first major update with 3 jokers, memory card update, artwork and description tweaks and artwork credits

--- GOALS FOR 1.0.0 ---
-- 1. Have at least 8 fully implemented and working jokers (currently 8, so D O N E)
-- 2. Have at least one feature that isn't a joker (currently none)
-- 3. Have locs for at least en-us and pt-br (currently only en-us)
-- 4. Have every artwork credited in info_queue (D O N E)


------------------- LAST UPDATES ------------------------ 13/10/2024, v0.5.2

-- Improved memcard's code and added better compat with modded suits


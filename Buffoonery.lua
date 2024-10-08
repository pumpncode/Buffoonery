--- STEAMODDED HEADER
--- MOD_NAME: Buffoonery
--- MOD_ID: Buffoonery
--- MOD_DESCRIPTION: Listen, I wanted to make jokers too.
--- MOD_AUTHOR: [PinkMaggit]
--- LOADER_VERSION_GEQ: 1.0.0
--- VERSION: 0.2.3

SMODS.Atlas {
    key = 'maggitsjokeratlas',
    path = "atlas.png",
    px = 71,
    py = 95
}

NFS.load(SMODS.current_mod.path .. 'jokers/cashout.lua')()
--NFS.load(SMODS.current_mod.path .. 'jokers/cotom.lua')()
--NFS.load(SMODS.current_mod.path .. 'jokers/integral.lua')()
NFS.load(SMODS.current_mod.path .. 'jokers/korny.lua')()
NFS.load(SMODS.current_mod.path .. 'jokers/memcard.lua')()
NFS.load(SMODS.current_mod.path .. 'jokers/rerollin.lua')()
NFS.load(SMODS.current_mod.path .. 'jokers/whitepony.lua')()

-- TODO LIST
-- Draw and code SOAC
-- Draw and code Medioker
-- Code Chip Off The Old Mult
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

--- GOALS FOR 1.0.0 ---
-- 1. Have at least 8 fully implemented and working jokers (currently 5)
-- 2. Have at least one feature that isn't a joker (currently none)
-- 3. Have locs for at least en-us and pt-br (currently only en-us)
-- 4. Have every artwork credited in info_queue(currently none)


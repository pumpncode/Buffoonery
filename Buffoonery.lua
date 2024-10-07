--- STEAMODDED HEADER
--- MOD_NAME: Buffoonery
--- MOD_ID: Buffoonery
--- MOD_DESCRIPTION: Listen, I wanted to make jokers too.
--- MOD_AUTHOR: [PinkMaggit]
--- LOADER_VERSION_GEQ: 1.0.0
--- VERSION: 0.1

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
-- Add flags to prevent spawning of Korny Joker more than once
-- Code Chip Off The Old Mult
-- Code Integral

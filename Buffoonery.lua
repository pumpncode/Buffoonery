-- Helloooo, we hope you're having a wonderful time with the Mod! :)

--## PinkMaggit - TODO's:
-- Jeb art: Quaoar, Makemake, Sedna, Haumea
-- Continue Saya art
--  --> I made Saya a bit easier to work with -Flowire
-- ...

--## Flowire - TODO's:
-- Test "https://github.com/Mathguy23/CollectorsCards" with both "Memory-Cards" and "Supportive"
-- once the Mod has been updated... But I don't believe it will cause any problems.
-- Known Bug: Multiple Maggits spawn Multiple Jokers (instead of One spawning a Joker for all others)
-- ...

print("Loading: 'Buffoonery_FlowMod'")
----------------------------------------------
------------MOD CODE -------------------------
Buffoonery = SMODS.current_mod
Buffoonery.Debug = true

--## Mod Integrity
SMODS.Atlas({ key = "modicon", path = "modicon.png", px = 34, py = 34 })

--## Compatibility
Buffoonery.compat = {
	-- Sleeves: Moar Content!!!
	sleeves = (SMODS.Mods['CardSleeves'] or {}).can_load,
	-- Talisman: Math-Stuff, E-Math, etc.
	talisman = (SMODS.Mods['Talisman'] or {}).can_load,
	-- Others: Generic Compatibility
	bunco = (SMODS.Mods['Bunco'] or {}).can_load,
	prism = (SMODS.Mods['Prism'] or {}).can_load,
	semby = (SMODS.Mods['SEMBY'] or {}).can_load,
	unstable = (SMODS.Mods['UnStable'] or {}).can_load,
}

--## Textures, Sounds & Colours
-- Textures
SMODS.Atlas({ key = 'buf_consumables', path = "consumables.png", px = 71, py = 95 })
SMODS.Atlas({ key = 'buf_decks', path = "decks.png", px = 71, py = 95 })
SMODS.Atlas({ key = 'buf_enhancements', path = "enhancements.png", px = 71, py = 95 })
SMODS.Atlas({ key = 'buf_jokers', path = "jokers.png", px = 71, py = 95 })
SMODS.Atlas({ key = 'buf_stakes', path = "stakes.png", px = 29, py = 29 })
SMODS.Atlas({ key = 'buf_stickers', path = "stickers.png", px = 71, py = 95 })
if Buffoonery.compat.sleeves then SMODS.Atlas({ key = 'buf_sleeves', path = "sleeves.png", px = 73, py = 95 }) end
-- Sounds
SMODS.Sound:register_global() --> 'emult.wav' and 'echip.wav' by HexaCryonic
-- Colours
loc_colour()
G.C.BUF_SPC = HEX('ee8f8d')
G.C.EMULT = HEX('fd8d55')
G.C.ECHIP = HEX('00c1d6')
SMODS.Gradient{ key = 'expmult', colours = { G.C.EMULT, G.C.RED }, cycle = 2.6, }
G.ARGS.LOC_COLOURS.expmult = SMODS.Gradients.buf_expmult
SMODS.Gradient{ key = 'expchips', colours = { G.C.ECHIP, G.C.BLUE }, cycle = 2.6, }
G.ARGS.LOC_COLOURS.expchips = SMODS.Gradients.buf_expchips

--## Content
-- > Modified Shimmerberry Folder-Loader
function SEMBY_load_dir(directory)
	directory = "content/"..directory --> All Content is in here.
	local files = NFS.getDirectoryItems(Buffoonery.path.."/"..directory)
	for _, filename in ipairs(files) do
		local file_path = directory .. "/" .. filename
		if file_path:match(".lua$") then
			assert(SMODS.load_file(file_path))()
		end
	end
end
-- > Content-Folders
SEMBY_load_dir('functions')
SEMBY_load_dir('object_types')
SEMBY_load_dir('enhancements')
SEMBY_load_dir('consumables')
--SEMBY_load_dir('jokers')
--SEMBY_load_dir('jokers/special')
assert(SMODS.load_file("content/joker_order.lua"))() --> Manual Load-Order.
SEMBY_load_dir('stakes')
SEMBY_load_dir('decks')
if Buffoonery.compat.sleeves then SEMBY_load_dir('decks/sleeves') end
SEMBY_load_dir('mod_tabs')

------------MOD CODE END----------------------
----------------------------------------------
print("Finished: 'Buffoonery_FlowMod'")

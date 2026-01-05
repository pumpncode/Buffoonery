-- Compatibility for bunco/prism's stakes
prestake_pldm = 'gold'
if Buffoonery.compat.bunco then
	prestake_pldm = 'bunco_gold'
end
if Buffoonery.compat.prism then
	prestake_pldm = 'prism_platinum'
end

SMODS.Stake{
    key = 'palladium',
	name = 'Palladium Stake',
	unlocked_stake = 'buf_spinel',
    applied_stakes = {prestake_pldm},
    above_stake = prestake_pldm,
    prefix_config = {
		above_stake = { mod = false },
		applied_stakes = { mod = false }
	},
    atlas = 'buf_stakes',
    pos = { x = 0, y = 0 },
    sticker_atlas = 'buf_stickers',
    sticker_pos = { x = 0, y = 0 },
    colour = HEX('b0a190'),
	shader = 'shine',
	shiny = true,
    modifiers = function()
		G.GAME.modifiers.buf_halfstep_bosses = true
		--> See: lovely/halfstep_bosses.toml
    end
}

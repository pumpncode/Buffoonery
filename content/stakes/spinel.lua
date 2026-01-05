SMODS.Stake{
    key = 'spinel',
	name = 'Spinel Stake',
    applied_stakes = {'buf_palladium'},
    above_stake = 'buf_palladium',
    prefix_config = {
		above_stake = { mod = false },
		applied_stakes = { mod = false }
	},
    atlas = 'buf_stakes',
    pos = { x = 1, y = 0 },
    sticker_atlas = 'buf_stickers',
    sticker_pos = { x = 1, y = 0 },
    colour = HEX('e1345d'),
	shader = 'shine',
	shiny = true,
    modifiers = function()
		G.GAME.win_ante = math.floor(G.GAME.win_ante * 1.5 + 0.5)
    end
}

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
	sleeves = (SMODS.Mods['CardSleeves'] or {}).can_load,
	unstable = (SMODS.Mods['UnStable'] or {}).can_load,
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

------ CHANGELOG MOVED TO SEPARATE .md FILE ------


function Card:get_chip_x_bonus()
    if self.debuff then return 0 end
    if self.ability.set == 'Joker' then return 0 end
    if (self.ability.x_chips or 0) <= 1 then return 0 end
    return self.ability.x_chips
end
function Card:get_chip_e_mult()
    if self.debuff then return 0 end
    if self.ability.set == 'Joker' then return 0 end
    if (self.ability.e_mult or 0) <= 1 then return 0 end
    return self.ability.e_mult
end


-- Steamodded calculation API: add extra operations
if SMODS and SMODS.calculate_individual_effect then
  local scie = SMODS.calculate_individual_effect
  function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
    -- For some reason, some keys' animations are completely removed
    -- I think this is caused by a lovely patch conflict
    --if key == 'chip_mod' then key = 'chips' end
    --if key == 'mult_mod' then key = 'mult' end
    --if key == 'Xmult_mod' then key = 'x_mult' end
    local ret = scie(effect, scored_card, key, amount, from_edition)
    if ret then
      return ret
    end
    if (key == 'x_chips' or key == 'xchips' or key == 'Xchip_mod') and amount ~= 1 then 
      if effect.card then juice_card(effect.card) end
      hand_chips = mod_chips(hand_chips * amount)
      update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
      if not effect.remove_default_message then
          if from_edition then
              card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = "X"..amount, colour =  G.C.EDITION, edition = true})
          elseif key ~= 'Xchip_mod' then
              if effect.xchip_message then
                  card_eval_status_text(scored_card or effect.card or effect.focus, 'extra', nil, percent, nil, effect.xchip_message)
              else
                  card_eval_status_text(scored_card or effect.card or effect.focus, 'x_chips', amount, percent)
              end
          end
      end
      return true
    end
	
	if (key == 'e_mult' or key == 'emult' or key == 'Emult_mod') and amount ~= 1 then 
      if effect.card then juice_card(effect.card) end
      mult = mod_chips(mult ^ amount)
      update_hand_text({delay = 0}, {chips = hand_chips, mult = mult})
      if not effect.remove_default_message then
          if from_edition then
              card_eval_status_text(scored_card, 'jokers', nil, percent, nil, {message = "^"..amount.." Mult", colour =  G.C.EDITION, edition = true})
          elseif key ~= 'Emult_mod' then
              if effect.emult_message then
                  card_eval_status_text(scored_card or effect.card or effect.focus, 'extra', nil, percent, nil, effect.emult_message)
              else
                  card_eval_status_text(scored_card or effect.card or effect.focus, 'e_mult', amount, percent)
              end
          end
      end
      return true
    end
  end
  for _, v in ipairs({'x_chips', 'e_mult', 'xchips', 'emult', 'Xchip_mod', 'Emult_mod',}) do
    table.insert(SMODS.calculation_keys, v)
  end
end
	
	
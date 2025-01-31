if SMODS and SMODS.calculate_individual_effect then
  local originalCalcIndiv = SMODS.calculate_individual_effect
  function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
    local ret = originalCalcIndiv(effect, scored_card, key, amount, from_edition)
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
  for _, v in ipairs({'x_chips', 'e_mult',
                      'xchips', 'emult',
                      'Xchip_mod', 'Emult_mod'}) do
    table.insert(SMODS.calculation_keys, v)
  end
end
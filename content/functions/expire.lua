-- Function to remove a Joker with the Cavendish animation
function expire_card(card, silent)
	G.E_MANAGER:add_event(Event({
		func = function()
			if not silent then
				play_sound('tarot1')
			end
			card.T.r = -0.2
			card:juice_up(0.3, 0.4)
			card.states.drag.is = true
			card.children.center.pinch.x = true
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.3,
				blockable = false,
				blocking = false,
				func = function()
					--G.jokers:removecard(card)
					card:remove()
					card = nil
					return true
				end
			}))
			return true
		end
	}))
end

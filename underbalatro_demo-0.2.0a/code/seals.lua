-- Echo Flower

SMODS.Atlas{
	key = 'echoflower',
	path = 'echoflower.png',
	px = 71,
	py = 95
}

SMODS.Seal{
	key = 'echo_flower',
	loc_txt = {
		name = 'Echo Flower',
		text = {
			'Retrigger this',
			'card from {C:attention}1{}',
			'to {C:attention}3{} times'
		},
		label = 'Echo Flower'
	},
	atlas = 'echoflower',
	badge_colour = HEX('00ffc3'),
	sound = { sound = 'gold_seal', per = 1.2, vol = 0.4 },
	calculate = function(self,card,context)
		if context.repetition then
			return {repetitions = math.random(1,3)}
		end
	end
}

-- Defend

SMODS.Atlas{
	key = 'defend',
	path = 'defend.png',
	px = 71,
	py = 95
}


SMODS.Seal{
	key = 'defend',
	loc_txt = {
		name = 'Defend',
		text = {
			'{C:purple}+50%{} Score'
		},
		label = 'Defend'
	},
	atlas = 'defend',
	badge_colour = G.C.PURPLE,
	sound = { sound = 'gold_seal', per = 1.2, vol = 0.4 },
	calculate = function(self,card,context)
		if context.main_scoring then
			local perc = G.GAME.chips * 0.5
			G.GAME.chips = G.GAME.chips +perc
			return {
				message = "+"..perc.." Score!",
				colour = G.C.PURPLE
			}
		end
	end
}
-- Dreamy

SMODS.Atlas{
	key = 'dreamy',
	path = 'dreamy.png',
	px = 71,
	py = 95
}

SMODS.Enhancement{
	key = "dreams",
	loc_txt = {
		name = "Dreams",
		text = {
			"{X:ub_rainbow,C:black}X1.5{} of whatever",
			'you dream of'
		},
	},
	config = {extra = {
		Xmult = 0,
		Xchips = 0
	}
	},
	atlas = "dreamy",
	calculate = function(self,card,context)
		if context.main_scoring then
			return { 
				Xmult_mod = 1.5, 
				Xchips_mod = 1.5,
				message = "X1.5 Chips and Mult",
				colour = G.C.PURPLE
			}
		end
	end
}

-- Frozen

SMODS.Enhancement{
	key = "snowy",
	loc_txt = {
		name = "Frozen",
		text = {
			'{X:chips,C:white}X1.3{} Chips for',
			'every other {C:planet}Frozen{}',
			'card held in hand'
		}
	},
	config = {extra = {

	}
	},
    pos = {x=6,y=1},
	atlas = "spritesheet",
	calculate = function(self,card,context)
		if context.main_scoring and context.cardarea == G.play then
			local snowy_xchips = 1
			for _,i in ipairs(G.hand.cards) do
				if SMODS.has_enhancement(i, 'm_ub_snowy') then
					snowy_xchips = snowy_xchips +0.3
				end
			end
			return {xchips = snowy_xchips}
		end
	end
}
-- Determination

SMODS.Atlas{
	key = 'determination',
	path = 'determination.png',
	px = 71,
	py = 95
}

SMODS.Joker{
	key = "det",
	loc_txt = {
		name = 'Determination',
		text = {
			'{C:mult}+2{} mult when blind selected',
			'{C:inactive}(Currently {}{C:mult}+#1#{}{C:inactive} mult){}'
		}
	},
	atlas = 'determination',
	cost = 4,
	pos = {x = 0, y = 0},
	config = { extra = {
		mult = 0,
		mult_gain = 2
   	},
    },
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.mult} }
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.setting_blind then
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
			return { 
					message = localize('k_upgrade_ex'),
					colour = G.C.RED
				 }
		end
		if context.joker_main then
			return { mult = card.ability.extra.mult }
		end
	end	
}

-- Bravery

SMODS.Atlas{
	key = 'bravery',
	path = 'bravery.png',
	px = 71,
	py = 95
}

SMODS.Joker{
	key = "bravery",
	loc_txt = {
		name = 'Bravery',
		text = {
			'Gives {C:money}$1{} for every',
			'scoring {C:attention}10{}',
		}
	},
	atlas = 'bravery',
	cost = 3,
	pos = {x = 0, y = 0},
	config = { extra = {
		money = 0
   	},
    },
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)

    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.joker_main then
			for _, c in ipairs(context.scoring_hand) do
				if c:get_id() == 10 then
    				ease_dollars(1)
				end
			end
		end
	end	
}

-- Justice

SMODS.Atlas{
	key = 'justice',
	path = 'justice.png',
	px = 71,
	py = 95
}

SMODS.Joker{
	key = "justice",
	loc_txt = {
		name = 'Justice',
		text = {
			'Create a {C:attention}Bullet{} consumeable',
			'when blind selected'
		}
	},
	atlas = 'justice',
	cost = 5,
	pos = {x = 0, y = 0},
	config = { extra = {
		mult = 0,
		mult_gain = 2
   	},
    },
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {key='bullet', set='Other'}
		return { vars = {card.ability.extra.mult} }
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.setting_blind then
			SMODS.add_card{ key = "c_ub_bullet" }
		end
	end	
}
G.localization.descriptions.Other['bullet'] = {
    name = 'Bullet',
    text = {
        "Destroy {C:attention}1{}",
		"selected card",
    }
}

-- Kindness

SMODS.Atlas{
	key = 'kindness',
	path = 'kindness.png',
	px = 71,
	py = 95
}

SMODS.Joker{
	key = "kindness",
	loc_txt = {
		name = 'Kindness',
		text = {
			'{C:green}#1# in 3{} chance to give',
			'{C:mult}+25{} mult',
		}
	},
	atlas = 'kindness',
	cost = 4,
	pos = {x = 0, y = 0},
	config = { extra = {

   	},
    },
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
        return {vars = {(G.GAME and G.GAME.probabilities.normal or 1)}}
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.joker_main then
			if pseudorandom('kindness') < G.GAME.probabilities.normal/3 then
				return { mult = 25 }
			end
		end
	end	
}

-- Patience

SMODS.Atlas{
	key = 'patience',
	path = 'patience.png',
	px = 71,
	py = 95
}

SMODS.Joker{
	key = "patience",
	loc_txt = {
		name = 'Patience',
		text = {
			'{C:chips}+4{} Chips when round ends',
			'{C:inactive}(Currently {}{C:chips}+#1#{}{C:inactive} chips){}',
		}
	},
	atlas = 'patience',
	cost = 4,
	pos = {x = 0, y = 0},
	config = { extra = {
		chips = 0,
		chip_gain = 4
   	},
    },
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.chips} }
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.joker_main then
			return { chips = card.ability.extra.chips }
		end
		if context.end_of_round and context.main_eval then
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
			return { 
					message = localize('k_upgrade_ex'),
					colour = G.C.RED
				 }
		end
	end	
}

-- Integrity

SMODS.Atlas{
	key = 'integrity',
	path = 'integrity.png',
	px = 71,
	py = 95
}

SMODS.Joker{
	key = "integrity",
	loc_txt = {
		name = 'Integrity',
		text = {
			'{C:chips}+10{} Chips whenever boss',
			'blind triggered when scoring',
			'{C:inactive}(Currently {}{C:chips}+#1#{}{C:inactive} chips){}'
		}
	},
	atlas = 'integrity',
	cost = 3,
	pos = {x = 0, y = 0},
	config = { extra = {
		chips = 0,
		chip_gain = 10
   	},
    },
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.chips} }
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.debuffed_hand or context.joker_main then
			if G.GAME.blind.triggered then
				card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_gain
				return { 
					message = localize('k_upgrade_ex'),
					colour = G.C.RED
				 }
			end
			return { chips = card.ability.extra.chips }
		end
	end	
}

-- Perseverance

SMODS.Atlas{
	key = 'perseverance',
	path = 'perseverance.png',
	px = 71,
	py = 95
}

SMODS.Joker{
	key = "perseverance",
	loc_txt = {
		name = 'Perseverance',
		text = {
			'Retrigger every scoring',
			'{C:attention}Enhanced card{} once',
		}
	},
	atlas = 'perseverance',
	cost = 4,
	pos = {x = 0, y = 0},
	config = { extra = {

   	},
    },
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)

    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.repetition and next(SMODS.get_enhancements(context.other_card)) then
			return { repetitions = 1 } 
		end
	end	
}

-- Monster Soul

SMODS.Atlas{
	key = 'monster',
	path = 'monster.png',
	px = 71,
	py = 95
}

SMODS.Joker{
	key = "monster",
	loc_txt = {
		name = 'Monster Soul',
		text = {
			'{C:red,E:2}Self destructs{} when round ends,',
			'and gives {C:money}$10{}',
		}
	},
	atlas = 'monster',
	cost = 5,
	pos = {x = 0, y = 0},
	config = { extra = {

   	},
    },
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)

    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.end_of_round and context.main_eval then
			card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
			ease_dollars(10)
			return {
				message = "Dissolved...",
				colour = G.C.RED
			}
		end
	end	
}

-- Soul Wheel

SMODS.Atlas{
	key = 'soulwheel',
	path = 'soulwheel.png',
	px = 71,
	py = 95
}

SMODS.Joker{
	key = "soulwheel",
	loc_txt = {
		name = 'Soul Wheel',
		text = {
			'Every round, this card will',
			'act as a different {C:attention}Soul{}'
		}
	},
	atlas = 'soulwheel',
	cost = 6,
	rarity = 2,
	pos = {x = 0, y = 0},
	config = { extra = {
		soul = 'j_ub_det',
		souln = 1,
		souls = {
			'j_ub_det',
			'j_ub_bravery',
			'j_ub_justice',
			'j_ub_kindness',
			'j_ub_patience',
			'j_ub_integrity',
			'j_ub_perseverance'
		}
   	},
    },
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS[card.ability.extra.soul]
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.end_of_round and context.main_eval then
			card.ability.extra.souln = card.ability.extra.souln+1
			if card.ability.extra.souln >= 8 then
				card.ability.extra.souln = 1
			end
			card.ability.extra.soul = card.ability.extra.souls[card.ability.extra.souln]
		end
		return UNDERBALATRO.mod.get_joker_return(card.ability.extra.soul,context,card,false)
	end	
}

-- Flowey

SMODS.Atlas{
	key = 'flowey',
	path = 'flowey.png',
	px = 71,
	py = 95
}

SMODS.Joker{
	key = "flowey",
	loc_txt = {
		name = 'Flowey',
		text = {
			'When {C:attention}Blind{} is selected,',
			'destroy Joker to the left, and gain {X:chips,C:white}X0.5{}.',
			--[[
			'Destroy every different {C:attention}Soul{}',
			'card to transform into a {C:dark_edition}powerful being{}',
			'Destroy 6 {C:attention}Monster Souls{} to transform',
			'into a {C:ub_rainbow}dreamy being{}',
			--]]
			'{C:inactive}(Currently {X:chips,C:white}X#1#{C:inactive} mult)'
		}
	},
	atlas = 'flowey',
	cost = 5,
	rarity = 2,
	pos = {x = 0, y = 0},
	config = { extra = {
		Xchips = 1,
		souls = {
			'j_ub_det',
			'j_ub_bravery',
			'j_ub_justice',
			'j_ub_kindness',
			'j_ub_patience',
			'j_ub_integrity',
			'j_ub_perseverance'
		},
		destroyed_j = {},
		done = 0
   	},
    },
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return { vars = {card.ability.extra.Xchips} }
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.setting_blind then
			local other_joker = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					other_joker = G.jokers.cards[i-1]
				end
			end
			if other_joker and other_joker ~= self then
				--table.insert(card.ability.extra.destroyed_j, other_joker.config.center.key)
				other_joker:start_dissolve({ HEX("57ecab") }, nil, 1.6)
				card.ability.extra.Xchips = card.ability.extra.Xchips + 0.5
				return { 
					message = localize('k_upgrade_ex'),
					colour = G.C.BLUE
				 }
			end
			--[[
			for _, i in ipairs(card.ability.extra.souls) do
				if table.contains(card.ability.extra.destroyed_j,i) then
					card.ability.extra.done = card.ability.extra.done + 1
					table.remove(card.ability.extra.souls, i)
				end
			end
			if card.ability.extra.done == 7 then
				SMODS.add_card({key = 'j_ub_photoshop'})
				return {
					message = "EVOLVING",
					colour = G.C.DARK_EDITION
				}
			end
			--]]
		end
		if context.joker_main then
			return { xchips = card.ability.extra.Xchips }
		end
	end	
}

-- OMEGA FLOWEY
--[[
SMODS.Joker{
	key = "photoshop",
	loc_txt = {
		name = '{C:dark_edition}Omega Flowey',
		text = {
			'Every round, this card will',
			'act as a different {C:attention}Soul{}'
		}
	},
	atlas = 'ph2',
	cost = 6,
	rarity = 4,
	pos = {x = 0, y = 0},
	in_pool = function(self, args)
		return false
	end,
	config = { extra = {
		
   	},
    },
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {key='ph', set='Other'}
        info_queue[#info_queue+1] = {key='unfinished', set='Other'}
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.end_of_round and context.main_eval then
			card.ability.extra.souln = card.ability.extra.souln+1
			if card.ability.extra.souln >= 8 then
				card.ability.extra.souln = 1
			end
			card.ability.extra.soul = card.ability.extra.souls[card.ability.extra.souln]
		end
		return UNDERBALATRO.get_joker_return(card.ability.extra.soul,context,card,false)
	end	
}]]

-- Amalgam

SMODS.Atlas{
	key = 'amalgam',
	path = 'amalgam.png',
	px = 71,
	py = 95
}

SMODS.Joker{
	key = "amalgam",
	loc_txt = {
		name = 'Amalgam',
		text = {
			'When blind selected, destroy {C:attention}Joker{} to the left and',
			'to the right, and copy the ability of both.',
			'{C:inactive}(Must be Jokers to the left and to the right)'
		}
	},
	atlas = 'amalgam',
	cost = 7,
	rarity = 3,
	pos = {x = 0, y = 0},
	config = { extra = {
		jl = '',
		jr = ''
   	},
    },
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS[card.ability.extra.jl]
		info_queue[#info_queue+1] = G.P_CENTERS[card.ability.extra.jr]
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.setting_blind then
			if card.ability.extra.jl == '' and card.ability.extra.jr == '' then
				local other_joker = nil
				for i = 1, #G.jokers.cards do
					if G.jokers.cards[i] == card then
						other_joker = G.jokers.cards[i-1]
					end
				end
				if other_joker and other_joker ~= self then
					card.ability.extra.jl = other_joker.config.center.key
					other_joker:start_dissolve({ HEX("57ecab") }, nil, 1.6)
				end
				other_joker = nil
				for i = 1, #G.jokers.cards do
					if G.jokers.cards[i] == card then
						other_joker = G.jokers.cards[i+1]
					end
				end
				if other_joker and other_joker ~= self then
					card.ability.extra.jr = other_joker.config.center.key
					other_joker:start_dissolve({ HEX("57ecab") }, nil, 1.6)
				end
			end
		end
		if card.ability.extra.jl ~= '' and card.ability.extra.jr ~= '' then
			local retfinal = {}
            local ret1 = UNDERBALATRO.mod.get_joker_return(card.ability.extra.jl,context,card,table.contains(UNDERBALATRO.mod.jokers_key,card.ability.extra.jl))
            local ret2 = UNDERBALATRO.mod.get_joker_return(card.ability.extra.jr,context,card,table.contains(UNDERBALATRO.mod.jokers_key,card.ability.extra.jr))
            if ret1 then
                table.insert(retfinal, ret1)
            end
            if ret2 then
                table.insert(retfinal, ret2)
            end
            return SMODS.merge_effects(retfinal)
		end
	end	
}

-- G

SMODS.Atlas{
	key = 'g',
	path = 'g.png',
	px = 71,
	py = 95
}

SMODS.Joker{
	key = "g",
	loc_txt = {
		name = 'G..?!',
		text = {
			'Whoops! Wrong number...',
			'{C:green}#1# in 3{} chance for {X:mult,C:white}X3',
			'mult.',
			'{C:green}#1# in 200{} chance for some {C:dark_edition}fun'
		}
	},
	atlas = 'g',
	cost = 5,
	rarity = 2,
	pos = {x = 0, y = 0},
	config = { extra = {
		
   	},
    },
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
        return {vars = {(G.GAME and G.GAME.probabilities.normal or 1)}}
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.setting_blind then
			if pseudorandom('failed') < G.GAME.probabilities.normal/200 then
				SMODS.add_card({key = 'j_ub_gaster'})
				card:start_dissolve({ C.G.DARK_EDITION }, nil, 1.6)
			end
		end
		if context.joker_main then
			if pseudorandom('failed') < G.GAME.probabilities.normal/3 then
				return {Xmult = 3}
			end
		end
	end	
}

-- GASTER

SMODS.Atlas{
	key = 'gaster',
	path = 'gaster.png',
	px = 71,
	py = 95
}

SMODS.Joker{
	key = "gaster",
	loc_txt = {
		name = '{C:dark_edition}Gaster',
		text = {
			'Entry number seventeen.',
			'Dark, darker, yet darker.',
			'The darkness keeps growing.',
			'The shadows cutting deeper.',
			'Photon readings negative.',
			'This next experiment seems...',
			'very... very... interesting.',
			'What do you {C:dark_edition}___{} think?',
			'.',
			'{C:dark_edition}#1#%'
		}
	},
	atlas = 'gaster',
	cost = 20,
	rarity = 4,
	pos = {x = 0, y = 0},
	in_pool = function(self, args)
		return false
	end,
	config = { extra = {
		perc = 0
   	},
    },
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.perc}}
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.other_joker then
			if card.ability.extra.perc <= 100 then
				card.ability.extra.perc = card.ability.extra.perc + 2
				return {
					message = '+2%',
					colour = G.C.DARK_EDITION
				}
			end
		end
		if context.setting_blind then
			if card.ability.extra.perc >= 100 then
				SMODS.add_card({key = "c_ub_failed"})
			end
		end
	end	
}

-- The Ferryman

SMODS.Atlas{
	key = 'ferrymanex',
	path = 'ferrymanex.png',
	px = 71,
	py = 95
}

SMODS.Joker{
	key = "ferryman",
	loc_txt = {
		name = 'The Ferryman',
		text = {
			{
				'Wander through the waters, and get {C:purple}adviced'
			},
			{
				'{C:purple, E:1}Tra la la',
				"#1#",
				"{C:inactive, S:0.7}#2#"
			},
		}
	},
	atlas = 'ferrymanex',
	cost = 7,
	rarity = 3,
	pos = {x = 0, y = 0},
	config = { extra = {
		abil = "What\'s my name?... It doesn\'t really matter..",
		element = 1,
		possibils = {
			"What\'s my name?... It doesn\'t really matter..", -- +1 mult | 1
			"Tri li li. Tre le le", -- X2 mult | 2
			"The water is very wet today", -- +50 chips | 3
			"The water is very dry today", -- X2.5 chips | 4
			"Eat a mushroom everyday. Why? Then I know you\'re listening to me...", -- Retrigger first scoring card | 5
			"Did you ever hear the old song coming from the sea?", -- Copies ability of joker to the left | 6
			"The angel is coming... Tra la la", -- Create a Negative DELTA RUNE | 7
			"Beware of the man who speaks in hands.", -- X3 mult if you have G..?!, and X5 mult if you have Gaster | 8
			"Somewhere, it\'s 2025. So be careful.", -- -5 mult | 9
			"The piano plays the tinkling song. Hmm... tinkling.", -- Odd (wip) | 10
			"I heard spiders have a favorite food. It\'s spiders.", -- +1$ per scoring card | 11
			"I heard ASGORE has a favorite food.", -- Buff asgore (if you have him) | 12
			"You can never have too many hot dogs... Sadly, this is not true", -- Draw 29 cards on the start of the blind | 13
			"Don\'t snoop behind people's houses... You might be mistaken for a trash-can", -- +2 discards | 14
			"What\'s a game you can play with a dog? Asking for a friend...", -- +1 hand | 15
			"Temmie Village...", -- Transform a random PLACE Joker into Temmie Village (must have PLACE Joker) | 16
			"Humans, monsters... Flowers.", -- Create a Negative Flowey | 17
			"Why don\'t you sing with me. Tra la la.", -- Copies ability of joker to the right | 18
			"Ah.", -- -1 discard | 19
			"Uh oh. Suddenly, feeling tropical.", -- +100 chips, +5 mult | 20
			"Hmmm... I should have worn a few more pairs of pants today", -- Level up Two Pair | 21
			"Hmmm... I should have worn a few million more pairs of pants today", -- Get a Negative Spare Trousers | 22
			"The waters are wild today. That\'s bad luck", -- 1 in 5 to give -10 mult | 23
			"The waters are wild today. That\'s good luck", -- 1 in 5 to give +20 mult | 24
		},
		does = {
			"+1 mult", -- 1 {C:mult}+1{C:inactive} mult
			"X2 mult", -- 2 {X:mult, C:white}X2{C:inactive} mult
			"+50 chips", -- 3 {C:chips}+50{C:inactive} chips
			"X2.5 chips", -- 4 {X:chips, C:white}X2.5{C:inactive} chips
			"Retrigger first scoring card", -- 5 Retrigger {C:attention}first{C:inactive} scoring card
			"Copies ability of Joker to the left", -- 6 Copies ability of {C:attention}Joker{C:inactive} to the left
			"Create a Negative Delta Rune", -- 7 Create a {C:dark_edition}Negative{C:attention} Delta Rune
			"X3 mult if you have G..?!", -- 8 {X:mult, C:white}X3{C:inactive} mult if you have {C:attention}G..?!
			"-5 mult", -- 9 {C:mult}-5{C:inactive} mult
			"I\'ve heard that song before...", -- 10 {C:ub_rainbow}I\'ve heard that song before...
			"+$1 per scoring card", -- 11 {C:money}+$1{C:inactive} per scoring card
			"Obtain a Negative Butterscotch Pie Consumeable", -- 12
			"+29 hand size", -- 13 {C:attention}+29{C:inactive} hand size
			"+2 discards this round", -- 14 {C:red}+2{C:inactive} discards this round
			"+1 Hand this round", -- 15 {C:blue}+1{C:inactive} Hand this round
			"Transform a Place Joker into Temmie Village (Must have Place Jokers)", -- 16 Transform a {C:attention}Place{C:inactive} Joker into {C:attention}Temmie Village
			"Create a Negative Flowey", -- 17 Create a {C:dark_edition}Negative{C:attention} Flowey
			"Copies ability of Joker to the right", -- 18 Copies ability of {C:attention}Joker{C:inactive} to the right
			"-1 discards this round", -- 19 {C:red}-1{C:inactive} discards this round
			"+100 chips and +5 mult", -- 20 {C:chips}+100{C:inactive} chips and {C:mult}+5{C:inactive} mult
			"Level up Two Pair", -- 21 Level up {C:attention}Two Pair
			"Create a Negative Spare Trousers", -- 22 Create a {C:dark_edition}Negative{C:attention} Spare Trousers
			"1 in 5 chance for -10 mult", -- 23 {C:green}1 in 5{C:inactive} chance for {C:mult}-10{C:inactive} mult
			"1 in 5 chance for +20 mult", -- 24 {C:green}1 in 5{C:inactive} chance for {C:mult}+20{C:inactive} mult
		}
   	},
    },
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.abil, card.ability.extra.does[card.ability.extra.element]}}
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		local abil = card.ability.extra.element
		if context.end_of_round and context.main_eval then
			if abil == 14 then
				G.E_MANAGER:add_event(Event({
					func = function()
						ease_discard(-2, nil, true)
						return true
					end
				}))
			elseif abil == 13 then
				G.E_MANAGER:add_event(Event({
					func = function()
						G.hand:change_size(-29)
						return true
					end
				}))
			elseif abil == 15 then
				G.E_MANAGER:add_event(Event({
					func = function()
						ease_hands_played(-1,nil)
						return true
					end
				}))
			elseif abil == 19 then
				G.E_MANAGER:add_event(Event({
					func = function()
						ease_discard(1,nil, true)
						return true
					end
				}))
			end
			card.ability.extra.element = math.random(1,#card.ability.extra.possibils)
			card.ability.extra.abil = card.ability.extra.possibils[card.ability.extra.element]
			abil = card.ability.extra.element

			if abil == 7 then
				SMODS.add_card({key="j_ub_deltarune", edition = "e_negative"})
			elseif abil == 17 then
				SMODS.add_card({key = "j_ub_flowey", edition = "e_negative"})
			elseif abil == 22 then
				SMODS.add_card({key="j_trousers", edition = "e_negative"})
            elseif abil == 12 then
                SMODS.add_card({key="c_ub_pie", edition = "e_negative"})
			elseif abil == 21 then
				return {level_up = true, level_up_hand = "Two Pair"}
			end
		end
		abil = card.ability.extra.element
		if abil == 6 then
			local other_joker = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					other_joker = G.jokers.cards[i-1]
				end
			end
			if other_joker and other_joker ~= self then
				context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
				context.blueprint_card = context.blueprint_card or card

				if context.blueprint > #G.jokers.cards + 1 then
					return
				end

				local other_joker_ret, trig = other_joker:calculate_joker(context)
				if other_joker_ret or trig then
					if not other_joker_ret then
						other_joker_ret = {}
					end
					other_joker_ret.card = context.blueprint_card or card
					other_joker_ret.colour = G.C.bluepring
					other_joker_ret.no_callback = true
					return other_joker_ret
				end
			end
		elseif abil == 18 then
			local other_joker = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					other_joker = G.jokers.cards[i+1]
				end
			end
			if other_joker and other_joker ~= self then
				context.blueprint = (context.blueprint and (context.blueprint + 1)) or 1
				context.blueprint_card = context.blueprint_card or card

				if context.blueprint > #G.jokers.cards + 1 then
					return
				end

				local other_joker_ret, trig = other_joker:calculate_joker(context)
				if other_joker_ret or trig then
					if not other_joker_ret then
						other_joker_ret = {}
					end
					other_joker_ret.card = context.blueprint_card or card
					other_joker_ret.colour = G.C.bluepring
					other_joker_ret.no_callback = true
					return other_joker_ret
				end
			end
		end
		if context.setting_blind then
			if abil == 14 then
				return {
					func = function()
						G.E_MANAGER:add_event(Event({
							func = function()
								ease_discard(2, nil, true)
								return true
							end
						}))
					end
				}
			elseif abil == 13 then
				return {
					func = function()
						G.E_MANAGER:add_event(Event({
							func = function()
								G.hand:change_size(29)
								return true
							end
						}))
					end
				}
			elseif abil == 15 then
				return {
					func = function()
						G.E_MANAGER:add_event(Event({
							func = function()
								ease_hands_played(1,nil)
								return true
							end
						}))
					end
				}
			elseif abil == 19 then
				return {
					func = function()
						G.E_MANAGER:add_event(Event({
							func = function()
								ease_discard(-1,nil,true)
								return true
							end
						}))
					end
				}
			end
		end
		if abil == 5 then
			if context.repetition and context.cardarea == G.play and context.other_card == context.scoring_hand[1] then
				return { repetitions = 1 }
			end
		end
		if context.joker_main then
			if abil == 1 then
				return {mult = 1}
			elseif abil == 2 then
				return {Xmult = 2}
			elseif abil == 3 then
				return {chips = 50}
			elseif abil == 4 then
				return {xchips = 2.5}
			elseif abil == 9 then
				return {mult = -5}
			elseif abil == 20 then
				return {chips = 10, mult = 5}
			elseif abil == 23 or abil == 24 then
				if pseudorandom('failed') < G.GAME.probabilities.normal/5 then
					if abil == 23 then
						return {mult = -10}
					else
						return {mult = 20}
					end
				end
			elseif abil == 8 then
				for _,i in ipairs(G.jokers.cards) do
					if i.config.center_key == "j_ub_gaster" then
						return {Xmult = 5}
					elseif i.config.center_key == "j_ub_g" then
						return {Xmult = 3}
					end
				end
			elseif abil == 11 then
				for _, c in ipairs(context.scoring_hand) do
					ease_dollars(1)
				end
			else
				return
			end
		end
	end
}

-- Delta Rune

SMODS.Atlas{
	key = 'deltarune',
	path = 'fdeltarune.png',
	px = 71,
	py = 95
}

SMODS.Joker{
	key = "deltarune",
	loc_txt = {
		name = 'Delta Rune',
		text = {
			'The {C:dark_edition}prophecy{} is {C:red,E:2}not{} finished',
			'{C:spades}1 {C:planet}2 {C:rare}3 {C:dark_edition}4 {C:green}5 {C:inactive}6 7',
			'{C:inactive,s:0.8}Currently does {C:mult,s:0.8}+25{C:inactive,s:0.8} Mult',
			'{C:green,s:0.8}#2# in 10{C:inactive,s:0.8} to break at the end of the round'
		}
	},
	atlas = 'deltarune',
	cost = 5,
	rarity = 1,
	soul_pos = {x=1, y=0},
	pos = {x = 0, y = 0},
	config = { extra = {
		Xmult = 0
   	},
    },
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.Xmult,(G.GAME and G.GAME.probabilities.normal or 1)}}
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.joker_main then
            return {mult = 25}
        end
        if context.main_eval and context.end_of_round then
            if pseudorandom('failed') < G.GAME.probabilities.normal/10 then
                card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
                return {
                    message = 'Broke!',
                    colour = G.C.attention
                }
            else
                return {
                    message = 'Safe!',
                    colour = G.C.attention
                }
            end
        end
	end	
}

-- Asgore

SMODS.Joker{
	key = "asgore",
	loc_txt = {
		name = 'Asgore',
		text = {
			'Every Hand strike a different',
			'{C:chips}Chips{} and {C:mult}Mult{} combo',
			'{C:chips}#1# {C:mult}#2#{} | {C:chips}#3# {C:mult}#4#{} | {C:chips}#5# {C:mult}#6#'
		}
	},
	atlas = 'ph2',
	cost = 4,
	rarity = 2,
	pos = {x = 0, y = 0},
	config = { extra = {
		chips1 = 100,
		mult1 = 0,
		chips2 = 100,
		mult2 = 0,
		chips3 = 0,
		mult3 = 10
   	},
    },
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {key='ph', set='Other'}
		return {vars = {
			card.ability.extra.chips1,
			card.ability.extra.mult1,
			card.ability.extra.chips2,
			card.ability.extra.mult2,
			card.ability.extra.chips3,
			card.ability.extra.mult3
		}}
    end,
	set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_prophecy'), HEX('8062d9'), G.C.WHITE, 0.8)
	end,
	calculate = function(self,card,context)
		if context.joker_main then
			return {
				chips = card.ability.extra.chips1+card.ability.extra.chips2+card.ability.extra.chips3,
				mult = card.ability.extra.mult1+card.ability.extra.mult2+card.ability.extra.mult3
			}
		end
		if context.post_joker then
			local chance = math.random(1,2)
			if chance == 1 then
				card.ability.extra.chips1 = 100
				card.ability.extra.mult1 = 0
			else
				card.ability.extra.mult1 = 10
				card.ability.extra.chips1 = 0
			end
			chance = math.random(1,2)
			if chance == 1 then
				card.ability.extra.chips2 = 100
				card.ability.extra.mult2 = 0
			else
				card.ability.extra.mult2 = 10
				card.ability.extra.chips2 = 0
			end
			chance = math.random(1,2)
			if chance == 1 then
				card.ability.extra.chips3 = 100
				card.ability.extra.mult3 = 0
			else
				card.ability.extra.mult3 = 10
				card.ability.extra.chips3 = 0
			end
		end
	end	
}

-- Susie

SMODS.Atlas{
	key = 'susie',
	path = 'susie.png',
	px = 71,
	py = 95
}

SMODS.Joker{
	key = "susie",
	loc_txt = {
		name = 'Susie',
		text = {
			'Gain {C:mult}+3{} mult for every',
			'discarded {C:attention}face card',
			'{C:inactive}(Currently {C:mult}+#1#{C:inactive} mult)'
		}
	},
	atlas = 'susie',
	cost = 5,
	rarity = 2,
	pos = {x = 0, y = 0},
	config = { extra = {
		mult = 0
   	},
    },
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return {vars = {card.ability.extra.mult}}
    end,
	set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_prophecy'), HEX('8062d9'), G.C.WHITE, 0.8)
	end,
	calculate = function(self,card,context)
		if context.discard and not context.blueprint and not context.other_card.debuff and context.other_card:is_face() then
			card.ability.extra.mult = card.ability.extra.mult + 3
			return {
					message = localize('k_upgrade_ex'),
					colour = G.C.RED
				 }
		end
		if context.joker_main then
			return {mult = card.ability.extra.mult}
		end
	end	
}

-- Ralsei

SMODS.Atlas{
	key = 'ralsei',
	path = 'ralsei.png',
	px = 71,
	py = 95
}

SMODS.Joker{
	key = "ralsei",
	loc_txt = {
		name = 'Ralsei',
		text = {
			'When {C:attention}Blind{} is selected,',
			'instantly set your score to', 
			'{C:attention}30%{} of the score requirement.',
			'{C:inactive}(Only one Ralsei works)'
		}
	},
	atlas = 'ralsei',
	cost = 5,
	rarity = 2,
	pos = {x = 0, y = 0},
	config = { extra = {
		
   	},
    },
	blueprint_compat = false,
	loc_vars = function(self, info_queue, card)

    end,
	set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_prophecy'), HEX('8062d9'), G.C.WHITE, 0.8)
	end,
	calculate = function(self,card,context)
		if context.setting_blind and not context.blueprint then
			local perc = G.GAME.blind.chips * 0.3
			G.GAME.chips = perc
			return {
					message = "+"..perc.."!",
					colour = HEX("562abd")
				}
		end
		
	end
}

-- Kris

SMODS.Atlas{
	key = 'kris',
	path = 'kris.png',
	px = 71,
	py = 95
}

SMODS.Joker{
	key = "kris",
	loc_txt = {
		name = 'Kris',
		text = {
			'Create a {C:attention}Dark Fountain{} Joker every round'
		}
	},
	atlas = 'kris',
	cost = 7,
	rarity = 2,
	pos = {x = 0, y = 0},
	config = { extra = {
		
   	},
    },
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS['j_ub_dfountain']
    end,
	set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_prophecy'), HEX('8062d9'), G.C.WHITE, 0.8)
	end,
	calculate = function(self,card,context)
		if context.end_of_round and context.main_eval then
			SMODS.add_card({key = 'j_ub_dfountain'})
		end
	end	
}

-- Dark Fountain

SMODS.Atlas{
	key = 'dfountain',
	path = 'darkfountain.png',
	px = 71,
	py = 95,
}

SMODS.Joker{
	key = "dfountain",
	loc_txt = {
		name = 'Dark Fountain',
		text = {
			{
				'{C:dark_edition}+1{} Joker slot.',
				'{X:mult,C:white}X1.3{} Mult'
			},
			{
				'Seals after {C:attention}5{} hands',
				'{C:inactive}(Currently {C:attention}#1#{C:inactive}/5)'
			}
		}
	},
	atlas = 'dfountain',
	rarity = 'ub_mystery',
	pos = {x = 0, y = 0},
	config = { extra = {
		handss = 0
   	},
    },
	in_pool = function(self,args)
		return false
	end,
	blueprint_compat = false,
	loc_vars = function(self, info_queue, card)
		return {vars={card.ability.extra.handss}}
    end,
	set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_prophecy'), HEX('8062d9'), G.C.WHITE, 0.8)
	end,
    add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + 1
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit - 1
    end,
	calculate = function(self,card,context)
		if context.press_play then
			card.ability.extra.handss = card.ability.extra.handss + 1
			if card.ability.extra.handss == 5 then
				card:start_dissolve({ HEX("584896") }, nil, 1.6)
			end
		end
		if context.joker_main then
			return {Xmult = 1.5}
		end
	end	
}

-- The Ruins

SMODS.Joker{
	key = "ruins",
	loc_txt = {
		name = 'The Ruins',
		text = {
			'Every time you score more than',
			'{C:purple}60%{} Total Score, create a ',
			'random enhanced playing card and', 
			'add it to your hand',
			'{C:inactive}(Currently #1#)'
		}
	},
	atlas = 'jatlas',
	rarity = 'ub_mystery',
	pos = {x = 1, y = 1},
    cost = 5,
	config = { extra = {
		
   	},
    },
	blueprint_compat = false,
	loc_vars = function(self, info_queue, card)
		if G.GAME.blind then
			if G.GAME.blind.chips * 0.6 then
				return {vars={G.GAME.blind.chips * 0.6}}
			else
				return {vars = {0}}
			end
		else
			return {vars = {0}}
		end
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.final_scoring_step then
			local perc = G.GAME.blind.chips * 0.6
			if hand_chips * mult > perc then
				G.E_MANAGER:add_event(Event({
					func = function()
						local _suit = pseudorandom_element({ 'S', 'H', 'D', 'C' }, pseudoseed('ruins'))
						local _number = pseudorandom_element({'A','K','Q','J','10','9','8','7','6','5','4','3','2'}, pseudoseed('ruins'))
						local _card = create_playing_card({ front = G.P_CARDS[_suit .. _number], center = G.P_CENTERS.c_base }, G.hand,
							nil, nil, { G.C.SECONDARY_SET.Enhanced })

						_card:set_ability(SMODS.poll_enhancement({guaranteed = true,type_key = 'ruins'}))
						G.GAME.blind:debuff_card(_card)
						G.hand:sort()
						card:juice_up()
						return true
					end
				}))

				playing_card_joker_effects({ true })
			end
		end
	end	
}

-- Snowdin

SMODS.Joker{
	key = "snowdin",
	loc_txt = {
		name = 'Snowdin',
		text = {
			'{C:chips}+10{} Chips for every {C:planet}Frozen',
            'card currently in the deck',
            '{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)'
		}
	},
	atlas = 'jatlas',
	rarity = 'ub_mystery',
    cost = 5,
	pos = {x = 2, y = 1},
	config = { extra = {
   	},
    },
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = G.P_CENTERS['m_ub_snowy']
        local frozens = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, 'm_ub_snowy') then frozens = frozens + 1 end
            end
        end
		return {vars={frozens*6}}
    end,
	set_badges = function(self,card,badges)

	end,
	in_pool = function(self,args)
		for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_ub_snowy') then
                return true
            end
        end
        return false
	end,
	calculate = function(self,card,context)
		if context.joker_main then
            local ch = 0
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, 'm_ub_snowy') then 
                    ch = ch + 10
                end
            end
            return {
                chips = ch
            }
        end
	end	
}

-- Waterfall

SMODS.Joker{
	key = "waterfall",
	loc_txt = {
		name = 'Waterfall',
		text = {
			'Add a {C:attention}Echo flower{} seal',
			'to {C:attention}first{} scoring card'
		}
	},
	atlas = 'ph2',
	rarity = 'ub_mystery',
	pos = {x = 0, y = 0},
    cost = 6,
	config = { extra = {
		
   	},
    },
	blueprint_compat = false,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {key='ph', set='Other'}
		info_queue[#info_queue+1] = G.P_CENTERS['ub_echo_flower']
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.individual and context.cardarea == G.play then
			local area = context.scoring_hand
			if area[1] then
				G.E_MANAGER:add_event(Event({
					func = function()
						area[1]:set_seal('ub_echo_flower')
						return true
					end
				}))	
			end
		end	
	end	
}

-- Hotland

SMODS.Joker{
	key = "hotland",
	loc_txt = {
		name = 'Hotland',
		text = {
			'If {C:attention}first hand{} of round',
			'has only {C:attention}1{} card, melt',
			'that card, and gain {C:mult}+5{} mult.',
			'{C:inactive}(Currently {C:mult}+#1#{C:inactive} mult)'
		}
	},
	atlas = 'ph2',
	rarity = 'ub_mystery',
	pos = {x = 0, y = 0},
    cost = 5,
	config = { extra = {
		mult = 0
   	},
    },
	blueprint_compat = false,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {key='ph', set='Other'}
		return {vars={card.ability.extra.mult}}
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.joker_main then
			return {mult = card.ability.extra.mult}
		end
		if context.first_hand_drawn and not context.blueprint then
			local eval = function() return G.GAME.current_round.hands_played== 0 and notG.RESET_JIGGLES end
			juice_card_until(card,eval,true)
		end
		if context.before and context.main_eval and G.GAME.current_round.hands_played == 0 and #context.full_hand == 1 then
			context.full_hand[1]:start_dissolve({ HEX("ff4400") }, nil, 1.6)
			card.ability.extra.mult = card.ability.extra.mult + 5
			return { message = 'Melted!', colour = HEX("ff4400")}
		end
	end	
}

-- The Core

SMODS.Joker{
	key = "core",
	loc_txt = {
		name = 'The Core',
		text = {
			'Copies ability of a {C:ub_rainbow}random{} Joker',
			'every round'
		}
	},
	atlas = 'ph2',
	rarity = 'ub_mystery',
	pos = {x = 0, y = 0},
    cost = 8,
	config = { extra = {
		other_joker = nil
   	},
    },
	blueprint_compat = false,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {key='ph', set='Other'}
		if card.ability.extra.other_joker then
			info_queue[#info_queue+1] = G.P_CENTERS[card.ability.extra.other_joker]
			--info_queue[#info_queue+1] = {key='unsupported', set='Other'}
			--[[if card.ability.extra.other_joker:is_vanilla() then
				
			elseif table.contains(underbalatrojokers, card.ability.extra.center.key) then
				info_queue[#info_queue+1] = G.P_CENTERS['j_ub_'..card.ability.extra.other_joker.key]
			else
				info_queue[#info_queue+1] = {key='unsupported', set='Other'}
			end]]
		end
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.end_of_round and context.main_eval then
			card.ability.extra.other_joker = pseudorandom_element(UNDERBALATRO.mod.jokers, pseudoseed('core')).key
		end

		return UNDERBALATRO.mod.get_joker_return(card.ability.extra.other_joker,context,card,true)
	end	
}

-- New Home

SMODS.Joker{
	key = "newhome",
	loc_txt = {
		name = 'New Home',
		text = {
			'Will transform into a random',
			'{C:attention}Joker{} when boss blind',
			'started'
		}
	},
	atlas = 'ph2',
	rarity = 'ub_mystery',
    cost = 7,
	pos = {x = 0, y = 0},
	config = { extra = {
		Xmult = 1
   	},
    },
	blueprint_compat = false,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {key='ph', set='Other'}
		return {vars={card.ability.extra.Xmult}}
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.setting_blind and not context.blueprint and context.blind.boss then
			SMODS.add_card{key = pseudorandom_element(UNDERBALATRO.mod.jokers, pseudoseed('newhome')).key}
			card:start_dissolve()
		end
	end	
}

-- TEM VILLAGE! 

SMODS.Joker{
	key = "temvillage",
	loc_txt = {
		name = 'TEM VILLAGE!',
		text = {
			'hOI!!',
            'welcom to...',
            'TEM VILLAGE!',
            '{s:0.7}Pay {C:gold,s:0.7}$3{s:0.7} every round,',
            '{s:0.7}once paying {C:gold,s:0.7}$15{s:0.7},',
            '{s:0.7}obtain a random consumeable.',
            '{C:inactive,s:0.7}({C:attention,s:0.7}#1#{C:inactive,s:0.7}/15)'
		}
	},
	atlas = 'ph2',
	rarity = 'ub_mystery',
    cost = 2,
	pos = {x = 0, y = 0},
	config = { extra = {
		paid = 0
   	},
    },
	in_pool = function(self,args)
		return false
	end,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {key='ph', set='Other'}
        info_queue[#info_queue+1] = {key='unfinished', set='Other'}
		return {vars={card.ability.extra.paid}}
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.end_of_round and context.main_eval then
            if not context.blueprint then
                card.ability.extra.paid = card.ability.extra.paid + 2
                ease_dollars(-1)
                if card.ability.extra.paid >= 15 then
                    SMODS.add_card{key = pseudorandom_element(UNDERBALATRO.mod.consumeables,pseudoseed('temmies'))}
                end
            else
                if card.ability.extra.paid >= 15 then
                    SMODS.add_card{key = pseudorandom_element(UNDERBALATRO.mod.consumeables,pseudoseed('temmies'))}
                end
            end
        end
	end	
}

-- Noelle

SMODS.Atlas{
	key = 'noelle',
	path = 'noelle.png',
	px = 71,
	py = 95
}

SMODS.Joker{
	key = "noelle",
	loc_txt = {
		name = 'Noelle',
		text = {
			{
				'Cast {C:attention}ICESHOCK{} on the first',
				'scoring card',
				'{s:0.75,C:inactive}Iceshock = Frozen cards'
			},
			{
				'{C:mult}+5{} when she',
				'casts {C:attention}ICESHOCK{}',
				'{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)'
			}
			--[['{C:mult}+6{} mult for every {C:planet}Frozen',
            'card currently in the deck',
            '{C:inactive}(Currently {C:mult}+#1#{C:inactive} mult)']]
		}
	},
	atlas = 'noelle',
	rarity = 2,
    cost = 6,
	pos = {x = 0, y = 0},
	config = { extra = {
		mult = 0
   	},
    },
	--[[in_pool = function(self,args)
		for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_ub_snowy') then
                return true
            end
        end
        return false
	end,]]
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS['m_ub_snowy']
        --local frozens = 0
        --[[if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, 'm_ub_snowy') then frozens = frozens + 1 end
            end
        end]]
		return {vars={card.ability.extra.mult}}
    end,
	set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_prophecy'), HEX('8062d9'), G.C.WHITE, 0.8)
	end,
	calculate = function(self,card,context)
		if context.main_eval and context.before then
			G.E_MANAGER:add_event(Event({
					context.full_hand[1]:set_ability(G.P_CENTERS["m_ub_snowy"])
				}))
			card.ability.extra.mult = card.ability.extra.mult + 5
		end
		if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
	end	
}

-- Madjick

SMODS.Joker{
	key = "madjick",
	loc_txt = {
		name = 'Madjick',
		text = {
			'{C:chips}+15{} Chips per {C:}Spectral',
            'card used this run',
            '{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)'
		}
	},
	atlas = 'jatlas',
	rarity = 1,
    cost = 6,
	pos = {x = 4, y = 0},
	config = { extra = {
		
   	},
    },
	in_pool = function(self,args)
		return true
	end,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return {vars={15*(G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.spectral or 0)}}
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == "Spectral" then
            return {
                message = localize { type = 'variable', key = 'a_mult', vars = { G.GAME.consumeable_usage_total.tarot } },
            }
        end
        if context.joker_main then
            return {
                chips = 15 *
                    (G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.spectral or 0)
            }
        end
	end	
}

-- Spamton

SMODS.Atlas{
	key = 'spamton',
	path = 'spamton.png',
	px = 71,
	py = 95
}

SMODS.Joker{
	key = "spamton",
	loc_txt = {
		name = '[Spamton]',
		text = {
            {
			    'NOW\'S YOUR CHANCE TO BE A {C:attention}[[BIG SHOT!]]{}.',
                'DEAL OR NO DEAL. [Hyperlink Blocked].'
            },
            {
                'Selling this {C:attention}Joker{} costs {C:gold}$#1#{} and creates',
                'another {C:attention}Spamton{} with {X:mult,C:white}X#3#{} more mult',
                '{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)'
            }
		}
	},
	atlas = 'spamton',
	rarity = 2,
    cost = 8,
	pos = {x = 0, y = 0},
	config = { extra = {
		price = -1,
        Xmult = 1,
        Xmult_inc = 0.1
   	},
    },
	in_pool = function(self,args)
		return true
	end,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return {vars={card.ability.extra.price * -1,card.ability.extra.Xmult, card.ability.extra.Xmult_inc}}
    end,
	set_badges = function(self,card,badges)

	end,
    add_to_deck = function(self,card, from_debuff)
        
    end,
	calculate = function(self,card,context)
		if context.selling_self and not context.blueprint then
            local _card = SMODS.add_card({key = 'j_ub_spamton'})
            _card.ability.extra.price = card.ability.extra.price * 2
            _card:set_cost()
            _card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_inc
            _card.ability.extra.Xmult_inc = card.ability.extra.Xmult_inc * 2
            card:start_dissolve()
        end
        if context.joker_main then
            return {Xmult = card.ability.extra.Xmult}
        end
	end	
}

-- Tasque Manager

SMODS.Atlas{
	key = 'tasquemanager',
	path = 'tasquemanager.png',
	px = 71,
	py = 95
}

SMODS.Joker{
	key = "tasque_manager",
	loc_txt = {
		name = 'Tasque Manager',
		text = {
            'Retrigger scoring {C:attention}Aces'
		}
	},
	atlas = 'tasquemanager',
	rarity = 1,
    cost = 4,
	pos = {x = 0, y = 0},
	config = { extra = {

   	},
    },
	in_pool = function(self,args)
		return true
	end,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)

    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.repetition and context.other_card:get_id() == 14 then
            return {repetitions = 1}
        end
	end	
}

-- Toriel

SMODS.Joker{
	key = "toriel",
	loc_txt = {
		name = 'Toriel',
		text = {
            'Create a {C:attention}Butterscotch pie',
            'when {C:attention}Boss Blind{} is defeated',
            '{C:inactive}(Must have space)'
		}
	},
	atlas = 'ph2',
	rarity = 2,
    cost = 6,
	pos = {x = 0, y = 0},
	config = { extra = {

   	},
    },
	in_pool = function(self,args)
		return true
	end,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key='ph', set='Other'}
        info_queue[#info_queue+1] = G.P_CENTERS['c_ub_pie']
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.end_of_round and context.game_over == false and context.main_eval then
            if G.GAME.blind.boss and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card{key = 'c_ub_pie'}
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                }))
            end
        end
	end	
}

-- Lancer

SMODS.Atlas{
	key = 'lancer',
	path = 'lancer.png',
	px = 71,
	py = 95
}

SMODS.Joker{
	key = "lancer",
	loc_txt = {
		name = 'Lancer',
		text = {
            'Transform scoring {C:hearts}Hearts{} into',
            '{C:spades}Spades'
		}
	},
	atlas = 'lancer',
	rarity = 1,
    cost = 5,
	pos = {x = 0, y = 0},
	config = { extra = {

   	},
    },
	in_pool = function(self,args)
		return true
	end,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)

    end,
	set_badges = function(self,card,badges)
        badges[#badges+1] = create_badge(localize('k_prophecy'), HEX('8062d9'), G.C.WHITE, 0.8)
	end,
	calculate = function(self,card,context)
		if context.after then
            for _, i in ipairs(context.scoring_hand) do
                if i:is_suit('Hearts') then
                    SMODS.change_base(i, 'Spades')
                end
            end
        end
	end	
}

-- Annoying Dog

SMODS.Joker{
	key = "annoying",
	loc_txt = {
		name = 'Annoying Dog',
		text = {
            '{C:mult}+3{} Mult for every scored',
            'card',
            '{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)'
		}
	},
	atlas = 'ph2',
	rarity = 4,
    cost = 10,
	pos = {x = 0, y = 0},
	config = { extra = {
        mult = 0
   	},
    },
	in_pool = function(self,args)
		return true
	end,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key='ph', set='Other'}
        return {vars = {card.ability.extra.mult}}
    end,
	set_badges = function(self,card,badges)
        
	end,
	calculate = function(self,card,context)
		if context.individual and context.cardarea == G.play then
            card.ability.extra.mult = card.ability.extra.mult + 3
            return {
					message = localize('k_upgrade_ex'),
					colour = G.C.RED
				 }
        end
        if context.joker_main then
            return {mult = card.ability.extra.mult}
        end
	end	
}

-- Chara

SMODS.Atlas{
	key = 'chara',
	path = 'chara.png',
	px = 71,
	py = 95
}


SMODS.Joker{
	key = "chara",
	loc_txt = {
		name = 'Chara',
		text = {
            'Sell this card to {C:red,E:2}destroy{} Joker to',
            'the right.',
            'When doing so, create a {C:dark_edition}Negative{} Joker'
		}
	},
	atlas = 'chara',
	rarity = 2,
    cost = 6,
	pos = {x = 0, y = 0},
	config = { extra = {
        
   	},
    },
	in_pool = function(self,args)
		return true
	end,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS['e_negative']
        return {vars = {card.ability.extra.mult}}
    end,
	set_badges = function(self,card,badges)
        
	end,
	calculate = function(self,card,context)
		if context.selling_self then
            local other_joker = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					other_joker = G.jokers.cards[i+1]
				end
			end
            if other_joker and other_joker ~= self then
                other_joker:start_dissolve()
                SMODS.add_card{key = pseudorandom_element(UNDERBALATRO.mod.jokers, pseudoseed('chara')).key, edition = 'e_negative'}
            end
        end
	end	
}

-- Roaring Knight

SMODS.Joker{
	key = "knight",
	loc_txt = {
		name = 'The Roaring Knight',
		text = {
			'Create a {C:dark_edition}Negative{} playing',
            'card when {C:attention}Blind{} is selected'
		}
	},
	atlas = 'aatlas',
	cost = 7,
	rarity = 3,
    soul_pos = {x=0,y=0},
	pos = {x = 3, y = 0},
	config = { extra = {
		
   	},

    },
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)

    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.setting_blind then
			G.E_MANAGER:add_event(Event({
                func = function()
                    local _suit = pseudorandom_element({ 'S', 'H', 'D', 'C' }, pseudoseed('roaring'))
                    local _number = pseudorandom_element({'A','K','Q','J','10','9','8','7','6','5','4','3','2'}, pseudoseed('roaring'))
                    local _card = create_playing_card({ front = G.P_CARDS[_suit .. _number], center = G.P_CENTERS.c_base }, G.deck,
                        nil, nil, { G.C.SECONDARY_SET.Enhanced })
                    _card:set_edition('e_negative')
                    G.GAME.blind:debuff_card(_card)
                    G.hand:sort()
                    card:juice_up()
                    return true
                end
            }))

            playing_card_joker_effects({ true })
        end
	end	
}

-- Dummy

SMODS.Joker{
	key = "dummy",
	loc_txt = {
		name = 'Dummy',
		text = {
			'It\'s a dummy, what do',
            'you expect it to do?'
		}
	},
	atlas = 'jatlas',
	cost = 1,
	rarity = 1,
	pos = {x = 3, y = 0},
	config = { extra = {
		
   	},
    },
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.joker_main then
            return {
                message = 'Nothing!',
                colour = G.C.attention
            }
        end
	end	
}

-- nubert

SMODS.Joker{
	key = "nubert",
	loc_txt = {
		name = 'nubert',
		text = {
			'nubert',
            '{s:0.5}nubert',
            '{s:0.3,C:inactive}now seriously, i should stop with this'
		}
	},
	atlas = 'jatlas',
	cost = 99999999999999,
	rarity = 4,
    soul_pos = {x=1,y=0},
	pos = {x = 0, y = 0},
	config = { extra = {
		destr = false
   	},
    },
	blueprint_compat = true,
    in_pool = function(self,args)
        return true
    end,
	loc_vars = function(self, info_queue, card)
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.joker_main then
            card.ability.extra.destr = true
            return {
                Xmult = 10000000
            }
        end
        if context.setting_blind and card.ability.extra.destr == true then
            card:start_dissolve()
            local chance = math.random(1,2)
            if chance == 1 then
                return {
                    message = 'He was way too strong for you',
                    colour = G.C.attention
                }
            elseif chance == 2 then
                return {
                    message = 'Nubert does not hang with noobs',
                    colour = G.C.attention
                }
            end
        end
	end	
}

-- Seam

SMODS.Joker{
	key = "seam",
	loc_txt = {
		name = 'Seam',
		text = {
			'Sell to obtain a random',
            '{C:black}ITEM'
		}
	},
	atlas = 'ph2',
	cost = 3,
	rarity = 2,
	pos = {x = 0, y = 0},
	config = { extra = {
        
   	},
    },
	blueprint_compat = true,
    in_pool = function(self,args)
        return true
    end,
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key='ph', set='Other'}
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.selling_self and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card {
                                set = 'items',
                                key_append = 'ub_seam' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = '+1 ITEM', colour = G.C.BLACK },
                        context.blueprint_card or card)
                    return true
                end)
            }))
            return nil, true -- This is for Joker retrigger purposes
        end
	end	
}

-- Jevil

SMODS.Joker{
	key = "jevil",
	loc_txt = {
		name = 'Jevil',
		text = {
            {
                'CHAOS, CHAOS!',
                'Start a new {C:attention}CHAOS{} every round',
                '{C:dark_edition}+3{} Joker slots'
            },
            {
                'Current {C:attention}CHAOS:',
                '#1#'
            }
		}
	},
	atlas = 'jatlas',
	cost = 7,
	rarity = 2,
	pos = {x = 5, y = 0},
	config = { extra = {
        chaos = 'What! It\'s nothing but a useless bird!',
        chaos_l = 7,
        chaoses = {
            '-1 discard', --1
            '-1 hand',
            '-$5',
            'X2 blind requirement', --4
            'X0.5 mult',
            'X0.5 chips',
            'What! It\'s nothing but a useless bird!', --7
            '+500 chips',
            '-1 hand size',
            '+50 mult', --10
            'Random mult',
            'Random chips'
        }
   	},
    },
	blueprint_compat = true,
    in_pool = function(self,args)
        return true
    end,
	loc_vars = function(self, info_queue, card)
        return {vars={card.ability.extra.chaos}}
    end,
	set_badges = function(self,card,badges)

	end,
    add_to_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit + 3
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.jokers.config.card_limit = G.jokers.config.card_limit - 3
    end,
	calculate = function(self,card,context)
		if context.end_of_round and context.main_eval then
            if card.ability.extra.chaos_l == 1 then
				G.E_MANAGER:add_event(Event({
					func = function()
						ease_discard(1,nil)
						return true
					end
				}))
            elseif card.ability.extra.chaos_l == 2 then
				G.E_MANAGER:add_event(Event({
					func = function()
						ease_hands_played(1,nil)
						return true
					end
				}))
            elseif card.ability.extra.chaos_l == 9 then
                G.E_MANAGER:add_event(Event({
					func = function()
						G.hand:change_size(1,nil)
						return true
					end
				}))
            end
            card.ability.extra.chaos_l = math.random(1,#card.ability.extra.chaoses)
            card.ability.extra.chaos = card.ability.extra.chaoses[card.ability.extra.chaos_l]
            
            if card.ability.extra.chaos_l == 3 then
                ease_dollars(-5)
            end
        end
        if context.setting_blind then
            if card.ability.extra.chaos_l == 4 then
                G.GAME.blind.chips = G.GAME.blind.chips * 2
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            elseif card.ability.extra.chaos_l == 1 then
                return {
					func = function()
						G.E_MANAGER:add_event(Event({
							func = function()
								ease_discard(-1)
								return true
							end
						}))
					end
				}
            elseif card.ability.extra.chaos_l == 2 then
                return {
					func = function()
						G.E_MANAGER:add_event(Event({
							func = function()
								ease_hands_played(-1)
								return true
							end
						}))
					end
				}
            elseif card.ability.extra.chaos_l == 9 then
                return {
					func = function()
						G.E_MANAGER:add_event(Event({
							func = function()
								G.hand:change_size(-1)
								return true
							end
						}))
					end
				}
            end
        end
        if context.joker_main then
            if card.ability.extra.chaos_l == 5 then
                return {xmult = 0.5}
            elseif card.ability.extra.chaos_l == 6 then
                return {xchips = 0.5}
            elseif card.ability.extra.chaos_l == 8 then
                return {chips = 500}
            elseif card.ability.extra.chaos_l == 10 then
                return {mult = 50}
            elseif card.ability.extra.chaos_l == 11 then
                return {mult = math.random(-5,100)}
            elseif card.ability.extra.chaos_l == 12 then
                return {chips = math.random(-50,1000)}
            end
        end
	end	
}

-- pipis

SMODS.Joker{
	key = "pipis",
	loc_txt = {
		name = 'Pipis',
		text = {
			{
				'{C:chips}-50{} Chips'
			},
			{
				'Explodes after {C:attention}3{} rounds',
                'loosing {C:gold}$1{} on explosion',
				'{C:inactive}(Currently {C:attention}#1#{C:inactive}/3)'
			}
		}
	},
	atlas = 'jatlas',
	rarity = 'ub_pipis',
	pos = {x = 0, y = 1},
	config = { extra = {
		handss = 0
   	},
    },
	in_pool = function(self,args)
		return false
	end,
	blueprint_compat = false,
	loc_vars = function(self, info_queue, card)
		return {vars={card.ability.extra.handss}}
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.end_of_round and context.main_eval then
			card.ability.extra.handss = card.ability.extra.handss + 1
			if card.ability.extra.handss == 3 then
				card:start_dissolve({ HEX("584896") }, nil, 1.6)
                ease_dollars(-1)
			end
		end
		if context.joker_main then
			return {chips = -50}
		end
	end	
}

-- Mad Dummy

SMODS.Joker{
	key = "mdummy",
	loc_txt = {
		name = 'Mad Dummy',
		text = {
			'{C:mult}+3{} Mult when destroyed',
            '{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)',
			'{s:0.75,C:inactive}Foolish. Foolish! FOOLISH!'
		}
	},
	atlas = 'jatlas',
	cost = 6,
	rarity = 1,
	pos = {x = 3, y = 0},
	config = { extra = {
		mult = 0
   	},
    },
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		return {vars={card.ability.extra.mult}}
    end,
	set_badges = function(self,card,badges)

	end,
	add_to_deck = function(self,card, from_debuff)
		if from_debuff == false then 
			card:set_sell_value()
		end
	end,
	calculate = function(self,card,context)
		if context.joker_type_destroyed and context.card == card and not context.blueprint then
			local _card = SMODS.add_card({key = 'j_ub_mdummy'})
			_card.ability.extra.mult = card.ability.extra.mult + 3

		end
		if context.joker_main then
            return {mult = card.ability.extra.mult}
        end
	end,
	eternal_compat = false
}

-- Flowery

SMODS.Joker{
	key = "flowery",
	loc_txt = {
		name = 'Flowery',
		text = {
			'Create a {C:ub_rainbow}random{} flower',
			'item every {C:attention}Ante'
		}
	},
	atlas = 'jatlas',
	cost = 7,
	rarity = 2,
	pos = {x = 2, y = 0},
	config = { extra = {

   	},
    },
	blueprint_compat = false,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {key='ph', set='Other'}
		return {vars={}}
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and G.GAME.blind.boss then
			G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            G.E_MANAGER:add_event(Event({
                func = (function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card{key = pseudorandom_element(UNDERBALATRO.mod.flower_items, pseudoseed("flowery"))}
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    SMODS.calculate_effect({ message = '+1 FLOWER ITEM', colour = G.C.PURPLE },
                        context.blueprint_card or card)
                    return true
                end)
            }))
            return nil, true -- This is for Joker retrigger purposes
		end
	end,
}

-- Jackenstein

SMODS.Joker{
	key = "jackenstein",
	loc_txt = {
		name = 'Jackenstein',
		text = {
				'{X:mult,C:white}X#1#{} Mult',
				'{X:mult,C:white}-X0.1{} Mult every hand',
				'Resets every blind',
				'{s:0.75,C:inactive}YOUR TAKING TOO LONG'
		}
	},
	atlas = 'jatlas',
	rarity = 2,
	pos = {x = 2, y = 0},
	config = { extra = {
		xmult = 1.3
   	},
    },
	in_pool = function(self,args)
		return false
	end,
	blueprint_compat = false,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {key='ph', set='Other'}
		return {vars={card.ability.extra.xmult}}
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.setting_blind then
			card.ability.extra.xmult = 1+(G.GAME.current_round.hands_left/10)
		end
		if context.joker_main then
			local multi = card.ability.extra.xmult
			card.ability.extra.xmult = card.ability.extra.xmult - 0.1
			return {xmult = multi}
		end
	end	
}

-- Jackenstein

SMODS.Joker{
	key = "jackenstein",
	loc_txt = {
		name = 'Jackenstein',
		text = {
				'{X:mult,C:white}X#1#{} Mult',
				'{X:mult,C:white}-X0.1{} Mult every hand',
				'Resets every blind',
				'{s:0.75,C:inactive}YOUR TAKING TOO LONG'
		}
	},
	atlas = 'jatlas',
	rarity = 2,
	pos = {x = 2, y = 0},
	config = { extra = {
		xmult = 1.3
   	},
    },
	in_pool = function(self,args)
		return false
	end,
	blueprint_compat = false,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue+1] = {key='ph', set='Other'}
		return {vars={card.ability.extra.xmult}}
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.setting_blind then
			card.ability.extra.xmult = 1+(G.GAME.hands/10)
		end
		if context.press_play then
			card.ability.extra.xmult = card.ability.extra.xmult - 0.1
		end
		if context.joker_main then
			return {xmult = card.ability.extra.xmult}
		end
	end	
}

--[[if context.ub_destroyedcard == "j_ub_monster" then
			card.ability.extra.mult = card.ability.extra.mult + 6
				return { 
					message = localize('k_upgrade_ex'), 
					colour = G.C.RED
				 }
		end
		if context.joker_main then
			return {mult = card.ability.extra.mult}
		end
--]]

-- OLD FLOWERY

--[[
can_use = function(self,card)
		return true
	end,
	use = function(self,card,area)
		if card.ability.extra.flower == "Aqua" then
			card.ability.extra.flower = "Green"
			card.ability.extra.abil = "When blind is selected, add 10% of the total score"
		elseif card.ability.extra.flower == "Green" then
			card.ability.extra.flower = "Orange"
			card.ability.extra.abil = "+10 Mult"
		elseif card.ability.extra.flower == "Orange" then
			card.ability.extra.flower = "Seth"
			card.ability.extra.abil = "Copy the ability of the joker to the left"
		elseif card.ability.extra.flower == "Seth" then
			card.ability.extra.flower = "Yellow"
			card.ability.extra.abil = "If there is a scoring Ace, +100 Chips"
		elseif card.ability.extra.flower == "Yellow" then
			card.ability.extra.flower = "Blue"
			card.ability.extra.abil = "1 in 3 chance to give Echo flower seal to the first scoring card"
		elseif card.ability.extra.flower == "Blue" then
			card.ability.extra.flower = "Aqua"
			card.ability.extra.abil = "First hand played gives +200 Chips"
		end
	end,
	if context.setting_blind then
			if card.ability.extra.flower == "Green" then 
				local e = G.GAME.blind.chips * 0.1
				G.GAME.chips = G.GAME.chips + e
				return {
					message = "+"..e.."!",
					colour = HEX("562abd")
				}
			end
		end
		if context.joker_main then
			if card.ability.extra.flower == "Orange" then
				return {mult = 10}
			elseif card.ability.extra.flower == "Yellow" then
				local truth = false
				for _, i in ipairs(context.full_hand) do
					local id = i:get_id()
					if id == 14 then
						truth = true
					end
				end
				if truth == true then return {chips = 100} end
			elseif card.ability.extra.flower == "Aqua" then
				if G.GAME.current_round.hands_played == 0 then
					return {chips = 200}
				end
			end
		end
		if card.ability.extra.flower == "Seth" then
			local other_joker = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then other_joker = G.jokers.cards[i-1] end
			end
			local ret = SMODS.blueprint_effect(card, other_joker, context)
			if ret then
				ret.colour = G.C.BLUE
			end
			return ret
		end
		if context.individual and context.cardarea == G.play then
			if card.ability.extra.flower == "Blue" and pseudorandom("blue") < G.GAME.probabilities.normal/3 then
				local area = context.scoring_hand
				if area[1] then
					G.E_MANAGER:add_event(Event({
						func = function()
							area[1]:set_seal('ub_echo_flower')
							return true
						end
					}))	
				end
			end
		end	
	]]
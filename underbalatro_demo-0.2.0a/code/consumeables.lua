-- Items

SMODS.ConsumableType{
	key = "items",
	primary_colour = G.C.BLACK,
	secondary_colour = G.C.BLACK,
	loc_txt = {
		name = "ITEM",
		collection = "ITEM",
	},
	shop_rate = 2
}

-- Bullet

SMODS.Atlas{
	key = 'bullet',
	path = 'bullet.png',
	px = 71,
	py = 95
}

SMODS.Consumable{
	key = "bullet",
	set = "items",
	loc_txt = {
		name = 'Bullet',
		text = {
			'Destroy {C:attention}1{} selected',
			'card'
		}
	},
	atlas = 'bullet',
	cost = 2,
	pos = {x = 0, y = 0},
	can_use = function(self,card)
		return #G.hand.highlighted == 1
	end,
	in_pool = function(self,args)
		return true
	end,
	loc_vars = function(self,info_queue,center)

	end,
	use = function(self,card,area,copier)
		G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                SMODS.destroy_cards(G.hand.highlighted)
                return true
            end
        }))
        delay(0.3)
	end
}

-- Snowman Piece

SMODS.Atlas{
	key = 'spiece',
	path = 'spiece.png',
	px = 71,
	py = 95
}

SMODS.Consumable{
	key = "spiece",
	set = "items",
	loc_txt = {
		name = 'Snowman Piece',
		text = {
			'Gains {C:money}$1{} of',
			'{C:attention}sell value{} at',
			'end of round'
		}
	},
	atlas = 'spiece',
	cost = 2,
	pos = {x = 0, y = 0},
	config = {extra = {price = 1}},
	can_use = function(self,card)
		return false
	end,
	in_pool = function(self,args)
		return true
	end,
	loc_vars = function(self,info_queue,center)

	end,
	calculate = function(self,card,context)
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			card.ability.extra_value = card.ability.extra_value + card.ability.extra.price
			card:set_cost()
			return {
				message = localize('k_val_up'),
				colour = G.C.MONEY,
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        play_sound('tarot1')
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
			}
		end
	end,
}

-- Last Dream

SMODS.Atlas{
	key = 'lastdream',
	path = 'lastdream.png',
	px = 71,
	py = 95
}

SMODS.Consumable{
	key = "lastdream",
	set = "items",
	loc_txt = {
		name = '{C:ub_rainbow}Last Dream{}',
		text = {
			'{C:ub_rainbow}The dream became true{}'
		}
	},
	atlas = 'lastdream',
	cost = 4,
	pos = {x = 0, y = 0},
	config = {extra = {price = 1}},
	can_use = function(self,card)
		return #G.hand.highlighted == 1
	end,
	in_pool = function(self,args)
		return true
	end,
	loc_vars = function(self,info_queue,center)

	end,
	use = function(self,card,area,copier)
		G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.hand.highlighted[i]:set_ability(G.P_CENTERS['m_ub_dreams'])
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
	end,
}

-- Capsule
--[[
SMODS.Atlas{
	key = 'capsule',
	path = 'capsule.png',
	px = 71,
	py = 95
}
--]]
SMODS.Consumable{
	key = "capsule",
	set = "items",
	loc_txt = {
		name = 'Capsule',
		text = {
			'Store a {C:attention}Joker{}.',
			'Sell, to recover him',
			'{C:inactive}(Must have room){}'
		}
	},
	atlas = 'ph',
	cost = 7,
	pos = {x = 0, y = 0},
	config = {extra = {
		joker_saved = ''
	}
	},
	can_use = function(self,card)
		return #G.jokers.highlighted == 1
	end,
	in_pool = function(self,args)
		return true
	end,
	loc_vars = function(self,info_queue,card)
		info_queue[#info_queue+1] = G.P_CENTERS[card.ability.extra.joker_saved]
	end,
	calculate = function(self, card, context)
		if context.selling_self then
			if card.ability.extra.joker_saved ~= '' then
    			SMODS.add_card({key = card.ability.extra.joker_saved})
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        play_sound('tarot1')
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
			end
		end
	end,
	keep_on_use = function(self,card)
		return true
	end,
	use = function(self,card,area,copier)
		if card.ability.extra.joker_saved == '' then
			card.ability.extra.joker_saved = G.jokers.highlighted[1].config.center.key
			G.E_MANAGER:add_event(Event({
				G.jokers.highlighted[1]:start_dissolve(),
			}))	
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
		end
	end,
}

-- Failed Experiment

SMODS.Consumable{
	key = "failed",
	set = "items",
	loc_txt = {
		name = 'Failed Experiment',
		text = {
			'{C:green}#1# in 7{} chance to give',
			'{C:dark_edition}negative{} to a {C:attention}Joker',
		}
	},
	atlas = 'ph',
	cost = 7,
	pos = {x = 0, y = 0},
	config = {extra = {
		joker_saved = ''
	}
	},
	can_use = function(self,card)
		return next(SMODS.Edition:get_edition_cards(G.jokers,true))
	end,
	in_pool = function(self,args)
		return false
	end,
	loc_vars = function(self,info_queue,card)
		info_queue[#info_queue+1] = G.P_CENTERS[card.ability.extra.joker_saved]
        return {vars={(G.GAME and G.GAME.probabilities.normal or 1)}}
	end,
	calculate = function(self, card, context)
		if context.selling_self then
			if card.ability.extra.joker_saved ~= '' then
    			SMODS.add_card({key = card.ability.extra.joker_saved})
			end
		end
	end,
	use = function(self,card,area,copier)
		if pseudorandom('failed') < G.GAME.probabilities.normal/7 then
			local editionless_jokers = SMODS.Edition:get_edition_cards(G.jokers,true)
			G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.4,
				func = function()
					local eligible_card = pseudorandom_element(editionless_jokers,pseudoseed('failed'))
					eligible_card:set_edition({ negative = true })

					card:juice_up(0.3,0.5)
					return true
				end
			}))
		end
	end,
}

-- Butterscotch Pie

SMODS.Consumable{
	key = "pie",
	set = "items",
	loc_txt = {
		name = 'Butterscotch Pie',
		text = {
			'Instantly obtain {C:purple}80%{}',
            'of the Total Score.'
		}
	},
	atlas = 'ph',
	cost = 15,
	pos = {x = 0, y = 0},
	config = {extra = {
		
	}
	},
	can_use = function(self,card)
		return G.GAME.blind.in_blind
	end,
	in_pool = function(self,args)
		return false
	end,
	loc_vars = function(self,info_queue,card)

	end,
	calculate = function(self, card, context)
		
	end,
	use = function(self,card,area,copier)
		local perc = G.GAME.blind.chips * 0.8
        G.GAME.chips = G.GAME.chips + perc
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
		return {
				message = "+"..perc.." Score!",
				colour = G.C.PURPLE
			}
	end,
}

-- Instant Noodles

SMODS.Consumable{
	key = "noodles",
	set = "items",
	loc_txt = {
		name = 'Instant Noodles',
		text = {
			'Instantly obtain {C:purple}25%{}',
            'of the Total Score',
			'Obtain {C:purple}50%{} during Boss blind',
		}
	},
	atlas = 'ph',
	cost = 6,
	pos = {x = 0, y = 0},
	config = {extra = {
		
	}
	},
	can_use = function(self,card)
		return G.GAME.blind.in_blind
	end,
	loc_vars = function(self,info_queue,card)

	end,
	calculate = function(self, card, context)
		
	end,
	use = function(self,card,area,copier)
        local perc = 0
		if G.GAME.blind.boss then
            perc = G.GAME.blind.chips * 0.25
            G.GAME.chips = G.GAME.chips + perc
        else
            perc = G.GAME.blind.chips * 0.5
            G.GAME.chips = G.GAME.chips + perc
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

		return {
				message = "+"..perc.." Score!",
				colour = G.C.PURPLE
			}
	end,
}

-- Cell Phone

SMODS.Consumable{
	key = "cell",
	set = "items",
	loc_txt = {
		name = 'Cell Phone',
		text = {
			'Call in a random {C:attention}Tarot{} Card'
		}
	},
	atlas = 'ph',
	cost = 4,
	pos = {x = 0, y = 0},
	config = {extra = {
		
	}
	},
	can_use = function(self,card)
		return true
	end,
	loc_vars = function(self,info_queue,card)

	end,
	calculate = function(self, card, context)
		
	end,
	use = function(self,card,area,copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('timpani')
                    SMODS.add_card({ set = 'Tarot' })
                    card:juice_up(0.3, 0.5)
                end
                return true
            end
        }))
        delay(0.6)
	end,
}

-- Glowshard

SMODS.Consumable{
	key = "glowshard",
	set = "items",
	loc_txt = {
		name = 'Glowshard',
		text = {
			'Increases {C:attention}sell value',
            'by {C:money}$10{} every',
            '{C:attention}Ante'
		}
	},
	atlas = 'newph',
	cost = 4,
	pos = {x = 0, y = 0},
	config = {extra = {
		
	}
	},
	can_use = function(self,card)
		return false
	end,
	loc_vars = function(self,info_queue,card)

	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and G.GAME.blind.boss then
			card.ability.extra_value = card.ability.extra_value + 10
			card:set_cost()
			return {
				message = localize('k_val_up'),
				colour = G.C.MONEY,
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        play_sound('tarot1')
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
			}
		end
	end,
}

-- Jevilstail

SMODS.Consumable{
	key = "jevilstail",
	set = "items",
	loc_txt = {
		name = 'Jevilstail',
		text = {
			'Enhances {C:attention}1{} random',
            'card in your hand',
            'into {C:attention}Wild Card'
		}
	},
	atlas = 'newph',
	cost = 2,
	pos = {x = 0, y = 0},
	config = {extra = {
		
	}
	},
	can_use = function(self,card)
        if #G.hand.cards > 0 then
		    return true
        end
        return false
	end,
	loc_vars = function(self,info_queue,card)
        info_queue[#info_queue+1] = G.P_CENTERS['m_wild']
	end,
	use = function(self,card,area,copier)
        local selected_place = math.random(1,#G.hand.cards)
        local first_splace = selected_place
        local selected = G.hand.cards[selected_place]
        while SMODS.has_enhancement(selected,'m_wild') do
            selected_place = selected_place + 1
            if selected_place > #G.hand.cards then
                selected_place = 1
            end
            selected = G.hand.cards[selected_place]
            if first_splace == selected_place then
                selected = nil
                break
            end
        end
        if selected then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
            for i = 1, #G.hand.highlighted do
                local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('card1', percent)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            delay(0.2)
            for i = 1, #G.hand.highlighted do
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.1,
                    func = function()
                        G.hand.highlighted[i]:set_ability(G.P_CENTERS['m_wild'])
                        return true
                    end
                }))
            end
            for i = 1, #G.hand.highlighted do
                local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.15,
                    func = function()
                        G.hand.highlighted[i]:flip()
                        play_sound('tarot2', percent, 0.6)
                        G.hand.highlighted[i]:juice_up(0.3, 0.3)
                        return true
                    end
                }))
            end
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.2,
                func = function()
                    G.hand:unhighlight_all()
                    return true
                end
            }))
            delay(0.5)
        end
    end
}

-- Dealmaker

SMODS.Consumable{
	key = "dealmaker",
	set = "items",
	loc_txt = {
		name = 'Dealmaker',
		text = {
			'Gives {C:gold}[$#1#]{}.',
            'Value randomizes',
            'between {C:gold}[$#2#]{} and',
            '{C:gold}[$#3#]{} every hand'
		}
	},
	atlas = 'newph',
	cost = 4,
	pos = {x = 0, y = 0},
	config = {extra = {
		kromer = 0
	}
	},
	can_use = function(self,card)
        if #G.hand.cards > 0 then
		    return true
        end
        return false
	end,
	loc_vars = function(self,info_queue,card)
        return {vars={card.ability.extra.kromer,card.ability.extra.kromer-5,card.ability.extra.kromer+10}}
	end,
    calculate = function(self,card,context)
        if context.press_play then
            card.ability.extra.kromer = math.random(card.ability.extra.kromer-5,card.ability.extra.kromer+10)
            return {
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        play_sound('tarot1')
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                })),
                message = 'DELICIOUS KROMER',
                colour = G.C.GOLD
            }
        end
    end,
	use = function(self,card,area,copier)
        ease_dollars(card.ability.extra.kromer)
    end
}

-- Blackshard

SMODS.Consumable{
	key = "blackshard",
	set = "items",
	loc_txt = {
		name = 'Blackshard',
		text = {
			'{C:green}#1# in 3{} chance to',
            'give {C:dark_edition}Negative{} to',
            '{C:attention}1{} selected card'
		}
	},
	atlas = 'newph',
	cost = 5,
	pos = {x = 0, y = 0},
	config = {extra = {
		
	}
	},
	can_use = function(self,card)
        return #G.hand.highlighted == 1
	end,
	loc_vars = function(self,info_queue,card)
        info_queue[#info_queue+1] = G.P_CENTERS['e_negative']
        return {vars={(G.GAME and G.GAME.probabilities.normal or 1)}}
	end,
	use = function(self,card,area,copier)
        if pseudorandom('blackshard') < G.GAME.probabilities.normal/3 then
            G.hand.highlighted[1]:set_edition({ negative = true })
            return {
                message = 'Success!',
                colour = G.C.attention,
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        play_sound('tarot1')
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
            }
        end
        return {
            message = 'Fail',
            colour = G.C.attention,
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        }
    end
}

-- Justiceaxe

SMODS.Consumable{
	key = "justiceaxe",
	set = "items",
	loc_txt = {
		name = 'Justiceaxe',
		text = {
            'Enhance {C:attention}1{} selected',
            'card from your hand',
            '{C:inactive,s:0.6}In order to attain this ITEM, you became much stronger'
		}
	},
	atlas = 'newph',
	cost = 3,
	pos = {x = 0, y = 0},
	config = {extra = {
		
	}
	},
	can_use = function(self,card)
        return #G.hand.highlighted == 1
	end,
	loc_vars = function(self,info_queue,card)

	end,
	use = function(self,card,area,copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.hand.highlighted[1]:set_ability(SMODS.poll_enhancement({guaranteed = true,type_key = 'justiceaxe'}))
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end
}

-- AquaKnife

SMODS.Atlas{
	key = 'ak',
	path = 'aquaknife.png',
	px = 77,
	py = 101
}

SMODS.Consumable{
	key = "aquaknife",
	set = "items",
	loc_txt = {
		name = 'Aqua Knife',
		text = {
			'{C:green}#1# in 4{} chance for',
			'{X:purple,C:white}X1.5{} Score'
		}
	},
	atlas = 'ak',
	cost = 5,
	pos = {x = 0, y = 0},
	config = {extra = {
		
	}
	},
	can_use = function(self,card)
        return G.GAME.blind.in_blind
	end,
	in_pool = function(self,args)
		return false
	end,
	loc_vars = function(self,info_queue,card)
        return {vars={(G.GAME and G.GAME.probabilities.normal or 1)}}
	end,
	use = function(self,card,area,copier)
        if pseudorandom('aqua') < G.GAME.probabilities.normal/4 then
            G.GAME.chips = G.GAME.chips * 1.5
			return {
                message = 'Success!',
                colour = G.C.attention,
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        play_sound('tarot1')
                        card:juice_up(0.3, 0.5)
                        return true
                    end
                }))
            }
        end
        return {
            message = 'Fail',
            colour = G.C.attention,
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    play_sound('tarot1')
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        }
    end
}

-- SethSpecs

SMODS.Consumable{
	key = "sethspecs",
	set = "items",
	loc_txt = {
		name = 'Seth Specs',
		text = {
			'{C:purple}+10%{} Total Score'
		}
	},
	atlas = 'newph',
	cost = 3,
	pos = {x = 0, y = 0},
	config = {extra = {
		
	}
	},
	in_pool = function(self,args)
		return false
	end,
	can_use = function(self,card)
        return G.GAME.blind.in_blind
	end,
	loc_vars = function(self,info_queue,card)
        return {vars={}}
	end,
	use = function(self,card,area,copier)
		local perc = G.GAME.blind.chips * .1
        G.GAME.chips = G.GAME.chips + perc
		return {
				message = "+"..perc.." Score!",
				colour = G.C.PURPLE
			}
    end
}

-- BlueShoes

SMODS.Consumable{
	key = "blueshoes",
	set = "items",
	loc_txt = {
		name = 'Blue Shoes',
		text = {
			'{C:blue}+1{} hand'
		}
	},
	atlas = 'newph',
	cost = 7,
	pos = {x = 0, y = 0},
	config = {extra = {
		
	}
	},
	in_pool = function(self,args)
		return false
	end,
	can_use = function(self,card)
        return G.GAME.blind.in_blind
	end,
	loc_vars = function(self,info_queue,card)
        return {vars={}}
	end,
	use = function(self,card,area,copier)
		ease_hands_played(1)
    end
}

-- YellowHat

SMODS.Consumable{
	key = "yellowhat",
	set = "items",
	loc_txt = {
		name = 'Yellow Hat',
		text = {
			'{C:blue}+1{} hand',
			'{C:inactive}temporal ability'
		}
	},
	atlas = 'newph',
	cost = 7,
	pos = {x = 0, y = 0},
	config = {extra = {
		
	}
	},
	in_pool = function(self,args)
		return false
	end,
	can_use = function(self,card)
        return G.GAME.blind.in_blind
	end,
	loc_vars = function(self,info_queue,card)
        return {vars={(G.GAME and G.GAME.probabilities.normal or 1)}}
	end,
	use = function(self,card,area,copier)
		ease_hands_played(1)
    end
}

-- o.glove

SMODS.Consumable{
	key = "oglove",
	set = "items",
	loc_txt = {
		name = 'O. Glove',
		text = {
			'{C:red}+1{} discard'
		}
	},
	atlas = 'newph',
	cost = 6,
	pos = {x = 0, y = 0},
	config = {extra = {
		
	}
	},
	in_pool = function(self,args)
		return false
	end,
	can_use = function(self,card)
        return G.GAME.blind.in_blind
	end,
	loc_vars = function(self,info_queue,card)
        return {vars={}}
	end,
	use = function(self,card,area,copier)
		ease_discard(1)
    end
}


-- GreenApron

SMODS.Consumable{
	key = "greenapron",
	set = "items",
	loc_txt = {
		name = 'Green Apron',
		text = {
			'Gives {C:attention}1{} selected card',
			'the {C:attention}Defend{} Seal'
		}
	},
	atlas = 'newph',
	cost = 6,
	pos = {x = 0, y = 0},
	config = {extra = {
		
	}
	},
	can_use = function(self,card)
        return #G.hand.highlighted == 1
	end,
	in_pool = function(self,args)
		return false
	end,
	loc_vars = function(self,info_queue,card)
		info_queue[#info_queue+1] = G.P_CENTERS['ub_defend']
        return {vars={}}
	end,
	use = function(self,card,area,copier)
		G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for i = 1, #G.hand.highlighted do
            local percent = 1.15 - (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('card1', percent)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        delay(0.2)
        for i = 1, #G.hand.highlighted do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    G.hand.highlighted[i]:set_seal('ub_defend')
                    return true
                end
            }))
        end
        for i = 1, #G.hand.highlighted do
            local percent = 0.85 + (i - 0.999) / (#G.hand.highlighted - 0.998) * 0.3
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.15,
                func = function()
                    G.hand.highlighted[i]:flip()
                    play_sound('tarot2', percent, 0.6)
                    G.hand.highlighted[i]:juice_up(0.3, 0.3)
                    return true
                end
            }))
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
        delay(0.5)
    end
}
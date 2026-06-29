--Dark rarity
--[[
SMODS.Rarity{
    key = "dark",
    loc_txt = {
        name = "Darkner"
    },
    badge_colour = "282730",
}

-- Dark Joker

SMODS.Joker{
	key = "djoker",
	loc_txt = {
		name = 'Darkner Jimbo',
		text = {
			'{C:mult}+10{} mult'
		}
	},
	atlas = 'ph2',
	pos = {x = 0, y = 0},
	config = { extra = {

   	}
    },
    in_pool = function(self,args)
        return false
    end,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key='ph', set='Other'}
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.joker_main then
            return {mult = 10}
        end
	end	
}

-- Dark Suit Joker

SMODS.Joker{
	key = "dsuitjoker",
	loc_txt = {
		name = 'Darkner Suitful Jimbo',
		text = {
			'Played cards with',
            '{C:#2#}#1#{} suit give',
            '{C:mult}+10{} mult when scored'
		}
	},
	atlas = 'ph2',
    rarity = "dark",
	pos = {x = 0, y = 0},
	config = { extra = {
        suit = "Diamond",
        color = "diamond"
   	}
    },
    in_pool = function(self,args)
        return false
    end,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key='ph', set='Other'}
		return { vars = {card.ability.extra.suit, card.ability.extra.color} }
    end,
	set_badges = function(self,card,badges)

	end,
	calculate = function(self,card,context)
		if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit) then
            return { mult = 10 }
        end
        if context.end_of_round and context.main_eval then
            if card.ability.extra.suit == "Diamond" then
                card.ability.extra.suit = "Heart"
                card.ability.extra.color = "heart"
            elseif card.ability.extra.suit == "Heart" then
                card.ability.extra.suit = "Spade"
                card.ability.extra.color = "spade"
            elseif card.ability.extra.suit == "Spade" then
                card.ability.extra.suit = "Club"
                card.ability.extra.color = "club"
            else
                card.ability.extra.suit = "Diamond"
                card.ability.extra.color = "diamond"
            end
        end
	end	
}
--]]
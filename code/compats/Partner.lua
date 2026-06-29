SMODS.Atlas{
	key = 'underpartners',
	path = 'underpartners.png',
	px = 46,
	py = 58
}

if Partner_API then


    Partner_API.Partner {
        
        key = "rsoul",
        loc_txt = {
            name = 'Red Soul',
            text = {
                'Start blind with {C:attention}#1#%',
                'of the requirement'
            }
        },
        atlas = "underpartners",
        unlocked = true,
        discovered = true,
        pos = {x = 1, y = 0},
        config = {extra = {
            related_card = "j_ub_det"
        }
        },
        loc_vars = function(self, info_queue, card)
            local link_level = self:get_link_level()
            local benefits = 1
            if link_level == 1 then benefits = 1.5 end
            return { vars = {20*benefits} }
        end,
        calculate = function(self, card, context)
            if context.setting_blind then
                local link_level = self:get_link_level()
                local benefits = 1
                if link_level == 1 then benefits = 1.5 end
                local perc = G.GAME.blind.chips * 0.2 * benefits
                G.GAME.chips = perc
            end
        end,
        check_for_unlock = function(self,args)
            for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
                if v.key == 'j_ub_det' then
                    if get_joker_win_sticker(v, true) >= 8 then
                        return true
                    end
                    break
                end
            end
        end,
    }

    Partner_API.Partner {
        
        key = "gsoul",
        loc_txt = {
            name = 'Green Soul',
            text = {
                'Gains {X:mult,C:white}X#2#{} Mult',
                'when Blind is selected',
                '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
            }
        },
        atlas = "underpartners",
        unlocked = true,
        discovered = true,
        pos = {x = 2, y = 0},
        config = {extra = {
            related_card = "j_ub_kindness",
            Xmult = 1
        }
        },
        loc_vars = function(self, info_queue, card)
            local link_level = self:get_link_level()
            local benefits = 1
            if link_level == 1 then benefits = 3 end
            return { vars = {card.ability.extra.Xmult,0.1*benefits} }
        end,
        calculate = function(self, card, context)
            if context.setting_blind then
                local link_level = self:get_link_level()
                local benefits = 1
                if link_level == 1 then benefits = 3 end
                card.ability.extra.Xmult = card.ability.extra.Xmult + 0.1*benefits
            end
            if context.joker_main then
                return {xmult = card.ability.extra.Xmult}
            end
        end,
        check_for_unlock = function(self,args)
            for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
                if v.key == 'j_ub_kindness' then
                    if get_joker_win_sticker(v, true) >= 8 then
                        return true
                    end
                    break
                end
            end
        end,
    }

    Partner_API.Partner {
        
        key = "psoul",
        loc_txt = {
            name = 'Purple Soul',
            text = {
                'Click to pay {C:attention}20%{} of',
                'the Blind requirement and',
                'obtain {C:gold}$#2#',
                '{C:inactive}(Currently #1#)'
            }
        },
        atlas = "underpartners",
        unlocked = true,
        discovered = true,
        pos = {x = 3, y = 0},
        config = {extra = {
            related_card = "j_ub_perseverance",
        }
        },
        loc_vars = function(self, info_queue, card)
            local link_level = self:get_link_level()
            local benefits = 1
            if link_level == 1 then benefits = 2 end
            if G.GAME.blind then
                if G.GAME.blind.in_blind then
                    local perc = G.GAME.blind.chips * 0.2
                    return { vars = {perc}, 5*benefits}
                else
                    return { vars = {0,5*benefits} }
                end
            else
                return {vars={0,5*benefits}}
            end
        end,
        calculate = function(self, card, context)
            if context.partner_click and G.GAME.blind.in_blind then
                local link_level = self:get_link_level()
                local benefits = 1
                local perc = G.GAME.blind.chips *0.2
                if G.GAME.chips >= perc then
                    if link_level == 1 then benefits = 2 end
                    G.GAME.chips = G.GAME.chips - perc
                    ease_dollars(5*benefits)
                    card_eval_status_text(card, "chips", -perc)
                end
            end
        end,
        check_for_unlock = function(self,args)
            for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
                if v.key == 'j_ub_perseverance' then
                    if get_joker_win_sticker(v, true) >= 8 then
                        return true
                    end
                    break
                end
            end
        end,
    }

    Partner_API.Partner {
        
        key = "bsoul",
        loc_txt = {
            name = 'Blue Soul',
            text = {
                '{C:clubs}Clubs{} give {X:chips,C:white}X#1#{} when scored'
            }
        },
        atlas = "underpartners",
        unlocked = true,
        discovered = true,
        pos = {x = 4, y = 0},
        config = {extra = {
            related_card = "j_ub_integrity",
        }
        },
        loc_vars = function(self, info_queue, card)
            local link_level = self:get_link_level()
            local benefits = 1
            if link_level == 1 then benefits = 2 end
            return {vars={2*benefits}}
        end,
        calculate = function(self, card, context)
            if context.individual and context.cardarea == G.play then
                if context.other_card:is_suit('Clubs') then
                    local link_level = self:get_link_level()
                    local benefits = 1
                    if link_level == 1 then benefits = 2 end
                    return {xchips = 2*benefits}
                end
            end
        end,
        check_for_unlock = function(self,args)
            for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
                if v.key == 'j_ub_integrity' then
                    if get_joker_win_sticker(v, true) >= 8 then
                        return true
                    end
                    break
                end
            end
        end,
    }

    Partner_API.Partner {
        
        key = "ysoul",
        loc_txt = {
            name = 'Yellow Soul',
            text = {
                'Click to pay {C:gold}$#1#{} and obtain',
                'a {C:attention}Joker'
            }
        },
        atlas = "underpartners",
        unlocked = true,
        discovered = true,
        pos = {x = 0, y = 1},
        config = {extra = {
            related_card = "j_ub_justice",
        }
        },
        loc_vars = function(self, info_queue, card)
            local link_level = self:get_link_level()
            local benefits = 1
            if link_level == 1 then benefits = 2 end
            return {vars={14/benefits}}
        end,
        calculate = function(self, card, context)
           if context.partner_click then
                local link_level = self:get_link_level()
                local benefits = 1
                if link_level == 1 then benefits = 2 end
                if #G.jokers.cards < G.jokers.config.card_limit and ((to_big(G.GAME.dollars)- to_big(G.GAME.bankrupt_at))>=to_big(14/benefits)) then
                    G.E_MANAGER:add_event(Event({func = function()
                        SMODS.add_card{key = pseudorandom_element(UNDERBALATRO.mod.jokers, pseudoseed('yellowsoul')).key}
                        ease_dollars(-(14/benefits))
                        card_eval_status_text(card, "dollars", -14/benefits)
                    return true end}))
                end
           end
        end,
        check_for_unlock = function(self,args)
            for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
                if v.key == 'j_ub_justice' then
                    if get_joker_win_sticker(v, true) >= 8 then
                        return true
                    end
                    break
                end
            end
        end,
    }

    Partner_API.Partner {
        
        key = "rbsoul",
        loc_txt = {
            name = 'Red & Blue Soul',
            text = {
                'Click to switch between',
                '{C:mult}Mult{} and {C:chips}Chips',
                '{C:inactive}(Currently {C:mult}+#1#{C:inactive} and {C:chips}+#2#{C:inactive})'
            }
        },
        atlas = "underpartners",
        unlocked = true,
        discovered = true,
        pos = {x = 1, y = 1},
        config = {extra = {
            related_card = "j_ub_soulwheel",
            switch = 'mult'
        }
        },
        loc_vars = function(self, info_queue, card)
            local link_level = self:get_link_level()
            local benefits = 1
            if link_level == 1 then benefits = 2 end
            if card.ability.extra.switch == 'mult' then
                return {vars={20*benefits, 0}}
            else
                return {vars={0,100*benefits}}
            end
        end,
        calculate = function(self, card, context)
           if context.partner_click then
                if card.ability.extra.switch == 'mult' then
                    card.ability.extra.switch = 'chips'
                else
                    card.ability.extra.switch = 'mult'
                end
           end
           if context.joker_main then
                local link_level = self:get_link_level()
                local benefits = 1
                if link_level == 1 then benefits = 2 end
                if card.ability.extra.switch == 'mult' then
                    return {mult = 20*benefits}
                else
                    return {chips = 100*benefits}
                end
           end
        end,
        check_for_unlock = function(self,args)
            for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
                if v.key == 'j_ub_soulwheel' then
                    if get_joker_win_sticker(v, true) >= 8 then
                        return true
                    end
                    break
                end
            end
        end,
    }
end
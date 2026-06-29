-----------------------CHALLENGES!--------------------------
SMODS.Challenge{
    key = 'snowgrave_1',
    loc_txt = {
        name = 'Snowgrave'
    },
    rules = {
        modifiers = {
            { id = 'joker_slots', value = 2}
        }
    },
    jokers = {
        { id = 'j_ub_noelle', eternal = true},
        { id = 'j_ub_snowdin', eternal = true}
    },
    restrictions = {
        banned_cards = {
            { id = 'c_judgement' },
            { id = 'c_wraith' },
            { id = 'c_soul' },
            { id = 'p_standard_normal_1', ids = {
                'p_standard_normal_1', 'p_standard_normal_2',
                'p_standard_normal_3', 'p_standard_normal_4',
                'p_standard_jumbo_1', 'p_standard_jumbo_2',
                'p_standard_mega_1', 'p_standard_mega_2' }
            },
        },
        banned_tags = {
            { id = 'tag_uncommon' },
            { id = 'tag_rare' },
            { id = 'tag_negative' },
            { id = 'tag_foil' },
            { id = 'tag_holographic' },
            { id = 'tag_polychrome' },
            { id = 'tag_buffoon' },
            { id = 'tag_top_up' },
        },
        banned_other = {
            { id = 'bl_final_heart', type = 'blind' },
            { id = 'bl_final_leaf',  type = 'blind' },
            { id = 'bl_final_acorn', type = 'blind' },
        }
    }
}

--------------------TAGS-------------------------
--[[SMODS.Tag{
    key = 'dcandy',
    loc_txt = {
        name = 'Dark Candy Tag',
        text = {
            'Gives {C:attention}5%{} of the',
            '{C:attention}blind{} requirement'
        }
    },
    apply = function (self,tag,context)
        if context.setting_blind then
            local perc = G.GAME.blind.chips * 0.05
            G.GAME.chips = perc
            tag:yep()
            tag.triggered = true
        end
    end
}]]

--------------------BLINDS-------------------------
SMODS.Blind{
    key = 'jevil',
    loc_txt = {
        name = 'Jevil',
        text = {
            'Debuff a random suit',
            'every hand'
        }
    },
    dollars = 6,
    mult = 2,
    atlas = 'blindub',
    pos = {y=2},
    boss  = {min=1},
    boss_colour = HEX('846d99'),
    debuff = {suit = 'Hearts'},
    calculate = function(self,blind,context)
        if not blind.disabled then
            if context.after then
                self.debuff.suit = pseudorandom_element({'Hearts','Spades','Diamonds','Clubs'},pseudoseed('jevil'))
                for _,card in ipairs(G.playing_cards) do
                    SMODS.recalc_debuff(card)
                end
            end
        end
    end
}

SMODS.Blind{
    key = 'spamton_neo',
    loc_txt = {
        name = 'Spamton Neo',
        text = {
            'Create a Pipis',
            'every hand'
        }
    },
    dollars = 5,
    atlas = 'blindub',
    pos = {y=3},
    mult = 2,
    boss  = {min=2},
    boss_colour = HEX('de40a4'),
    calculate = function(self,blind,context)
        if not blind.disabled then
            if context.after then
                SMODS.add_card({key = 'j_ub_pipis'})
            end
        end
    end
}

SMODS.Blind{
    key = 'roaring_knight',
    loc_txt = {
        name = 'The Roaring Knight',
        text = {
            'Debuff cards held ',
            'in hand'
        }
    },
    dollars = 8,
    atlas = 'blindub',
    pos = {y=4},
    mult = 2,
    boss  = {showdown = true},
    boss_colour = HEX('4f5957'),
    calculate = function(self,blind,context)
        if not blind.disabled then
            if context.individual and context.cardarea == G.hand and not context.end_of_round then
                context.other_card.debuff = true
            end
        end
    end
}

SMODS.Blind{
    key = 'gerson',
    loc_txt = {
        name = 'Gerson Boom',
        text = {
            'Consumables are disabled'
        }
    }, 
    atlas = 'blindub',
    pos = {y=5},
    dollars = 8,
    mult = 2,
    boss  = {min = 3},
    boss_colour = HEX('2b7a34'),
}
-- Dark World Deck

SMODS.Back{
    key = 'dworld',
    loc_txt = {
        name = 'Dark World Deck',
        text = {
            '{C:attention}+3{} Joker slots',
            '{C:red}-2{} discards',
            '{C:blue}-1{} hand'
        },
        unlock = {
            'Discover at least',
            '{C:attention}125{} items from',
            'your collection'
        }
    },
    atlas = 'spritesheet',
    pos = {x=1,y=0},
    config = {hands = -1, joker_slot = 3, discards = -2},
    unlocked = false,
    check_for_unlock = function(self,args)
        return args.type == 'discover_amount' and args.amount >= 125
    end
}

-- True Deck

SMODS.Back{
    key = 'true',
    loc_txt = {
        name = 'True Deck',
        text = {
            'Start run with the',
            '{C:dark_edition}Hone{} and',
            '{C:dark_edition}Glow up{} Vouchers'
        },
        unlock = {
            'Win a run with',
            '{C:attention}Dark World Deck',
            'on any difficulty'
        }
    },
    atlas = 'spritesheet',
    pos = {x=2,y=0},
    config = { vouchers = {'v_hone','v_glow_up'} },
    unlocked = false,
    check_for_unlock = function(self,args)
        return args.type == 'win_deck' and get_deck_win_stake('b_ub_dworld') and true
    end
}
return {
    descriptions = {
        Joker = {
			j_buf_argument = {
				name = "Pertinent Argument",
				text = {"{C:green}1 in 2{} chance to convert",
						"an unscored card into one",
						"of the scored ones, if",
						"played hand is a {C:attention}Two Pair{}"}  
			},
			j_buf_cashout = {
				name = "Cashout Voucher",
				text = {"If {C:attention}winning hand{} triples the Blind's",
					"score {C:attention}requirement{}, earn 0.25% of it",
					"as {C:money}money{} and destroy this Joker",
					"{C:inactive}(Max of{} {C:money}$50{}{C:inactive}){}"
				}
			},
			j_buf_clown = {
				name = "Clown",
				text = {"This Joker gains {C:chips}+#1#{} Chips ",
						"when another Joker is added",
						"{C:inactive}(Currently{} {C:chips}+#2#{} {C:inactive}Chips){}",
						"{C:inactive,s:0.7}Jimbo = Chips{}"
				}
			},
			j_buf_denial = {
				name = "Arstotzkan Denial",
				text = {"{C:mult}+4{} Mult and {C:chips}+20#{} Chips",
						"for each {C:red}Red{} and {C:blue}Blue{} seal",
						"in full deck, respectively",
						"{C:inactive}(Currently{} {C:mult}+#1#{} {C:inactive}Mult /{} {C:chips}+#2#{} {C:inactive}Chips){}",
						}
			},
			j_buf_fivefingers = {
				name = "Five Fingers",
				text = {"{X:mult,C:white}X#1#{} Mult if you own a",
						"multiple of {C:attention}5 Jokers{}",
						"and scored hand",
						"has exactly {C:attention}5 cards{}"
				}
			},
			j_buf_kerman = {
				name = "Jebediah Kerman",
				text = {"Gains {C:mult}+#2#{} Mult every time",
						"any {C:planet}Planet{} card is used",
						"{C:green}1 in 5{} chance to {C:attention}EXPLODE{} on use",
						"{C:inactive}(Currently{} {C:mult}+#1#{} {C:inactive}Mult){}"
				}
			},
			j_buf_korny = {
				name = "Korny Joker",
				text = {"{C:chips}+#1#{}, {C:chips}+#2#{} and {C:chips}+#3#{} Chips",
						"during {C:attention}Small Blind{}, {C:attention}Big Blind{} and",
						"{C:attention}Boss Blind{}, respectively. {C:green}Unknown{}",
						"chance to die at the end of round",
						"{C:inactive,s:0.7}You don't know the chances...{}"
				}
			},
			j_buf_laidback = { 
				name = "Laidback Joker",
				text = {
					"{X:mult,C:white}X#1#{} Mult",
					"Occupies 2 slots",
				},
			},
			j_buf_maggit = { 
				name = "Maggit",
				text = {
					"{X:dark_edition,C:white}^#1#{} Mult if you own a",
					"{C:dark_edition}Nu Metal{} Joker. Otherwise,",
					"{C:attention}only once{}, create one",
					"when {C:attention}Blind{} is selected{}",
					"{C:inactive,s:0.7}(Must have room. #2# created.){}",
				},
			},
			j_buf_memcard = {
				name = "Memory Card",
				text = {"Memorizes up to {C:attention}8{} of the {C:attention}first{} scored",  
						"card each round. Sell to convert a card",
						"in hand into each memorized card, {C:attention}in order{}",
						"{C:inactive}Memorized #1#. Last: #3##2#{}",
						}
			},
			j_buf_patronizing = {
				name = "Patronizing Joker",
				text = {"{X:chips,C:white}X#1#{} Chips",
						"{C:attention}Selects{} as many cards",
						"for you as possible"
				}
			},
			j_buf_rerollin = {
				name = "Rerollin'",
				text = {"Earn {C:money}$#1#{} for your",          
						"{C:attention}5th reroll{} each shop",
						"{C:inactive}(#3# rerolls required){}"}
			},
			j_buf_whitepony = {
				name = "White Pony",
				text = {"{C:mult}+#1#{} Mult",
						"Doubles each Ante"}
			}, 
        },
        Back = {
        
        },
        Tarot = {
           
        },
        Spectral = {
           
        },
        Other = {
            korny_info = {
                name = "Credit",
                text = {
                    "Original art",
                    "by {C:green}Snakey{}",
                }
            },
			maggit_info = {
				name = "Nu Metal Jokers",
				text = {
					"Clown, Five Fingers",
					"Korny Joker, Rerollin'",
					"and White Pony"
				}
			},
        },
        Sleeve = {
            
        },
    },
    misc = {
       
    },
}
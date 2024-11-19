return {
    descriptions = {
        Joker = {
			j_buf_abyssalp = {
				name = "Abyssal Prism",
				text = {"Upon {C:attention}acquiring{} this joker, {C:attention}banish{} all",
						"others. One becomes {C:dark_edition}Negative{} each 3",
						"turns. Sell this to return jokers",
						"{C:inactive}(#2#/3 Rounds. #1# negative Joker(s)){}"
				}
			},
			j_buf_argument = {
				name = "Pertinent Argument",
				text = {"{C:green}1 in 2{} chance to convert",
						"an unscored card into one",
						"of the scored ones, if",
						"played hand is a {C:attention}Two Pair{}"}  
			},
			j_buf_blackstallion = {
				name = "Black Stallion",
				text = {"{C:buf_spc}+#1#{} Mult",
						"Doubles each Ante"}
			},
			j_buf_cashout = {
				name = "Cashout Voucher",
				text = {"If {C:attention}winning hand{} triples the Blind's",
					"score {C:attention}requirement{}, earn 0.4% of it",
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
				text = {"{C:mult}+5{} Mult or {C:chips}+30{} Chips",
						"for each {C:red}Red{} or {C:blue}Blue{} seal",
						"in full deck, {C:attention}respectively{}",
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
					"{C:inactive,s:0.7}(Must have room){}",
				},
			},
			j_buf_maggit_alt = { 
				name = "Maggit",
				text = {
					"{X:dark_edition,C:white}^#1#{} Mult if you own a",
					"{C:dark_edition}Nu Metal{} Joker. Otherwise,",
					"{C:attention}only once{}, create one",
					"when {C:attention}Blind{} is selected{}",
					"{C:inactive,s:0.7}(Already created){}",
				},
			},
			j_buf_memcard = {
				name = "Memory Card",
				text = {"Memorizes the {C:attention}first{} scored card each {C:attention}round{}",  
						"up to {C:attention}8{} times. Sell to convert a card in",
						"hand into each memorized card, {C:attention}in order{}",
						"{C:inactive}Memorized #1#. Last: #3##2#{}",
						}
			},
			j_buf_dxmemcard = {
				name = "Deluxe Memory Card",
				text = {"Memorizes the {C:attention}first{} scored card each {C:buf_spc}hand{}",  
						"up to {C:buf_spc}16{} times. Sell to convert a card in",
						"hand into each memorized card, {C:attention}in order{}",
						"{C:inactive}Memorized #1#. Last: #3##2#{}",
						}
			},
			j_buf_patronizing = {
				name = "Patronizing Joker",
				text = {"{X:chips,C:white}X#1#{} Chips",
						"{C:attention}Forces{} 5 cards to",
						"always be {C:attention}selected{}"
				}
			},
			j_buf_rerollin = {
				name = "Rerollin'",
				text = {"Earn {C:money}$#1#{} for your fifth",          
						"{C:green}reroll{} each shop",
						"{C:inactive}({}{C:green}#3#{}{C:inactive} rerolls left){}"}
			},
			j_buf_roulette = {
				name = "Russian Roulette",
				text = {"When {C:attention}Blind{} is selected, earn {C:money}$30{}",          
						"{C:green}1 in #2#{} chance you {C:attention}lose the game{} instead",
						"If chance reaches {C:green}1 in 2{} and you win,",
						"create a random {C:legendary}Legendary{} Joker",
						"{C:inactive,s:0.7}(Chance increases each round)"
				}
			},
			j_buf_whitepony = {
				name = "White Pony",
				text = {"{C:mult}+#1#{} Mult",
						"Doubles each Ante"}
			}, 
        },
        Back = {
			b_buf_jstation = {
				name = "JimboStation Deck",
				text = {"Start run with",
						"{C:red} Memory Card{}",
						"{C:attention}+1{} hand size"
				}
			},
			b_buf_galloping = {
				name = "Galloping Deck",
				text = {"Start run with",
						"{C:buf_spc}Black Stallion{}",
				}
			},
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
			special_info = {
				name = "Special Joker",
				text = {
					"Normally unobtainable",
					"Given under {E:1,C:buf_spc}special{}",
					"conditions"
				}
			},
			banish_info = {
				name = "Banished",
				text = {
					"Banished Jokers",
					"Return to their",
					"{C:attention}base{} state"
				}
			},
        },
        Sleeve = {
			sleeve_buf_jstation = {
				name = "JimboStation Sleeve",
				text = {"Start run with",
						"{C:red}Memory Card{}",
						"{C:attention}+1{} hand size"
				}
			},
			sleeve_buf_jstation_alt = {
				name = "JimboStation Sleeve",
				text = {"Your {C:red}Memory Card{}",
						"is {E:1,C:buf_spc}special{}",
						"{C:attention}+1{} hand size"
				}
			},
			sleeve_buf_galloping = {
				name = "Galloping Sleeve",
				text = {"Start run with",
						"{C:buf_spc}Black Stallion{}",
				}
			},
			sleeve_buf_galloping_alt = {
				name = "Galloping Sleeve",
				text = {"You start with",
						"{C:green}White Pony{} instead",
						"{C:blue}-2{} hands"
				}
			}, 
        },
    },
    misc = {
		dictionary = {
			-------- CARD MESSAGES --------
			buf_korny_ok = "He's ok!",
			buf_korny_dd = "Dead!",
			buf_prism_eor1 = "Torment...",
			buf_prism_eor2 = "+1 Negative!",
			buf_prism_sck = "Begone!",
			buf_memory = "Memorized!",
			buf_memfull = "Memory Full!",
			buf_doubled = "Doubled!",
			buf_convert = "Converted!",
			buf_blowup = "B O O M !",
			buf_ydead = "You're dead...",
			buf_dry = "Dry fire!",
			-------- MAGGIT STUFF --------
			k_buf_notyet = "(Must have room)",
			-------- MEMCARD STUFF --------
			buf_Ace = "Ace",
			buf_Jack = "Jack",
			buf_Queen = "Queen",
			buf_King = "King",
			buf_of = " of ",
			buf_Spades = "Spades",
			buf_Hearts = "Hearts",
			buf_Clubs = "Clubs",
			buf_Diamonds = "Diamonds",
			buf_Fleurons = "Fleurons",
			buf_Halberds = "Halberds",
			-------- RARITY LABEL --------
			k_buf_spc = "Special",
		},
    },
}
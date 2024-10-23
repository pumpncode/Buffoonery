return {
    descriptions = {
        Joker = {
			j_buf_argument = {
				name = "Discussão Acalourada",
				text = {"{C:green}1 de 2{} chance de converter",
						"uma carta não-pontuada em",
						"uma das pontuadas, caso",
						"a mão jogada for {C:attention}Dois Pares{}"}  
			},
			j_buf_blackstallion = {
				name = "Black Stallion",
				text = {"{E:1,C:dark_edition}+#1#{} Multi",
						"Dobra a cada Aposta"}
			},
			j_buf_cashout = {
				name = "Voucher de Saque",
				text = {"Se a {C:attention}mão vencedora{} pontuar 3x",
					"mais que o {C:attention}Blind{}, ganhe 0.25% dele",
					"em {C:money}dinheiro{} e destrua este Curinga",
					"{C:inactive}(No máximo{} {C:money}$50{}{C:inactive}){}"
				}
			},
			j_buf_clown = {
				name = "Palhaço",
				text = {"Ganha {C:chips}+#1#{} Fichas quando",
						"outro Curinga é adicionado",
						"{C:inactive}(Atualmente{} {C:chips}+#2#{} {C:inactive}Fichas){}",
						"{C:inactive,s:0.7}Jimbo = Chips{}"
				}
			},
			j_buf_denial = {
				name = "Rejeição de Arstotzka",
				text = {"{C:mult}+4{} Multi e {C:chips}+20{} Fichas por",
						"cada selo {C:red}Vermelho{} e {C:blue}Azul{} no",
						"baralho completo, respectivamente",
						"{C:inactive}(Atualmente{} {C:mult}+#1#{} {C:inactive}Multi/{}{C:chips}+#2#{} {C:inactive}Fichas){}",
						}
			},
			j_buf_fivefingers = {
				name = "Cinco Dedos",
				text = {"{X:mult,C:white}X#1#{} Multi se você tem",
						"um múltiplo de {C:attention}5 Curingas{}",
						"e a mão pontuada",
						"tem exatamente {C:attention}5 cartas{}"
				}
			},
			j_buf_kerman = {
				name = "Jebediah Kerman",
				text = {"Ganha {C:mult}+#2#{} Multi sempre que",
						"uma carta de {C:planet}Planeta{} é usada",
						"{C:green}1 de 5{} chance de {C:attention}EXPLODIR{} em vez",
						"{C:inactive}(Atualmente{} {C:mult}+#1#{} {C:inactive}Multi){}"
				}
			},
			j_buf_korny = {
				name = "Kornringa",
				text = {"{C:chips}+#1#{}, {C:chips}+#2#{} e {C:chips}+#3#{} Fichas durante",
						"{C:attention}Small Blind{}, {C:attention}Big Blind{} e {C:attention}Blind de Chefe{},",
						"respectivamente. Chance {C:green}desconhecida{}",
						"de morrer ao fim da rodada",
						"{C:inactive,s:0.7}You don't know the chances...{}"
				}
			},
			j_buf_laidback = { 
				name = "Curinga Folgado",
				text = {
					"{X:mult,C:white}X#1#{} Multi",
					"Ocupa 2 espaços",
				},
			},
			j_buf_maggit = { 
				name = "Maggit",
				text = {
					"{X:dark_edition,C:white}^#1#{} Multi se você tem",
					"um Curinga do {C:dark_edition}Nu Metal{}",
					"Se não, {C:attention}só uma vez{}, crie um",
					"quando o {C:attention}Blind{} for escolhido",
					"{C:inactive,s:0.7}#2#{}",
				},
			},
			j_buf_memcard = {
				name = "Memory Card",
				text = {"Memoriza a {C:attention}primeira{} carta pontuada a cada",  
						"{C:attention}rodada{} por {C:attention}8{} rodadas. Venda para converter uma",
						"carta na mão em uma memorizada, {C:attention}na ordem{}",
						"{C:inactive}Memorizadas: #1#. Última: #3##2#{}",
						}
			},
			j_buf_dxmemcard = {
				name = "Memory Card Deluxe",
				text = {"Memoriza a {C:attention}primeira{} carta pontuada a cada",  
						"{E:1,C:dark_edition}mão{} por {E:1,C:dark_edition}16{} mãos. Venda para converter uma",
						"carta na mão em uma memorizada, {C:attention}na ordem{}",
						"{C:inactive}Memorizadas: #1#. Última: #3##2#{}",
						}
			},
			j_buf_patronizing = {
				name = "Curinga Intrometido",
				text = {"{X:chips,C:white}X#1#{} Fichas",
						"{C:attention}Seleciona{} quantas cartas",
						"puder para você"
				}
			},
			j_buf_rerollin = {
				name = "Rerollin'",
				text = {"Ganhe {C:money}$#1#{} pela sua",          
						"{C:attention}5ª atualização{} cada loja",
						"{C:inactive}(Falta(m){} {C:green}#3#{} {C:inactive}atualizações){}"}
			},
			j_buf_whitepony = {
				name = "White Pony",
				text = {"{C:mult}+#1#{} Multi",
						"Dobra a cada Aposta"}
			}, 
        },
        Back = {
			b_buf_jstation = {
				name = "Baralho do JimboStation",
				text = {"Comece com um",
						"{C:red}Memory Card{}",
						"{C:attention}+1{} tamanho de mão"
				}
			},
			b_buf_galloping = {
				name = "Baralho Galopeiro",
				text = {"Começe com um",
						"{E:1,C:green} Black Stallion{}",
				}
			},
        },
        Tarot = {
           
        },
        Spectral = {
           
        },
        Other = {
            korny_info = {
                name = "Créditos",
                text = {
                    "Arte original",
                    "por {C:green}Snakey{}",
                }
            },
			maggit_info = {
				name = "Curingas do Nu Metal",
				text = {
					"Cinco Dedos, Kornringa,",
					"Rerollin', Palhaço",
					"e White Pony",
				}
			},
			special_info = {
				name = "Curinga Especial",
				text = {
					"Normalmente inacessível",
					"Dado sob condições",
					"{E:1,C:dark_edition}especiais{}"
				}
			},
        },
        Sleeve = {
			sleeve_buf_jstation = {
				name = "Capa do JimboStation",
				text = {"Comece com um",
						"{C:red}Memory Card{}",
						"{C:attention}+1{} tamanho de mão"
				}
			},
			sleeve_buf_jstation_alt = {
				name = "Capa do JimboStation",
				text = {"Seu {C:red}Memory Card{}",
						"é a versão {E:1,C:dark_edition}Deluxe{}",
						"{C:attention}+1{} tamanho de mão"
				}
			},
			sleeve_buf_galloping = {
				name = "Capa Galopeira",
				text = {"Comece com um",
						"{C:green}Black Stallion{}",
				}
			},
			sleeve_buf_galloping_alt = {
				name = "Capa Galopeira",
				text = {"Você começa com um",
						"{C:green}White Pony{} em vez disso",
						"{C:blue}-2{} mãos"
				}
			}, 
        },
    },
    misc = {
       
    },
}
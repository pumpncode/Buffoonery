-- Manual Load-Order for Collection:
-- If a Joker-File isn't in this list, it won't be loaded.
local load_list = {
  "rerollin",
  "cashout",
  "clays",
  "fivefingers",
  "korny",
  "laidback",
  "denial",
  "argument",
  "porcelainj",
  "sayajimbo",
  "tailored",
  "roulette",
  "lemmesolo",
  "gfondue",
  "camarosa",
  "memcard",
  "special/memcard_dx", -- Sleeve Exclusive
  "dorkshire",
  "special/dorkshire_g", -- Sleeve Exclusive
  "abyssalp",
  "special/abyssalecho",
  "afan",
  "special/afan_spc",
  "clown",
  "special/van",
  "kerman",
  "special/kerman_spc",
  "whitepony",
  "special/blackstallion",
  "patronizing",
  "special/supportive",
  "jokergebra",
  "special/integral",
  "maggit",
}
local jokerpath = "content/jokers/"
for index = 1, #load_list do
  if load_list[index] then
    assert(SMODS.load_file(jokerpath..load_list[index]..".lua"))()
  end
end

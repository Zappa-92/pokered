PrizeDifferentMenuPtrs:
	dw PrizeMenuMon1Entries
	dw PrizeMenuMon1Cost

	dw PrizeMenuMon2Entries
	dw PrizeMenuMon2Cost

	dw PrizeMenuTMsEntries
	dw PrizeMenuTMsCost

NoThanksText:
	db "NO THANKS@"

PrizeMenuMon1Entries:
	db ABRA
	db CLEFAIRY
IF DEF(_RED)
	db TAUROS
ENDC
IF DEF(_BLUE)
	db MAGMAR
ENDC
	db "@"

PrizeMenuMon1Cost:
IF DEF(_RED)
	coins 180
	coins 500
ENDC
IF DEF(_BLUE)
	coins 120
	coins 750
ENDC
	coins 1200
	db "@"

PrizeMenuMon2Entries:
IF DEF(_RED)
	db DRATINI
	db SCYTHER
ENDC
IF DEF(_BLUE)
	db PINSIR
	db DRATINI
ENDC
	db PORYGON
	db "@"

PrizeMenuMon2Cost:
IF DEF(_RED)
	coins 2800
	coins 3300
	coins 4000
ENDC
IF DEF(_BLUE)
	coins 2800
	coins 3300
	coins 4000
ENDC
	db "@"

PrizeMenuTMsEntries:
	db TM_23
	db TM_15
	db TM_50
	db "@"

PrizeMenuTMsCost:
	coins 1500
	coins 2000
	coins 2500
	db "@"

Route2Mons:
	db $19
	db 3,RATTATA
	db 3,PIDGEY
	db 4,PIDGEY
	db 4,RATTATA
	db 5,PIDGEY
	IF DEF(_RED)
		db 3,WEEDLE
		db 3,CATERPIE
	ENDC
	IF DEF(_BLUE)
		db 3,CATERPIE
		db 3,WEEDLE
	ENDC
	db 2,RATTATA
	db 5,RATTATA
	IF DEF(_RED)
		db 4,WEEDLE
		db 5,WEEDLE
	ENDC
	IF DEF(_BLUE)
		db 4,CATERPIE
		db 5,CATERPIE
	ENDC
	db $00

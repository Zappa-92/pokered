ForestMons:
	db $08
	IF DEF(_RED)
		db 6,WEEDLE
		db 8,KAKUNA
		db 6,PIDGEY
		db 6,FARFETCHD
		db 7,CATERPIE
		db 7,METAPOD
		db 8,PIKACHU
	ENDC
	IF DEF(_BLUE)
		db 6,CATERPIE
		db 8,METAPOD
		db 6,SPEAROW
		db 6,FARFETCHD
		db 7,WEEDLE
		db 7,KAKUNA
		db 8,PIKACHU
	ENDC
	db 7,DODUO
	db 12,PIDGEOTTO
	db $00

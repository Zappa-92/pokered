Route24Mons:
	db $19
	IF DEF(_RED)
		db 14,WEEDLE
		db 15,KAKUNA
		db 17,PIDGEY
		db 16,ODDISH
		db 16,BELLSPROUT
		db 17,ODDISH
		db 11,ABRA
		db 10,ABRA
		db 12,BULBASAUR
		db 13,ABRA
	ENDC
	IF DEF(_BLUE)
		db 14,CATERPIE
		db 15,METAPOD
		db 17,PIDGEY
		db 16,BELLSPROUT
		db 16,ODDISH
		db 17,BELLSPROUT
		db 11,ABRA
		db 10,ABRA
		db 12,BULBASAUR
		db 13,ABRA
	ENDC
	db $00

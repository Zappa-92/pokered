Route15Mons:
	db $0F
	IF DEF(_RED)
		db 33,ODDISH
		db 31,BELLSPROUT
		db 33,DITTO
		db 31,PIDGEY
		db 35,VENONAT
		db 35,PARAS
		db 34,ODDISH
		db 37,GLOOM
		db 35,PIDGEOTTO
	ENDC
	IF DEF(_BLUE)
		db 33,BELLSPROUT
		db 31,ODDISH
		db 33,DITTO
		db 31,PIDGEY
		db 35,VENONAT
		db 35,PARAS
		db 34,BELLSPROUT
		db 37,WEEPINBELL
		db 35,PIDGEOTTO
	ENDC
	db $00

Route12Mons:
	db $0F
	IF DEF(_RED)
		db 27,ODDISH
		db 27,BELLSPROUT
		db 28,PIDGEY
		db 26,PIDGEY
		db 27,VENONAT
		db 27,VENONAT
		db 28,ODDISH
		db 29,PIDGEY
		db 32,GLOOM
		db 30,WEEPINBELL
	ENDC
	IF DEF(_BLUE)
		db 27,BELLSPROUT
		db 27,ODDISH
		db 28,PIDGEY
		db 26,PIDGEY
		db 27,VENONAT
		db 27,VENONAT
		db 28,BELLSPROUT
		db 29,PIDGEY
		db 32,WEEPINBELL
		db 30,GLOOM
	ENDC
	db $00

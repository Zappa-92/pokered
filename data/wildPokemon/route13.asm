Route13Mons:
	IF DEF(_RED)
		db $14
		db 30,ODDISH
		db 30,BELLSPROUT
		db 32,PIDGEY
		db 30,VENONAT
		db 31,VENONAT
		db 31,ODDISH
		db 30,DITTO
		db 32,GLOOM
		db 33,GLOOM
		db 32,WEEPINBELL
	ENDC
	IF DEF(_BLUE)
		db $14
		db 30,ODDISH
		db 30,BELLSPROUT
		db 32,PIDGEY
		db 30,VENONAT
		db 31,VENONAT
		db 31,BELLSPROUT
		db 30,DITTO
		db 32,WEEPINBELL
		db 33,WEEPINBELL
		db 32,GLOOM
	ENDC
	db $00

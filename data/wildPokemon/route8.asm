Route8Mons:
	db $0F
	IF DEF(_RED)
		db 28,PIDGEY
		db 28,MEOWTH
		db 27,EKANS
		db 26,GROWLITHE
		db 27,MANKEY
		db 29,EKANS
		db 27,SANDSHREW
		db 25,GROWLITHE
		db 27,VULPIX
		db 28,GROWLITHE
	ENDC
	IF DEF(_BLUE)
		db 28,PIDGEY
		db 28,MANKEY
		db 27,SANDSHREW
		db 26,VULPIX
		db 27,MEOWTH
		db 29,SANDSHREW
		db 27,EKANS
		db 25,VULPIX
		db 27,GROWLITHE
		db 28,VULPIX
	ENDC
	db $00

Route7Mons:
	db $0F
	IF DEF(_RED)
		db 29,PIDGEY
		db 29,ODDISH
		db 27,MANKEY
		db 32,ODDISH
		db 28,GROWLITHE
		db 28,VULPIX
		db 30,GROWLITHE
		db 29,MANKEY
		db 29,MEOWTH
		db 30,PONYTA
	ENDC
	IF DEF(_BLUE)
		db 29,PIDGEY
		db 29,BELLSPROUT
		db 27,MEOWTH
		db 32,BELLSPROUT
		db 28,VULPIX
		db 28,GROWLITHE
		db 30,VULPIX
		db 29,MEOWTH
		db 29,MANKEY
		db 30,PONYTA
	ENDC
	db $00

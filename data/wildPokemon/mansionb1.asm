MansionMonsB1:
	db $0A
	IF DEF(_RED)
		db 33,KOFFING
		db 35,GROWLITHE
		db 35,VULPIX
		db 32,PONYTA
		db 31,DITTO
		db 40,WEEZING
		db 34,PONYTA
		db 35,GRIMER
		db 42,MUK
		db 38,MAGMAR
	ENDC
	IF DEF(_BLUE)
		db 33,GRIMER
		db 35,VULPIX
		db 35,GROWLITHE
		db 32,PONYTA
		db 31,DITTO
		db 40,MUK
		db 34,PONYTA
		db 35,KOFFING
		db 42,WEEZING
		db 38,MAGMAR
	ENDC
	db $00

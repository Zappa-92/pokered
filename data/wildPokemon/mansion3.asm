MansionMons3:
	db $0A
	IF DEF(_RED)
		db 34,KOFFING
		db 36,GROWLITHE
		db 37,KOFFING
		db 35,PONYTA
		db 37,MAGMAR
		db 42,DITTO
		db 37,GRIMER
		db 40,WEEZING
		db 38,PONYTA
		db 43,MUK
	ENDC
	IF DEF(_BLUE)
		db 34,GRIMER
		db 36,VULPIX
		db 37,GRIMER
		db 35,PONYTA
		db 37,MAGMAR
		db 42,DITTO
		db 37,KOFFING
		db 40,MUK
		db 38,PONYTA
		db 43,WEEZING
	ENDC
	db $00

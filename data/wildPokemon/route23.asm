Route23Mons:
	db $0A
	IF DEF(_RED)
		db 36,EKANS
		db 36,SANDSHREW
	ENDC
	IF DEF(_BLUE)
		db 36,SANDSHREW
		db 36,EKANS
	ENDC
	db 39,DITTO
	db 43,FEAROW
	db 41,DITTO
	db 44,FEAROW
	IF DEF(_RED)
		db 41,ARBOK
	ENDC
	IF DEF(_BLUE)
		db 41,SANDSLASH
	ENDC
	db 43,DITTO
	db 46,FEAROW
	db $00

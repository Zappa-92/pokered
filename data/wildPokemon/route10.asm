Route10Mons:
	db $0F
	IF DEF(_RED)
		db 21,VOLTORB
		db 21,SPEAROW
		db 17,EKANS
		db 17,SANDSHREW
		db 19,SPEAROW
		db 20,EKANS
		db 23,VOLTORB
		db 23,SPEAROW
		db 23,EKANS
		db 20,SANDSHREW
	ENDC
	IF DEF(_BLUE)
		db 21,VOLTORB
		db 21,SPEAROW
		db 17,SANDSHREW
		db 17,EKANS
		db 19,SPEAROW
		db 20,SANDSHREW
		db 23,VOLTORB
		db 23,SPEAROW
		db 23,SANDSHREW
		db 20,EKANS
	ENDC
	db $00

ZoneMonsCenter:
	db $1E
	IF DEF(_RED)
		db 29,NIDORAN_M
		db 31,RHYHORN
		db 28,VENONAT
		db 31,EXEGGCUTE
		db 37,NIDORINO
		db 26,BULBASAUR
		db 34,PARASECT
		db 31,SCYTHER
		db 31,PINSIR
		db 30,CHANSEY
	ENDC
	IF DEF(_BLUE)
		db 29,NIDORAN_F
		db 31,RHYHORN
		db 28,VENONAT
		db 31,EXEGGCUTE
		db 37,NIDORINA
		db 26,BULBASAUR
		db 34,PARASECT
		db 31,PINSIR
		db 31,SCYTHER
		db 30,CHANSEY
	ENDC
	db $00

IslandMonsB2:
	db $0A
	IF DEF(_RED)
		db 33,SEEL
		db 34,SLOWPOKE
		db 34,PSYDUCK
		db 33,KRABBY
		db 34,JYNX
		db 34,HORSEA
		db 33,SHELLDER
		db 36,SLOWBRO
		db 35,JYNX
	ENDC
	IF DEF(_BLUE)
		db 33,SEEL
		db 34,PSYDUCK
		db 34,SLOWPOKE
		db 33,HORSEA
		db 34,JYNX
		db 34,KRABBY
		db 33,STARYU
		db 35,GOLDUCK
		db 35,JYNX
	ENDC
	db $00

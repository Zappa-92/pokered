IslandMonsB2:
	db $0A
	IF DEF(_RED)
		db 32,SEEL
		db 32,SLOWPOKE
		db 28,HORSEA
		db 28,KRABBY
		db 30,STARYU
		db 30,HORSEA
		db 28,SHELLDER
		db 37,SLOWBRO
		db 30,JYNX
	ENDC
	IF DEF(_BLUE)
		db 32,SEEL
		db 32,PSYDUCK
		db 28,KRABBY
		db 28,HORSEA
		db 30,SHELLDER
		db 30,KRABBY
		db 28,STARYU
		db 37,GOLDUCK
		db 30,JYNX
	ENDC
	db $00

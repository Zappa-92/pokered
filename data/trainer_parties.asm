TrainerDataPointers:
	dw YoungsterData
	dw BugCatcherData
	dw LassData
	dw SailorData
	dw JrTrainerMData
	dw JrTrainerFData
	dw PokemaniacData
	dw SuperNerdData
	dw HikerData
	dw BikerData
	dw BurglarData
	dw EngineerData
	dw Juggler1Data
	dw FisherData
	dw SwimmerData
	dw CueBallData
	dw GamblerData
	dw BeautyData
	dw PsychicData
	dw RockerData
	dw JugglerData
	dw TamerData
	dw BirdKeeperData
	dw BlackbeltData
	dw Green1Data
	dw ProfOakData
	dw ChiefData
	dw ScientistData
	dw GiovanniData
	dw RocketData
	dw CooltrainerMData
	dw CooltrainerFData
	dw BrunoData
	dw BrockData
	dw MistyData
	dw LtSurgeData
	dw ErikaData
	dw KogaData
	dw BlaineData
	dw SabrinaData
	dw GentlemanData
	dw Green2Data
	dw Green3Data
	dw LoreleiData
	dw ChannelerData
	dw AgathaData
	dw LanceData

; if first byte != FF, then
	; first byte is level (of all pokemon on this team)
	; all the next bytes are pokemon species
	; null-terminated
; if first byte == FF, then
	; first byte is FF (obviously)
	; every next two bytes are a level and species
	; null-terminated

YoungsterData:
; Route 3
	db 17,RATTATA,EKANS,0
	db 18,DRATINI,0
; Mt. Moon 1F
	db 17,PIKACHU,MACHOP,ZUBAT,0
; Route 24
	db 25,RATTATA,EKANS,FARFETCHD,0
; Route 25
	db 24,PSYDUCK,SPEAROW,0
	db 17,SLOWPOKE,0
	db 23,KADABRA,SANDSHREW,0
; SS Anne 1F Rooms
	db 28,NIDORAN_M,0
; Route 11
	db 25,EKANS,0
	db 24,SANDSHREW,ZUBAT,0
	db 22,SEEL,SLOWPOKE,RATICATE,0
	db 22,EXEGGCUTE,NIDORINO,0
; Unused
	db 17,SPEAROW,RATTATA,RATTATA,SPEAROW,0
BugCatcherData:
; Viridian Forest
	db 10,CATERPIE,BUTTERFREE,0
	db 10,WEEDLE,KAKUNA,BEEDRILL,0
	db 13,PINSIR,0
; Route 3
	db 14,VENONAT,PARAS,BUTTERFREE,0
	db 14,PARAS,KAKUNA,VENONAT,METAPOD,0
	db 17,METAPOD,SCYTHER,0
; Mt. Moon 1F
	db 15,WEEDLE,BEEDRILL,0
	db 15,CATERPIE,METAPOD,PINSIR,0
; Route 24
	db 23,BUTTERFREE,PARAS,0
; Route 6
	db 23,WEEDLE,BEEDRILL,PARAS,0
	db 27,PINSIR,0
; Unused
	db 18,METAPOD,CATERPIE,VENONAT,0
; Route 9
	db 28,BEEDRILL,BUTTERFREE,0
	db 29,PARAS,SCYTHER,VENONAT,0
LassData:
; Route 3
	db 17,PIDGEY,EXEGGCUTE,0
	db 17,PIKACHU,NIDORAN_M,0
	db 19,JIGGLYPUFF,0
; Route 4
	db 43,PARAS,NIDORINA,PARASECT,0
; Mt. Moon 1F
	db 19,ODDISH,VULPIX,0
	db 20,CLEFAIRY,0
; Route 24
	db 23,SEEL,NIDORAN_F,0
	db 22,CUBONE,NIDORAN_F,0
; Route 25
	db 23,NIDORAN_M,NIDORAN_F,0
	db 22,ODDISH,EEVEE,HORSEA,0
; SS Anne 1F Rooms
	db 26,PIDGEOTTO,NIDORAN_F,0
; SS Anne 2F Rooms
	db 26,STARYU,PIKACHU,0
; Route 8
	db 32,NIDORAN_F,NIDORINA,0
	db 31,MEOWTH,PIKACHU,POLIWHIRL,0
	db 30,PIDGEY,EXEGGCUTE,NIDORAN_M,MEOWTH,PIKACHU,0
	db 31,CLEFAIRY,SLOWPOKE,0
; Celadon Gym
	db 34,TANGELA,WEEPINBELL,0
	db 33,EXEGGCUTE,GLOOM,0
SailorData:
; SS Anne Stern
	db 28,SEEL,SHELLDER,0
	db 28,MACHOP,KRABBY,0
; SS Anne B1F Rooms
	db 29,SHELLDER,0
	db 26,HORSEA,SHELLDER,TENTACOOL,0
	db 27,TENTACOOL,STARYU,0
	db 26,HORSEA,STARYU,KRABBY,0
	db 27,MACHOP,0
; Vermilion Gym
	db 30,PIKACHU,VOLTORB,0
JrTrainerMData:
; Pewter Gym
	db 16,ONIX,RHYHORN,0
; Route 24/Route 25
	db 23,PONYTA,EKANS,0
; Route 24
	db 27,DITTO,0
; Route 6
	db 27,SQUIRTLE,0
	db 26,MACHOP,RATICATE,0
; Unused
	db 18,DIGLETT,DIGLETT,SANDSHREW,0
; Route 9
	db 28,GROWLITHE,CHARMANDER,0
	db 27,RATTATA,DIGLETT,EKANS,SANDSHREW,0
; Route 12
	db 34,NIDORAN_M,NIDORINO,0
JrTrainerFData:
; Cerulean Gym
	db 23,GOLDEEN,0
; Route 6
	db 26,RATTATA,PIKACHU,0
	db 26,PIDGEY,BULBASAUR,HORSEA,0
; Unused
	db 22,BULBASAUR,0
; Route 9
	db 29,ODDISH,BELLSPROUT,VENONAT,IVYSAUR,0
	db 31,MEOWTH,0
; Route 10
	db 32,PIKACHU,CLEFAIRY,0
	db 32,EEVEE,PIDGEOTTO,0
; Rock Tunnel B1F
	db 34,WIGGLYTUFF,PIDGEOTTO,MEOWTH,0
	db 34,ODDISH,BULBASAUR,0
; Celadon Gym
	db 35,BULBASAUR,IVYSAUR,0
; Route 13
	db 41,PIDGEOTTO,MEOWTH,RAPIDASH,PIKACHU,WIGGLYTUFF,0
	db 43,POLIWHIRL,DEWGONG,0
	db 40,PIDGEOTTO,MEOWTH,DUGTRIO,PRIMEAPE,0
	db 41,GOLDEEN,POLIWHIRL,SEADRA,0
; Route 20
	db 45,GOLDEEN,SEAKING,0
; Rock Tunnel 1F
	db 30,WARTORTLE,CLEFAIRY,0
	db 32,MEOWTH,GLOOM,CHARMELEON,0
	db 31,PIDGEY,POLIWHIRL,MAGMAR,BELLSPROUT,0
; Route 15
	db 41,GLOOM,SLOWBRO,GOLDUCK,0
	db 40,CHANSEY,RAICHU,0
	db 44,CLEFABLE,0
	db 40,BELLSPROUT,MACHOKE,TANGELA,0
; Route 20
	db 45,TENTACOOL,HORSEA,SEEL,0
PokemaniacData:
; Route 10
	db 45,RHYHORN,LICKITUNG,0
	db 31,CUBONE,SLOWPOKE,0
; Rock Tunnel B1F
	db 32,SLOWPOKE,PORYGON,SLOWPOKE,0
	db 32,CHARMANDER,CUBONE,0
	db 35,OMANYTE,0
; Victory Road 2F
	db 52,CHARMELEON,LAPRAS,LICKITUNG,OMASTAR,JOLTEON,0
; Rock Tunnel 1F
	db 33,CUBONE,SLOWPOKE,0
SuperNerdData:
; Mt. Moon 1F
	db 17,MAGNEMITE,ELECTABUZZ,0
; Mt. Moon B2F
	db 19,MAGMAR,DITTO,WARTORTLE,0
; Route 8
	db 28,VOLTORB,KOFFING,VOLTORB,MAGNEMITE,0
	db 29,GRIMER,MUK,GRIMER,0
	db 33,KABUTO,0
; Unused
	db 22,KOFFING,MAGNEMITE,WEEZING,0
	db 20,MAGNEMITE,MAGNEMITE,KOFFING,MAGNEMITE,0
	db 24,MAGNEMITE,VOLTORB,0
; Cinnabar Gym
	db 45,VULPIX,CHARMELEON,NINETALES,0
	db 44,PONYTA,CHARMANDER,VULPIX,GROWLITHE,0
	db 46,KABUTOPS,0
	db 45,GROWLITHE,VULPIX,0
HikerData:
; Mt. Moon 1F
	db 17,GEODUDE,RHYHORN,ONIX,0
; Route 25
	db 24,MACHOP,GEODUDE,0
	db 23,GEODUDE,RHYHORN,MACHOP,ONIX,0
	db 26,ONIX,0
; Route 9
	db 30,GEODUDE,ONIX,0
	db 29,GEODUDE,MACHOP,RHYHORN,0
; Route 10
	db 28,GEODUDE,ONIX,0
	db 27,ONIX,GRAVELER,0
; Rock Tunnel B1F
	db 33,RHYHORN,GEODUDE,GRAVELER,0
	db 34,GRAVELER,0
; Route 9/Rock Tunnel B1F
	db 29,MACHOKE,ONIX,0
; Rock Tunnel 1F
	db 32,GEODUDE,MACHOP,GEODUDE,ONIX,0
	db 32,ONIX,GEODUDE,CHARMELEON,0
	db 33,GEODUDE,GRAVELER,0
BikerData:
; Route 13
	db 42,KOFFING,VENONAT,KANGASKHAN,0
; Route 14
	db 42,MAGMAR,GRIMER,0
; Route 15
	db 43,KOFFING,EXEGGUTOR,WEEZING,RHYHORN,TANGELA,0
	db 43,KOFFING,GRIMER,WEEZING,0
; Route 16
	db 42,GRIMER,RAICHU,0
	db 44,WEEZING,0
	db 41,GRIMER,PARAS,DIGLETT,RHYDON,0
; Route 17
	; From https://www.smogon.com/smog/issue27/glitch:
	; 0E:5FC2 is offset of the ending 0 for this first Biker on Route 17.
	; BaseStats + (MonBaseStatsEnd - MonBaseStats) * (000 - 1) = $5FC2;
	; that's the formula from GetMonHeader for the base stats of mon #000.
	; (BaseStats = $43DE and BANK(BaseStats) = $0E.)
	; Finally, PokedexOrder lists 0 as the dex ID for every MissingNo.
	; The result is that this data gets interpreted as the base stats
	; for MissingNo: 0,33,MUK,0,29,VOLTORB,VOLTORB,0,...,28,GRIMER,GRIMER.
	db 39,WEEZING,RAPIDASH,WEEZING,0
	db 41,MUK,0
	db 42,VOLTORB,GROWLITHE,0
	db 41,WEEZING,MUK,0
	db 40,KOFFING,CHARMANDER,MEOWTH,ARBOK,GRIMER,0
; Route 14
	db 41,KOFFING,EKANS,GRIMER,VENOMOTH,0
	db 42,GRIMER,VENONAT,KOFFING,0
	db 43,KOFFING,MUK,0
BurglarData:
; Unused
	db 29,GROWLITHE,VULPIX,0
	db 33,GROWLITHE,0
	db 28,VULPIX,CHARMELEON,PONYTA,0
; Cinnabar Gym
	db 45,GROWLITHE,VULPIX,NINETALES,0
	db 49,RAPIDASH,0
	db 46,VULPIX,ARCANINE,0
; Mansion 2F
	db 46,MUK,CHARMELEON,0
; Mansion 3F
	db 48,NINETALES,0
; Mansion B1F
	db 46,GROWLITHE,PONYTA,0
EngineerData:
; Unused
	db 21,VOLTORB,MAGNEMITE,0
; Route 11
	db 28,PORYGON,0
	db 25,MAGNEMITE,VOLTORB,MAGNETON,0
Juggler1Data:
; none
FisherData:
; SS Anne 2F Rooms
	db 27,GOLDEEN,TENTACOOL,GYARADOS,0
; SS Anne B1F Rooms
	db 28,TENTACOOL,STARYU,SHELLDER,0
; Route 12
	db 33,GOLDEEN,POLIWHIRL,SEEL,0
	db 35,TENTACOOL,DRATINI,0
	db 35,GOLDUCK,0
	db 33,POLIWAG,SHELLDER,GYARADOS,HORSEA,0
; Route 21
	db 42,SEAKING,GOLDEEN,VAPOREON,HORSEA,0
	db 41,SHELLDER,CLOYSTER,0
	db 40,MAGIKARP,SEAKING,MAGIKARP,DRAGONAIR,MAGIKARP,GYARADOS,0
	db 43,SEAKING,BLASTOISE,0
; Route 12
	db 37,MAGIKARP,GYARADOS,0
SwimmerData:
; Cerulean Gym
	db 22,HORSEA,SHELLDER,0
; Route 19
	db 42,TENTACOOL,SHELLDER,0
	db 41,GOLDEEN,HORSEA,STARYU,0
	db 41,POLIWAG,POLIWRATH,0
	db 41,HORSEA,TENTACOOL,KRABBY,GOLDEEN,0
	db 42,GOLDEEN,SHELLDER,SEAKING,0
	db 42,SEADRA,DEWGONG,0
	db 40,TENTACOOL,SHELLDER,STARYU,HORSEA,TENTACRUEL,0
; Route 20
	db 43,SHELLDER,CLOYSTER,0
	db 45,STARYU,0
	db 43,HORSEA,SEEL,SEADRA,KRABBY,0
; Route 21
	db 41,SEADRA,TENTACRUEL,0
	db 42,STARMIE,0
	db 42,STARYU,WARTORTLE,0
	db 41,POLIWHIRL,TENTACOOL,SEADRA,0
CueBallData:
; Route 16
	db 39,MACHOKE,ONIX,RHYHORN,0
	db 39,PRIMEAPE,MACHOKE,0
	db 40,HITMONCHAN,0
; Route 17
	db 39,MANKEY,PRIMEAPE,0
	db 39,MACHOP,MACHOKE,0
	db 41,HITMONLEE,0
	db 38,MANKEY,PRIMEAPE,MACHOP,MACHOKE,0
	db 39,PRIMEAPE,MACHOKE,0
; Route 21
	db 34,TENTACOOL,VENONAT,TENTACRUEL,0
GamblerData:
; Route 11
	db 26,POLIWAG,HORSEA,0
	db 26,BELLSPROUT,ODDISH,0
	db 26,VOLTORB,MAGNEMITE,0
	db 26,GROWLITHE,VULPIX,0
; Route 8
	db 33,POLIWHIRL,KRABBY,PSYDUCK,0
; Unused
	db 22,ONIX,GEODUDE,GRAVELER,0
; Route 8
	db 33,GROWLITHE,VULPIX,0
BeautyData:
; Celadon Gym
	db 32,GLOOM,WEEPINBELL,TANGELA,IVYSAUR,0
	db 34,PARASECT,GLOOM,0
	db 35,EXEGGCUTE,0
; Route 13
	db 42,JYNX,PIKACHU,SANDSHREW,0
	db 43,CLEFAIRY,VAPOREON,0
; Route 20
	db 44,JYNX,0
	db 42,SHELLDER,SHELLDER,CLOYSTER,0
	db 43,POLIWAG,SEAKING,0
; Route 15
	db 41,PIDGEOTTO,WIGGLYTUFF,0
	db 41,BULBASAUR,IVYSAUR,0
; Unused
	db 37,WEEPINBELL,BELLSPROUT,GLOOM,0
; Route 19
	db 41,KRABBY,SEEL,SEAKING,GOLDEEN,POLIWAG,0
	db 42,GOLDEEN,SEAKING,0
	db 42,STARYU,SEEL,PSYDUCK,0
; Route 20
	db 44,SEADRA,HORSEA,GOLDEEN,0
PsychicData:
; Saffron Gym
	db 46,KADABRA,SLOWBRO,MR_MIME,KADABRA,0
	db 47,MR_MIME,KADABRA,0
	db 46,SLOWPOKE,EXEGGUTOR,SLOWBRO,0
	db 52,SLOWBRO,0
RockerData:
; Vermilion Gym
	db 32,VOLTORB,MAGNEMITE,PIKACHU,0
; Route 12
	db 39,HYPNO,ELECTRODE,0
JugglerData:
; Silph Co. 5F
	db 45,KADABRA,MR_MIME,0
; Victory Road 2F
	db 58,MR_MIME,HYPNO,KADABRA,ALAKAZAM,0
; Fuchsia Gym
	db 48,DROWZEE,MR_MIME,KADABRA,DROWZEE,0
	db 44,ALAKAZAM,HYPNO,0
; Victory Road 2F
	db 61,MR_MIME,0
; Unused
	db 33,HYPNO,0
; Fuchsia Gym
	db 49,HYPNO,0
	db 47,DROWZEE,KADABRA,0
TamerData:
; Fuchsia Gym
	db 47,HYPNO,ARBOK,0
	db 47,ARBOK,SANDSLASH,TAUROS,0
; Viridian Gym
	db 56,RHYDON,0
	db 54,ARBOK,TAUROS,0
; Victory Road 2F
	db 58,PERSIAN,GOLDUCK,0
; Unused
	db 42,RHYHORN,PRIMEAPE,ARBOK,TAUROS,0
BirdKeeperData:
; Route 13
	db 42,PIDGEOT,FARFETCHD,0
	db 41,FEAROW,PIDGEOTTO,DODRIO,PIDGEOT,FARFETCHD,0
	db 41,PIDGEY,PIDGEOTTO,SPEAROW,FEAROW,0
; Route 14
	db 43,FARFETCHD,0
	db 42,SPEAROW,FEAROW,0
; Route 15
	db 42,PIDGEOTTO,FARFETCHD,DODUO,SPEAROW,0
	db 42,DODRIO,PIDGEOTTO,FEAROW,0
; Route 18
	db 42,SPEAROW,FEAROW,0
	db 44,DODRIO,0
	db 41,DODUO,FARFETCHD,FEAROW,PIDGEOTTO,0
; Route 20
	db 46,FEAROW,DODRIO,PIDGEOT,0
; Unused
	db 39,PIDGEOTTO,PIDGEOTTO,PIDGEY,PIDGEOTTO,0
	db 42,FARFETCHD,FEAROW,0
; Route 14
	db 42,PIDGEOT,DODRIO,FEAROW,0
	db 41,PIDGEOT,GOLBAT,FARFETCHD,FEAROW,0
	db 43,PIDGEOTTO,FEAROW,0
	db 41,FARFETCHD,DODRIO,PIDGEOTTO,0
BlackbeltData:
; Fighting Dojo
	db 44,HITMONLEE,HITMONCHAN,0
	db 40,MACHOP,MANKEY,PRIMEAPE,0
	db 41,MANKEY,MACHOKE,0
	db 43,PRIMEAPE,0
	db 40,MACHOP,PRIMEAPE,MACHOKE,0
; Viridian Gym
	db 49,MAROWAK,MACHOKE,0
	db 51,MACHAMP,0
	db 49,MACHOKE,GRAVELER,ONIX,0
; Victory Road 2F
	db 53,MACHOP,HITMONCHAN,MACHAMP,0
Green1Data:
	db 5,SQUIRTLE,0
	db 5,BULBASAUR,0
	db 5,CHARMANDER,0
; Route 22
	db $FF,9,NIDORAN_M,9,SQUIRTLE,0
	db $FF,9,NIDORAN_M,9,BULBASAUR,0
	db $FF,9,NIDORAN_M,9,CHARMANDER,0
; Cerulean City
	db $FF,23,NIDORINO,20,KADABRA,24,EEVEE,25,SQUIRTLE,0
	db $FF,23,NIDORINO,20,KADABRA,24,EEVEE,25,BULBASAUR,0
	db $FF,23,NIDORINO,20,KADABRA,24,EEVEE,25,CHARMANDER,0
ProfOakData:
; Unused
	db $FF,68,TAUROS,69,EXEGGUTOR,70,ARCANINE,71,BLASTOISE,72,RAICHU,73,GYARADOS,0
	db $FF,68,TAUROS,69,EXEGGUTOR,70,ARCANINE,71,VENUSAUR,72,RAICHU,73,GYARADOS,0
	db $FF,68,TAUROS,69,EXEGGUTOR,70,ARCANINE,71,CHARIZARD,72,RAICHU,73,GYARADOS,0
ChiefData:
; none
ScientistData:
; Unused
	db 38,KOFFING,VOLTORB,0
; Silph Co. 2F
	db 41,GRIMER,WEEZING,KOFFING,GOLBAT,0
	db 42,MAGNEMITE,VOLTORB,MAGNETON,0
; Silph Co. 3F/Mansion 1F
	db 42,ELECTRODE,WEEZING,0
; Silph Co. 4F
	db 44,ELECTABUZZ,0
; Silph Co. 5F
	db 43,MAGNETON,KOFFING,WEEZING,DITTO,0
; Silph Co. 6F
	db 42,VOLTORB,KOFFING,MAGNETON,DITTO,GRIMER,0
; Silph Co. 7F
	db 45,ELECTRODE,MUK,0
; Silph Co. 8F
	db 45,GRIMER,ELECTRODE,0
; Silph Co. 9F
	db 45,VOLTORB,KOFFING,MAGNETON,0
; Silph Co. 10F
	db 46,MAGNEMITE,PINSIR,0
; Mansion 3F
	db 50,RAICHU,MAGNETON,VOLTORB,0
; Mansion B1F
	db 51,PORYGON,ELECTRODE,0
GiovanniData:
; Rocket Hideout B4F
	db $FF,37,ONIX,35,RHYHORN,39,KANGASKHAN,0
; Silph Co. 11F
	db $FF,47,NIDORINO,48,KANGASKHAN,48,RHYHORN,50,NIDOQUEEN,0
; Viridian Gym
	db $FF,59,ONIX,60,DUGTRIO,58,NIDOQUEEN,58,NIDOKING,62,RHYDON,0
; Rematch
	db $FF,70,SANDSLASH,71,NIDOKING,72,MAROWAK,73,RHYDON,74,DUGTRIO,75,PERSIAN,0
RocketData:
; Mt. Moon B2F
	db 19,RATTATA,PSYDUCK,0
	db 17,SANDSHREW,RATTATA,MANKEY,0
	db 18,POLIWAG,EKANS,0
	db 21,RATICATE,0
; Cerulean City
	db 23,MACHOP,NIDORINO,0
; Route 24
	db 27,BEEDRILL,VULPIX,0
; Game Corner
	db 36,DITTO,ODDISH,0
; Rocket Hideout B1F
	db 36,DROWZEE,MACHOP,0
	db 36,RATICATE,EKANS,0
	db 35,GRIMER,KOFFING,PONYTA,0
	db 34,RATICATE,KADABRA,GRIMER,SPEAROW,0
	db 36,SHELLDER,KOFFING,0
; Rocket Hideout B2F
	db 35,DITTO,KOFFING,GRIMER,PORYGON,RATICATE,0
; Rocket Hideout B3F
	db 33,CHARMELEON,RATICATE,DROWZEE,0
	db 33,MACHOP,GEODUDE,0
; Rocket Hideout B4F
	db 35,SANDSLASH,EKANS,DRAGONAIR,0
	db 35,ARBOK,SANDSHREW,SNORLAX,0
	db 37,MUK,FLAREON,0
; Pokémon Tower 7F
	db 40,KADABRA,GOLBAT,FEAROW,0
	db 41,KOFFING,JYNX,0
	db 40,GOLBAT,MR_MIME,RATICATE,PINSIR,0
; Unused
	db 26,DROWZEE,KOFFING,0
; Silph Co. 2F
	db 40,CUBONE,ZUBAT,0
	db 41,GOLBAT,PARAS,STARMIE,RATICATE,MEOWTH,0
; Silph Co. 3F
	db 42,RATICATE,HYPNO,MAGMAR,0
; Silph Co. 4F
	db 41,MACHOP,DROWZEE,0
	db 42,LAPRAS,ZUBAT,CUBONE,0
; Silph Co. 5F
	db 42,CLEFABLE,0
	db 42,WIGGLYTUFF,0
; Silph Co. 6F
	db 41,MACHOP,MACHOKE,0
	db 42,ZUBAT,VULPIX,GOLBAT,0
; Silph Co. 7F
	db 41,HITMONLEE,ARBOK,EXEGGUTOR,GOLBAT,0
	db 43,CUBONE,JYNX,0
	db 42,KANGASKHAN,SANDSLASH,0
; Silph Co. 8F
	db 40,RATICATE,CHANSEY,GOLBAT,CUBONE,0
	db 41,WEEZING,GOLBAT,PINSIR,0
; Silph Co. 9F
	db 43,KRABBY,GRIMER,CLOYSTER,0
	db 42,HAUNTER,MUK,HYPNO,0
; Silph Co. 10F
	db 46,SCYTHER,SANDSLASH
; Silph Co. 11F
	db 42,HAUNTER,PORYGON,ZUBAT,DROWZEE,EKANS,0
	db 44,TAUROS,DROWZEE,MAROWAK,0
CooltrainerMData:
; Viridian Gym
	db 53,TAUROS,NIDOKING,0
; Victory Road 3F
	db 53,EXEGGUTOR,CLOYSTER,ARCANINE,0
	db 54,KINGLER,TENTACRUEL,BLASTOISE,0
; Unused
	db 45,KINGLER,STARMIE,0
; Victory Road 1F
	db 52,IVYSAUR,WARTORTLE,CHARMELEON,CHARIZARD,0
; Unused
	db 44,IVYSAUR,WARTORTLE,CHARMELEON,0
	db 49,NIDOKING,0
	db 44,KINGLER,CLOYSTER,0
; Viridian Gym
	db 51,SANDSLASH,DUGTRIO,0
	db 55,RHYHORN,0
CooltrainerFData:
; Celadon Gym
	db 35,WEEPINBELL,GLOOM,IVYSAUR,0
; Victory Road 3F
	db 54,POLIWRATH,PRIMEAPE,VICTREEBEL,0
	db 55,PARASECT,DEWGONG,CHANSEY,0
; Unused
	db 46,VILEPLUME,BUTTERFREE,0
; Victory Road 1F
	db 54,VENUSAUR,FLAREON,0
; Unused
	db 45,IVYSAUR,VENUSAUR,0
	db 45,NIDORINA,NIDOQUEEN,0
	db 43,PERSIAN,NINETALES,RAICHU,0
BrunoData:
	db $FF,59,ONIX,62,HITMONCHAN,62,HITMONLEE,61,GOLEM,65,MACHAMP,0
BrockData:
	db $FF,15,GEODUDE,19,KABUTO,0
	db $FF,70,OMASTAR,71,GOLEM,72,RHYDON,73,ONIX,74,KABUTOPS,75,AERODACTYL,0
MistyData:
	db $FF,20,SEEL,23,PSYDUCK,24,STARMIE,0
	db $FF,70,GOLDUCK,71,STARMIE,72,KINGLER,73,LAPRAS,74,VAPOREON,75,POLIWRATH,0
LtSurgeData:
	db $FF,31,JOLTEON,32,RAICHU,34,ELECTABUZZ,0
	db $FF,70,ELECTRODE,71,RAICHU,72,ELECTABUZZ,73,JOLTEON,74,MAGNETON,75,RAICHU,0
ErikaData:
	db $FF,35,VICTREEBEL,34,TANGELA,37,VILEPLUME,0
	db $FF,70,VILEPLUME,71,PARASECT,72,VICTREEBEL,73,EXEGGUTOR,74,TANGELA,75,VENUSAUR,0
KogaData:
	db $FF,49,ARBOK,52,MUK,51,GOLBAT,52,WEEZING,0
	db $FF,70,GOLBAT,71,WEEZING,72,MUK,73,VENOMOTH,74,ARBOK,75,NIDOKING,0
BlaineData:
	db $FF,58,RAPIDASH,58,ARCANINE,59,CHARIZARD,60,MAGMAR,0
	db $FF,70,RAPIDASH,71,ARCANINE,72,NINETALES,73,MAGMAR,74,FLAREON,75,CHARIZARD,0
SabrinaData:
	db $FF,52,HYPNO,53,MR_MIME,52,VENOMOTH,54,ALAKAZAM,0
	db $FF,70,SLOWBRO,71,HYPNO,72,ALAKAZAM,73,MR_MIME,74,JYNX,75,ALAKAZAM,0
GentlemanData:
; SS Anne 1F Rooms
	db 28,GROWLITHE,PSYDUCK,0
	db 28,NIDORAN_M,NIDORAN_F,0
; SS Anne 2F Rooms/Vermilion Gym
	db 29,PIKACHU,0
; Unused
	db 48,PRIMEAPE,0
; SS Anne 2F Rooms
	db 29,GROWLITHE,PONYTA,0
Green2Data:
; SS Anne 2F
	db $FF,29,EEVEE,30,GROWLITHE,30,KADABRA,29,WARTORTLE,0
	db $FF,29,EEVEE,26,GYARADOS,30,KADABRA,29,IVYSAUR,0
	db $FF,29,EEVEE,30,EXEGGCUTE,30,KADABRA,29,CHARMELEON,0
; Pokémon Tower 2F
	db $FF,38,GROWLITHE,39,PIDGEOTTO,37,JOLTEON,38,KADABRA,38,WARTORTLE,0
	db $FF,34,GYARADOS,39,PIDGEOTTO,37,FLAREON,38,KADABRA,38,IVYSAUR,0
	db $FF,38,EXEGGCUTE,39,PIDGEOTTO,37,VAPOREON,38,KADABRA,38,CHARMELEON,0
; Silph Co. 7F
	db $FF,46,PIDGEOT,44,GROWLITHE,46,JOLTEON,45,ALAKAZAM,47,BLASTOISE,0
	db $FF,46,PIDGEOT,40,GYARADOS,46,FLAREON,45,ALAKAZAM,47,VENUSAUR,0
	db $FF,46,PIDGEOT,44,EXEGGCUTE,46,VAPOREON,45,ALAKAZAM,47,CHARIZARD,0
; Route 22
	db $FF,56,PIDGEOT,54,DITTO,55,ARCANINE,55,JOLTEON,58,ALAKAZAM,60,BLASTOISE,0
	db $FF,56,PIDGEOT,54,DITTO,55,GYARADOS,55,FLAREON,58,ALAKAZAM,60,VENUSAUR,0
	db $FF,56,PIDGEOT,54,DITTO,55,EXEGGUTOR,55,VAPOREON,58,ALAKAZAM,60,CHARIZARD,0
Green3Data:
	db $FF,63,ALAKAZAM,66,PIDGEOT,64,TAUROS,64,ARCANINE,67,JOLTEON,70,BLASTOISE,0
	db $FF,63,ALAKAZAM,66,PIDGEOT,64,TAUROS,64,GYARADOS,67,FLAREON,70,VENUSAUR,0
	db $FF,63,ALAKAZAM,66,PIDGEOT,64,TAUROS,64,EXEGGUTOR,67,VAPOREON,70,CHARIZARD,0
; Viridian Gym Rematch (new team 4)
    	db $FF,72,TAUROS,70,SCYTHER,74,MACHAMP,74,ARCANINE,77,JOLTEON,75,BLASTOISE,0
    	db $FF,72,TAUROS,70,SCYTHER,74,MACHAMP,74,GYARADOS,77,FLAREON,75,VENUSAUR,0
    	db $FF,72,TAUROS,70,SCYTHER,74,MACHAMP,74,EXEGGUTOR,77,VAPOREON,75,CHARIZARD,0
LoreleiData:
	db $FF,60,DEWGONG,59,CLOYSTER,60,SLOWBRO,62,JYNX,62,LAPRAS,0
ChannelerData:
; Unused
	db 22,GASTLY,0
	db 24,GASTLY,0
	db 23,GASTLY,GASTLY,0
	db 24,GASTLY,0
; Pokémon Tower 3F
	db 36,GASTLY,0
	db 37,GASTLY,0
; Unused
	db 24,HAUNTER,0
; Pokémon Tower 3F
	db 37,HAUNTER,0
; Pokémon Tower 4F
	db 37,HAUNTER,0
	db 36,GASTLY,GASTLY,0
; Unused
	db 24,GASTLY,0
; Pokémon Tower 4F
	db 37,GASTLY,0
; Unused
	db 24,GASTLY,0
; Pokémon Tower 5F
	db 37,HAUNTER,0
; Unused
	db 24,GASTLY,0
; Pokémon Tower 5F
	db 37,GASTLY,0
	db 38,GASTLY,0
	db 38,HAUNTER,0
; Pokémon Tower 6F
	db 37,GASTLY,HAUNTER,GASTLY,0
	db 39,GASTLY,0
	db 39,HAUNTER,0
; Saffron Gym
	db 46,GASTLY,HAUNTER,0
	db 47,HAUNTER,0
	db 46,GASTLY,GASTLY,HAUNTER,0
AgathaData:
	db $FF,63,GENGAR,63,GOLBAT,65,HAUNTER,62,ARBOK,67,GENGAR,0
LanceData:
	db $FF,63,GYARADOS,64,DRAGONAIR,64,CHARIZARD,66,AERODACTYL,67,DRAGONITE,0

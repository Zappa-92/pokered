PokemonMansionB1F_Script:
	call Mansion4Script_523cf
	call EnableAutoTextBoxDrawing
	ld hl, Mansion4TrainerHeader0
	ld de, PokemonMansionB1F_ScriptPointers
	ld a, [wPokemonMansionB1FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wPokemonMansionB1FCurScript], a
	ret

Mansion4Script_523cf:
	ld hl, wCurrentMapScriptFlags
	bit 5, [hl]
	res 5, [hl]
	ret z
	CheckEvent EVENT_MANSION_SWITCH_ON
	jr nz, .asm_523ff
	ld a, $e
	ld bc, $80d
	call Mansion2Script_5202f
	ld a, $e
	ld bc, $b06
	call Mansion2Script_5202f
	ld a, $5f
	ld bc, $304
	call Mansion2Script_5202f
	ld a, $54
	ld bc, $808
	call Mansion2Script_5202f
	ret
.asm_523ff
	ld a, $2d
	ld bc, $80d
	call Mansion2Script_5202f
	ld a, $5f
	ld bc, $b06
	call Mansion2Script_5202f
	ld a, $e
	ld bc, $304
	call Mansion2Script_5202f
	ld a, $e
	ld bc, $808
	call Mansion2Script_5202f
	ret

Mansion4Script_Switches:
	ld a, [wSpriteStateData1 + 9]
	cp SPRITE_FACING_UP
	ret nz
	xor a
	ld [hJoyHeld], a
	ld a, $9
	ld [hSpriteIndexOrTextID], a
	jp DisplayTextID

PokemonMansionB1F_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw MansionB1FMewBattle

PokemonMansionB1F_TextPointers:
	dw Mansion4Text1
	dw Mansion4Text2
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw PickUpItemText
	dw Mansion4Text7
	dw PickUpItemText
	dw Mansion3Text6
	dw MansionB1FMewShrineText
	dw PickUpItemText  ; DNA Codes

Mansion4TrainerHeader0:
	dbEventFlagBit EVENT_BEAT_MANSION_4_TRAINER_0
	db ($0 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_MANSION_4_TRAINER_0
	dw Mansion4BattleText1 ; TextBeforeBattle
	dw Mansion4AfterBattleText1 ; TextAfterBattle
	dw Mansion4EndBattleText1 ; TextEndBattle
	dw Mansion4EndBattleText1 ; TextEndBattle

Mansion4TrainerHeader1:
	dbEventFlagBit EVENT_BEAT_MANSION_4_TRAINER_1
	db ($3 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_MANSION_4_TRAINER_1
	dw Mansion4BattleText2 ; TextBeforeBattle
	dw Mansion4AfterBattleText2 ; TextAfterBattle
	dw Mansion4EndBattleText2 ; TextEndBattle
	dw Mansion4EndBattleText2 ; TextEndBattle

MewTrainerHeader:
    	dbEventFlagBit EVENT_BEAT_MEW
    	db ($0 << 4) ; view range
    	dwEventFlagAddress EVENT_BEAT_MEW
    	dw MewBattleText ; TextBeforeBattle
    	dw MewBattleText ; TextAfterBattle
    	dw MewBattleText ; TextEndBattle
    	dw MewBattleText ; TextEndBattle

	db $ff

Mansion4Text1:
	TX_ASM
	ld hl, Mansion4TrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

Mansion4Text2:
	TX_ASM
	ld hl, Mansion4TrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

Mansion4BattleText1:
	TX_FAR _Mansion4BattleText1
	db "@"

Mansion4EndBattleText1:
	TX_FAR _Mansion4EndBattleText1
	db "@"

Mansion4AfterBattleText1:
	TX_FAR _Mansion4AfterBattleText1
	db "@"

Mansion4BattleText2:
	TX_FAR _Mansion4BattleText2
	db "@"

Mansion4EndBattleText2:
	TX_FAR _Mansion4EndBattleText2
	db "@"

Mansion4AfterBattleText2:
	TX_FAR _Mansion4AfterBattleText2
	db "@"

Mansion4Text7:
	TX_FAR _Mansion4Text7
	db "@"

MansionB1FMewShrineText:
    TX_ASM
    ld a, ANCIENTFLUTE
    ld [wItemToRemove], a  ; Check for ANCIENT_FLUTE in bag
    predef ItemFinderLoopBag
    jr nc, .noFlute        ; Carry not set = not found
    CheckEvent EVENT_BEAT_MEW
    jr nz, .postMew
    ; With Ancient Flute in bag
    ld hl, ShrinePatternsText
    call PrintText
    ; Play Ancient Flute
    ld a, $ff
    call PlaySound
    ld a, SFX_POKEFLUTE
    ld c, BANK(SFX_Pokeflute)
    call PlayMusic
.musicWaitLoop
    ld a, [wChannelSoundIDs + Ch3]
    cp SFX_POKEFLUTE
    jr z, .musicWaitLoop
    call PlayDefaultMusic
    ; Spawn Mew with teleport effect
    ld a, HS_MANSION_B1F_MEW
    ld [wMissableObjectIndex], a
    predef ShowObject
    callba EnterMapAnim
    ld hl, MewAppearsText
    call PrintText
    ; Start Mew battle
    ld hl, MewTrainerHeader
    call TalkToTrainer
    ld a, 3
    ld [wPokemonMansionB1FCurScript], a
    ld [wCurMapScript], a
    jr .done
.noFlute
    	ld hl, ShrineNoFluteText
    	call PrintText
    	jr .done
.postMew
	ld hl, ShrineNoFluteText
    	call PrintText
    	jr .done
.done
    jp TextScriptEnd

MewBattleText:
    TX_FAR _MewBattleText
    TX_ASM
    ld a, MEW
    call PlayCry
    call WaitForSoundToFinish
    jp TextScriptEnd

ShrineNoFluteText:
    TX_FAR _ShrineNoFluteText
    db "@"

ShrinePatternsText:
    TX_FAR _ShrinePatternsText
    db "@"

MewAppearsText:
    TX_FAR _MewAppearsText
    db "@"

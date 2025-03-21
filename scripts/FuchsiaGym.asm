FuchsiaGym_Script:
	call FuchsiaGymScript_75453
	call EnableAutoTextBoxDrawing
	ld hl, FuchsiaGymTrainerHeader0
	ld de, FuchsiaGym_ScriptPointers
	ld a, [wFuchsiaGymCurScript]
	call ExecuteCurMapScriptInTable
	ld [wFuchsiaGymCurScript], a
	ret

FuchsiaGymScript_75453:
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	ret z
	ld hl, Gym5CityName
	ld de, Gym5LeaderName
	call LoadGymLeaderAndCityName
	ret

Gym5CityName:
	db "FUCHSIA CITY@"
Gym5LeaderName:
	db "KOGA@"

FuchsiaGymScript_75477:
	xor a
	ld [wJoyIgnore], a
	ld [wFuchsiaGymCurScript], a
	ld [wCurMapScript], a
	ret

FuchsiaGym_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw FuchsiaGymScript3
	dw FuchsiaGymKogaRematchPostBattle  ; New rematch script

FuchsiaGymScript3:
	ld a, [wIsInBattle]
	cp $ff
	jp z, FuchsiaGymScript_75477
	ld a, $f0
	ld [wJoyIgnore], a
FuchsiaGymScript3_75497:
	ld a, $9
	ld [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_KOGA
	lb bc, TM_06, 1
	call GiveItem
	jr nc, .BagFull
	ld a, $a
	ld [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_TM06
	jr .gymVictory
.BagFull
	ld a, $b
	ld [hSpriteIndexOrTextID], a
	call DisplayTextID
.gymVictory
	ld hl, wObtainedBadges
	set 4, [hl]
	ld hl, wBeatGymFlags
	set 4, [hl]

	; deactivate gym trainers
	SetEventRange EVENT_BEAT_FUCHSIA_GYM_TRAINER_0, EVENT_BEAT_FUCHSIA_GYM_TRAINER_5

	jp FuchsiaGymScript_75477

FuchsiaGymKogaRematchPostBattle:  ; Handles rematch outcome
    	ld a, [wIsInBattle]
    	cp $ff
    	jp z, FuchsiaGymScript_75477  ; Reset on loss
    	SetEvent EVENT_BEAT_KOGA_REMATCH  ; Set on victory
    	xor a
    	ld [wJoyIgnore], a
    	ld [wFuchsiaGymCurScript], a
    	ld [wCurMapScript], a
    	ret

FuchsiaGym_TextPointers:
	dw FuchsiaGymText1
	dw FuchsiaGymText2
	dw FuchsiaGymText3
	dw FuchsiaGymText4
	dw FuchsiaGymText5
	dw FuchsiaGymText6
	dw FuchsiaGymText7
	dw FuchsiaGymText8
	dw FuchsiaGymText9
	dw FuchsiaGymText10
	dw FuchsiaGymText11

FuchsiaGymTrainerHeader0:
	dbEventFlagBit EVENT_BEAT_FUCHSIA_GYM_TRAINER_0
	db ($2 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_FUCHSIA_GYM_TRAINER_0
	dw FuchsiaGymBattleText1 ; TextBeforeBattle
	dw FuchsiaGymAfterBattleText1 ; TextAfterBattle
	dw FuchsiaGymEndBattleText1 ; TextEndBattle
	dw FuchsiaGymEndBattleText1 ; TextEndBattle

FuchsiaGymTrainerHeader1:
	dbEventFlagBit EVENT_BEAT_FUCHSIA_GYM_TRAINER_1
	db ($2 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_FUCHSIA_GYM_TRAINER_1
	dw FuchsiaGymBattleText2 ; TextBeforeBattle
	dw FuchsiaGymAfterBattleText2 ; TextAfterBattle
	dw FuchsiaGymEndBattleText2 ; TextEndBattle
	dw FuchsiaGymEndBattleText2 ; TextEndBattle

FuchsiaGymTrainerHeader2:
	dbEventFlagBit EVENT_BEAT_FUCHSIA_GYM_TRAINER_2
	db ($4 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_FUCHSIA_GYM_TRAINER_2
	dw FuchsiaGymBattleText3 ; TextBeforeBattle
	dw FuchsiaGymAfterBattleText3 ; TextAfterBattle
	dw FuchsiaGymEndBattleText3 ; TextEndBattle
	dw FuchsiaGymEndBattleText3 ; TextEndBattle

FuchsiaGymTrainerHeader3:
	dbEventFlagBit EVENT_BEAT_FUCHSIA_GYM_TRAINER_3
	db ($2 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_FUCHSIA_GYM_TRAINER_3
	dw FuchsiaGymBattleText4 ; TextBeforeBattle
	dw FuchsiaGymAfterBattleText4 ; TextAfterBattle
	dw FuchsiaGymEndBattleText4 ; TextEndBattle
	dw FuchsiaGymEndBattleText4 ; TextEndBattle

FuchsiaGymTrainerHeader4:
	dbEventFlagBit EVENT_BEAT_FUCHSIA_GYM_TRAINER_4
	db ($2 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_FUCHSIA_GYM_TRAINER_4
	dw FuchsiaGymBattleText5 ; TextBeforeBattle
	dw FuchsiaGymAfterBattleText5 ; TextAfterBattle
	dw FuchsiaGymEndBattleText5 ; TextEndBattle
	dw FuchsiaGymEndBattleText5 ; TextEndBattle

FuchsiaGymTrainerHeader5:
	dbEventFlagBit EVENT_BEAT_FUCHSIA_GYM_TRAINER_5
	db ($2 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_FUCHSIA_GYM_TRAINER_5
	dw FuchsiaGymBattleText6 ; TextBeforeBattle
	dw FuchsiaGymAfterBattleText6 ; TextAfterBattle
	dw FuchsiaGymEndBattleText6 ; TextEndBattle
	dw FuchsiaGymEndBattleText6 ; TextEndBattle

	db $ff

FuchsiaGymText1:
	TX_ASM
    	CheckEvent EVENT_BEAT_OAK
    	jr z, .originalBattle
    	CheckEvent EVENT_BEAT_KOGA_REMATCH
    	jr nz, .postRematch
    	ld hl, FuchsiaGymKogaRematchText
    	call PrintText
    	ld hl, wd72d
    	set 6, [hl]
    	set 7, [hl]
    	ld hl, FuchsiaGymKogaRematchLoseText
    	ld de, FuchsiaGymKogaRematchWinText
    	call SaveEndBattleTextPointers
    	ld a, OPP_KOGA  ; $0B
    	ld [wCurOpponent], a
    	ld a, $2  ; Rematch team
    	ld [wTrainerNo], a
    	xor a
    	ld [wGymLeaderNo], a
    	ld a, $4
    	ld [wFuchsiaGymCurScript], a
    	ld [wCurMapScript], a
    	jp TextScriptEnd
.originalBattle
	CheckEvent EVENT_BEAT_KOGA
	jr z, .beginBattle
	CheckEventReuseA EVENT_GOT_TM06
	jr nz, .afterVictory
	call z, FuchsiaGymScript3_75497
	call DisableWaitingAfterTextDisplay
	jr .done
.afterVictory
	ld hl, KogaExplainToxicText
	call PrintText
	jr .done
.beginBattle
	ld hl, KogaBeforeBattleText
	call PrintText
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	ld hl, KogaAfterBattleText
	ld de, KogaAfterBattleText
	call SaveEndBattleTextPointers
	ld a, [H_SPRITEINDEX]
	ld [wSpriteIndex], a
	call EngageMapTrainer
	call InitBattleEnemyParameters
	ld a, $5
	ld [wGymLeaderNo], a
	xor a
	ld [hJoyHeld], a
	ld a, $3
	ld [wFuchsiaGymCurScript], a
 	jr .done  ; Changed to jr for consistency
.postRematch
    	ld hl, FuchsiaGymKogaPostRematchText
    	call PrintText
.done
	jp TextScriptEnd

KogaBeforeBattleText:
	TX_FAR _KogaBeforeBattleText
	db "@"

KogaAfterBattleText:
	TX_FAR _KogaAfterBattleText
	db "@"

KogaExplainToxicText:
	TX_FAR _KogaExplainToxicText
	db "@"

FuchsiaGymText9:
	TX_FAR _FuchsiaGymText9
	db "@"

FuchsiaGymText10:
	TX_FAR _ReceivedTM06Text
	TX_SFX_KEY_ITEM

TM06ExplanationText:
	TX_FAR _TM06ExplanationText
	db "@"

FuchsiaGymText11:
	TX_FAR _TM06NoRoomText
	db "@"

FuchsiaGymKogaRematchText:
    	TX_FAR _FuchsiaGymKogaRematchText
    	db "@"

FuchsiaGymKogaRematchLoseText:
    	TX_FAR _FuchsiaGymKogaRematchLoseText
    	db "@"

FuchsiaGymKogaRematchWinText:
    	TX_FAR _FuchsiaGymKogaRematchWinText
    	db "@"

FuchsiaGymKogaPostRematchText:
    	TX_FAR _FuchsiaGymKogaPostRematchText
    	db "@"

FuchsiaGymText2:
	TX_ASM
	ld hl, FuchsiaGymTrainerHeader0
	call TalkToTrainer
	jp TextScriptEnd

FuchsiaGymBattleText1:
	TX_FAR _FuchsiaGymBattleText1
	db "@"

FuchsiaGymEndBattleText1:
	TX_FAR _FuchsiaGymEndBattleText1
	db "@"

FuchsiaGymAfterBattleText1:
	TX_FAR _FuchsiaGymAfterBattleText1
	db "@"

FuchsiaGymText3:
	TX_ASM
	ld hl, FuchsiaGymTrainerHeader1
	call TalkToTrainer
	jp TextScriptEnd

FuchsiaGymBattleText2:
	TX_FAR _FuchsiaGymBattleText2
	db "@"

FuchsiaGymEndBattleText2:
	TX_FAR _FuchsiaGymEndBattleText2
	db "@"

FuchsiaGymAfterBattleText2:
	TX_FAR _FuchsiaGymAfterBattleText2
	db "@"

FuchsiaGymText4:
	TX_ASM
	ld hl, FuchsiaGymTrainerHeader2
	call TalkToTrainer
	jp TextScriptEnd

FuchsiaGymBattleText3:
	TX_FAR _FuchsiaGymBattleText3
	db "@"

FuchsiaGymEndBattleText3:
	TX_FAR _FuchsiaGymEndBattleText3
	db "@"

FuchsiaGymAfterBattleText3:
	TX_FAR _FuchsiaGymAfterBattleText3
	db "@"

FuchsiaGymText5:
	TX_ASM
	ld hl, FuchsiaGymTrainerHeader3
	call TalkToTrainer
	jp TextScriptEnd

FuchsiaGymBattleText4:
	TX_FAR _FuchsiaGymBattleText4
	db "@"

FuchsiaGymEndBattleText4:
	TX_FAR _FuchsiaGymEndBattleText4
	db "@"

FuchsiaGymAfterBattleText4:
	TX_FAR _FuchsiaGymAfterBattleText4
	db "@"

FuchsiaGymText6:
	TX_ASM
	ld hl, FuchsiaGymTrainerHeader4
	call TalkToTrainer
	jp TextScriptEnd

FuchsiaGymBattleText5:
	TX_FAR _FuchsiaGymBattleText5
	db "@"

FuchsiaGymEndBattleText5:
	TX_FAR _FuchsiaGymEndBattleText5
	db "@"

FuchsiaGymAfterBattleText5:
	TX_FAR _FuchsiaGymAfterBattleText5
	db "@"

FuchsiaGymText7:
	TX_ASM
	ld hl, FuchsiaGymTrainerHeader5
	call TalkToTrainer
	jp TextScriptEnd

FuchsiaGymBattleText6:
	TX_FAR _FuchsiaGymBattleText6
	db "@"

FuchsiaGymEndBattleText6:
	TX_FAR _FuchsiaGymEndBattleText6
	db "@"

FuchsiaGymAfterBattleText6:
	TX_FAR _FuchsiaGymAfterBattleText6
	db "@"

FuchsiaGymText8:
	TX_ASM
	CheckEvent EVENT_BEAT_KOGA
	ld hl, FuchsiaGymText_75653
	jr nz, .asm_50671
	ld hl, FuchsiaGymText_7564e
.asm_50671
	call PrintText
	jp TextScriptEnd

FuchsiaGymText_7564e:
	TX_FAR _FuchsiaGymText_7564e
	db "@"

FuchsiaGymText_75653:
	TX_FAR _FuchsiaGymText_75653
	db "@"

PewterGym_Script:
	ld hl, wCurrentMapScriptFlags
	bit 6, [hl]
	res 6, [hl]
	call nz, PewterGymScript_5c3a4
	call EnableAutoTextBoxDrawing
	ld hl, PewterGymTrainerHeader0
	ld de, PewterGym_ScriptPointers
	ld a, [wPewterGymCurScript]
	call ExecuteCurMapScriptInTable
	ld [wPewterGymCurScript], a
	ret

PewterGymScript_5c3a4:
	ld hl, Gym1CityName
	ld de, Gym1LeaderName
	jp LoadGymLeaderAndCityName

Gym1CityName:
	db "PEWTER CITY@"

Gym1LeaderName:
	db "BROCK@"

PewterGymScript_5c3bf:
	xor a
	ld [wJoyIgnore], a
	ld [wPewterGymCurScript], a
	ld [wCurMapScript], a
	ret

PewterGym_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw PewterGymScript3
	dw PewterGymScript4

PewterGymScript3:
	ld a, [wIsInBattle]
	cp $ff
	jp z, PewterGymScript_5c3bf
	ld a, $f0
	ld [wJoyIgnore], a

PewterGymScript_5c3df:
	ld a, $4
	ld [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_BEAT_BROCK
	lb bc, TM_34, 1
	call GiveItem
	jr nc, .BagFull
	ld a, $5
	ld [hSpriteIndexOrTextID], a
	call DisplayTextID
	SetEvent EVENT_GOT_TM34
	jr .gymVictory
.BagFull
	ld a, $6
	ld [hSpriteIndexOrTextID], a
	call DisplayTextID
.gymVictory
	ld hl, wObtainedBadges
	set 0, [hl]
	ld hl, wBeatGymFlags
	set 0, [hl]

	ld a, HS_GYM_GUY
	ld [wMissableObjectIndex], a
	predef HideObject
	ld a, HS_ROUTE_22_RIVAL_1
	ld [wMissableObjectIndex], a
	predef HideObject

	ResetEvents EVENT_1ST_ROUTE22_RIVAL_BATTLE, EVENT_ROUTE22_RIVAL_WANTS_BATTLE

	; deactivate gym trainers
	SetEvent EVENT_BEAT_PEWTER_GYM_TRAINER_0

	jp PewterGymScript_5c3bf

PewterGymScript4:  ; New rematch post-battle script
    	ld a, [wIsInBattle]
    	cp $ff
    	jp z, PewterGymScript_5c3bf  ; Reset on loss
    	SetEvent EVENT_BEAT_BROCK_REMATCH  ; Set only on victory
    	xor a
    	ld [wJoyIgnore], a
    	ld [wPewterGymCurScript], a
    	ld [wCurMapScript], a
    	ret

PewterGym_TextPointers:
	dw PewterGymText1
	dw PewterGymText2
	dw PewterGymText3
	dw PewterGymText4
	dw PewterGymText5
	dw PewterGymText6

PewterGymTrainerHeader0:
	dbEventFlagBit EVENT_BEAT_PEWTER_GYM_TRAINER_0
	db ($5 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_PEWTER_GYM_TRAINER_0
	dw PewterGymBattleText1 ; TextBeforeBattle
	dw PewterGymAfterBattleText1 ; TextAfterBattle
	dw PewterGymEndBattleText1 ; TextEndBattle
	dw PewterGymEndBattleText1 ; TextEndBattle

	db $ff

; Modified Brock text pointer
PewterGymText1:
    	TX_ASM
    	CheckEvent EVENT_BEAT_OAK
    	jr z, .originalBattle
    	CheckEvent EVENT_BEAT_BROCK_REMATCH
    	jr nz, .postRematch
    	; Rematch logic
    	ld hl, PewterGymBrockRematchText
   	call PrintText
    	ld hl, wd72d
    	set 6, [hl]
    	set 7, [hl]
    	ld hl, PewterGymBrockRematchLoseText
    	ld de, PewterGymBrockRematchWinText
    	call SaveEndBattleTextPointers
    	ld a, OPP_BROCK
	ld [wCurOpponent], a
	ld a, $2  ; Rematch team
	ld [wTrainerNo], a
	xor a
	ld [wGymLeaderNo], a
	ld a, $4
	ld [wPewterGymCurScript], a
	ld [wCurMapScript], a
    	jp TextScriptEnd
.originalBattle
    	CheckEvent EVENT_BEAT_BROCK
    	jr z, .beginBattle
    	CheckEventReuseA EVENT_GOT_TM34
    	jr nz, .gymVictory
    	call z, PewterGymScript_5c3df
    	call DisableWaitingAfterTextDisplay
    	jr .done
.gymVictory
    	ld hl, PewterGymText_5c4a3
    	call PrintText
    	jr .done
.beginBattle
    	ld hl, PewterGymText_5c49e
    	call PrintText
    	ld hl, wd72d
    	set 6, [hl]
    	set 7, [hl]
    	ld hl, PewterGymText_5c4bc
    	ld de, PewterGymText_5c4bc
    	call SaveEndBattleTextPointers
    	ld a, [H_SPRITEINDEX]
    	ld [wSpriteIndex], a
    	call EngageMapTrainer
    	call InitBattleEnemyParameters
    	ld a, $1
    	ld [wGymLeaderNo], a
    	xor a
    	ld [hJoyHeld], a
    	ld a, $3
    	ld [wPewterGymCurScript], a
    	ld [wCurMapScript], a
 	jr .done  ; Changed to jr for consistency
.postRematch
    	ld hl, PewterGymBrockPostRematchText
    	call PrintText
.done
    	jp TextScriptEnd

PewterGymText_5c49e:
    TX_FAR _PewterGymText_5c49e
    db "@"

PewterGymText_5c4a3:
    TX_FAR _PewterGymText_5c4a3
    db "@"

PewterGymText4:
    TX_FAR _TM34PreReceiveText
    db "@"

PewterGymText5:
    TX_FAR _ReceivedTM34Text
    TX_SFX_ITEM_1
    TX_FAR _TM34ExplanationText
    db "@"

PewterGymText6:
    TX_FAR _TM34NoRoomText
    db "@"

PewterGymText_5c4bc:
    TX_FAR _PewterGymText_5c4bc
    TX_SFX_LEVEL_UP
    TX_FAR _PewterGymText_5c4c1
    db "@"

; Rematch text pointers
PewterGymBrockRematchText:
    TX_FAR _PewterGymBrockRematchText
    db "@"

PewterGymBrockRematchLoseText:
    TX_FAR _PewterGymBrockRematchLoseText
    db "@"

PewterGymBrockRematchWinText:
    TX_FAR _PewterGymBrockRematchWinText
    db "@"

PewterGymBrockPostRematchText:
    TX_FAR _PewterGymBrockPostRematchText
    db "@"

; Trainer text (unchanged)
PewterGymText2:
    TX_ASM
    ld hl, PewterGymTrainerHeader0
    call TalkToTrainer
    jp TextScriptEnd

PewterGymBattleText1:
    TX_FAR _PewterGymBattleText1
    db "@"

PewterGymEndBattleText1:
    TX_FAR _PewterGymEndBattleText1
    db "@"

PewterGymAfterBattleText1:
    TX_FAR _PewterGymAfterBattleText1
    db "@"

PewterGymText3:
	TX_ASM
	ld a, [wBeatGymFlags]
	bit 0, a
	jr nz, .asm_5c50c
	ld hl, PewterGymText_5c515
	call PrintText
	call YesNoChoice
	ld a, [wCurrentMenuItem]
	and a
	jr nz, .asm_5c4fe
	ld hl, PewterGymText_5c51a
	call PrintText
	jr .asm_5c504
.asm_5c4fe
	ld hl, PewterGymText_5c524
	call PrintText
.asm_5c504
	ld hl, PewterGymText_5c51f
	call PrintText
	jr .asm_5c512
.asm_5c50c
	ld hl, PewterGymText_5c529
	call PrintText
.asm_5c512
	jp TextScriptEnd

PewterGymText_5c515:
	TX_FAR _PewterGymText_5c515
	db "@"

PewterGymText_5c51a:
	TX_FAR _PewterGymText_5c51a
	db "@"

PewterGymText_5c51f:
	TX_FAR _PewterGymText_5c51f
	db "@"

PewterGymText_5c524:
	TX_FAR _PewterGymText_5c524
	db "@"

PewterGymText_5c529:
	TX_FAR _PewterGymText_5c529
	db "@"

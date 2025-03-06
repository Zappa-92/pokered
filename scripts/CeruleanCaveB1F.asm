CeruleanCaveB1F_Script:
	call EnableAutoTextBoxDrawing
	ld hl, MewtwoTrainerHeader
	ld de, CeruleanCaveB1F_ScriptPointers
	ld a, [wCeruleanCaveB1FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wCeruleanCaveB1FCurScript], a
	ret

CeruleanCaveB1F_ScriptPointers:
	dw CheckFightingMapTrainers
	dw DisplayEnemyTrainerTextAndStartBattle
	dw EndTrainerBattle
	dw CeruleanCaveB1FGiovanniBattle  ; New Giovanni script

CeruleanCaveB1FGiovanniBattle:
    ld a, [wIsInBattle]
    cp $ff
    jp z, CeruleanCaveB1FResetScript
    CheckEvent EVENT_BEAT_MEWTWO
    jr z, CeruleanCaveB1FResetScript  ; Mewtwo battle just ended
    ; If Mewtwo beaten, set Giovanni event
    SetEvent EVENT_BEAT_GIOVANNI_CAVE_REMATCH
    xor a
    ld [wJoyIgnore], a
    ld [wCeruleanCaveB1FCurScript], a
    ld [wCurMapScript], a
    ret

CeruleanCaveB1FResetScript:
    xor a
    ld [wJoyIgnore], a
    ld [wCeruleanCaveB1FCurScript], a
    ld [wCurMapScript], a
    ret

CeruleanCaveB1F_TextPointers:
	dw MewtwoText
	dw PickUpItemText
	dw PickUpItemText
    	dw CeruleanCaveGiovanniText  ; New text pointer

MewtwoTrainerHeader:
	dbEventFlagBit EVENT_BEAT_MEWTWO
	db ($0 << 4) ; trainer's view range
	dwEventFlagAddress EVENT_BEAT_MEWTWO
	dw MewtwoBattleText ; TextBeforeBattle
	dw MewtwoBattleText ; TextAfterBattle
	dw MewtwoBattleText ; TextEndBattle
	dw MewtwoBattleText ; TextEndBattle

	db $ff

MewtwoText:
    TX_ASM
    CheckEvent EVENT_BEAT_MEWTWO
    jr nz, .afterMewtwo
    ld hl, MewtwoTrainerHeader
    call TalkToTrainer
    jr .done
.afterMewtwo
    CheckEvent EVENT_BEAT_RIVAL_REMATCH
    jr z, .noGiovanni
    CheckEvent EVENT_BEAT_GIOVANNI_CAVE_REMATCH
    jr nz, .postGiovanni
    ; Hide Mewtwo, show Giovanni
    ld a, HS_CERULEAN_CAVE_B1F_MEWTWO
    ld [wMissableObjectIndex], a
    predef HideObject
    ld a, HS_CERULEAN_CAVE_B1F_GIOVANNI
    ld [wMissableObjectIndex], a
    predef ShowObject
    ; Giovanni battle
    ld hl, CeruleanCaveGiovanniBattleText
    call PrintText
    ld hl, CeruleanCaveGiovanniLoseText
    ld de, CeruleanCaveGiovanniWinText
    call SaveEndBattleTextPointers
    ld a, OPP_GIOVANNI  ; $0E
    ld [wCurOpponent], a
    ld a, $4  ; Team 4
    ld [wTrainerNo], a
    ld a, $3
    ld [wCeruleanCaveB1FCurScript], a
    ld [wCurMapScript], a
    jr .done
.postGiovanni
    ld hl, CeruleanCaveGiovanniPostText
    call PrintText
    jr .done
.noGiovanni
    ld hl, CeruleanCaveNoGiovanniText
    call PrintText
.done
    jp TextScriptEnd

MewtwoBattleText:
	TX_FAR _MewtwoBattleText
	TX_ASM
	ld a, MEWTWO
	call PlayCry
	call WaitForSoundToFinish
	jp TextScriptEnd

CeruleanCaveGiovanniBattleText:
    TX_FAR _CeruleanCaveGiovanniBattleText
    db "@"

CeruleanCaveGiovanniLoseText:
    TX_FAR _CeruleanCaveGiovanniLoseText
    db "@"

CeruleanCaveGiovanniWinText:
    TX_FAR _CeruleanCaveGiovanniWinText
    db "@"

CeruleanCaveGiovanniPostText:
    TX_FAR _CeruleanCaveGiovanniPostText
    db "@"

CeruleanCaveNoGiovanniText:
    TX_FAR _CeruleanCaveNoGiovanniText
    db "@"

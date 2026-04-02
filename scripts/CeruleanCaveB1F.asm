CeruleanCaveB1F_Script:
	call EnableAutoTextBoxDrawing
	ld hl, MewtwoTrainerHeader
	ld de, CeruleanCaveB1F_ScriptPointers
	ld a, [wCeruleanCaveB1FCurScript]
	call ExecuteCurMapScriptInTable
	ld [wCeruleanCaveB1FCurScript], a
 ; === Control de aparición de Giovanni ===
    CheckEvent EVENT_BEAT_RIVAL_REMATCH
    jr z, .hideGiovanni
    ld a, HS_CERULEAN_CAVE_B1F_GIOVANNI
    ld [wMissableObjectIndex], a
    predef ShowObject
    jr .doneGiovanni
.hideGiovanni
    ld a, HS_CERULEAN_CAVE_B1F_GIOVANNI
    ld [wMissableObjectIndex], a
    predef HideObject
.doneGiovanni
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
    ; If Mewtwo beaten, set Giovanni event and fade out post-item
    SetEvent EVENT_BEAT_GIOVANNI_CAVE_REMATCH
    CheckEvent EVENT_GOT_HIGGS_FOSSIL
    jr nz, .reset  ; Already faded
    ; Fade-out after giving Higgs Fossil
    call GBFadeOutToBlack
    ld a, HS_CERULEAN_CAVE_B1F_GIOVANNI  ; $D2
    ld [wMissableObjectIndex], a
    predef HideObject
    call UpdateSprites
    call Delay3
    call GBFadeInFromBlack
.reset
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
    ld hl, MewtwoTrainerHeader
    call TalkToTrainer
    jp TextScriptEnd

CeruleanCaveGiovanniText:
    TX_ASM
    CheckEvent EVENT_BEAT_RIVAL_REMATCH
    jr z, .noShow
    CheckEvent EVENT_BEAT_GIOVANNI_CAVE_REMATCH
    jr nz, .postBattle
    ; Chequear si tenés a Mewtwo
    ld a, MEWTWO
    callab IsPokemonInParty
    jr z, .noMewtwo
    ; Batalla
    ld hl, CeruleanCaveGiovanniBattleText
    call PrintText
    ld hl, CeruleanCaveGiovanniWinText
    ld de, CeruleanCaveGiovanniLoseText
    call SaveEndBattleTextPointers
    ld a, OPP_GIOVANNI
    ld [wCurOpponent], a
    ld a, $4
    ld [wTrainerNo], a
	ld hl, wd72d
	set 6, [hl]
	set 7, [hl]
	call EngageMapTrainer
	call InitBattleEnemyParameters
	ld a, $3
	ld [wCeruleanCaveB1FCurScript], a
	ld [wCurMapScript], a
    jr .done
.noMewtwo
    ld hl, CeruleanCaveGiovanniNoMewtwoText
    call PrintText
    jr .done
.postBattle
    CheckEvent EVENT_GOT_HIGGS_FOSSIL
    jr nz, .done
    ld hl, CeruleanCaveGiovanniPostFadeText
    call PrintText
    lb bc, HIGGS_FOSSIL, 1
    call GiveItem
    jr nc, .bagFull
    ld hl, ReceivedHiggsFossilText
    call PrintText
    SetEvent EVENT_GOT_HIGGS_FOSSIL
    jr .done
.bagFull
    ld hl, HiggsFossilNoRoomText
    call PrintText
    jr .done
.noShow
    ret
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

CeruleanCaveGiovanniNoMewtwoText:
    TX_FAR _CeruleanCaveGiovanniNoMewtwoText
    db "@"

CeruleanCaveGiovanniPostFadeText:
    TX_FAR _CeruleanCaveGiovanniPostFadeText
    db "@"

ReceivedHiggsFossilText:
    TX_FAR _ReceivedHiggsFossilText
    TX_SFX_ITEM_1
    db "@"

HiggsFossilNoRoomText:
    TX_FAR _HiggsFossilNoRoomText
    db "@"

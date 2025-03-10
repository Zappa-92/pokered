MrFujisHouse_Script:
	call EnableAutoTextBoxDrawing
	ret

MrFujisHouse_TextPointers:
	dw LavenderHouse1Text1
	dw LavenderHouse1Text2
	dw LavenderHouse1Text3
	dw LavenderHouse1Text4
	dw LavenderHouse1Text5
	dw LavenderHouse1Text6

LavenderHouse1Text1:
	TX_ASM
	CheckEvent EVENT_RESCUED_MR_FUJI
	jr nz, .asm_72e5d
	ld hl, LavenderHouse1Text_1d8d1
	call PrintText
	jr .asm_6957f
.asm_72e5d
	ld hl, LavenderHouse1Text_1d8d6
	call PrintText
.asm_6957f
	jp TextScriptEnd

LavenderHouse1Text_1d8d1:
	TX_FAR _LavenderHouse1Text_1d8d1
	db "@"

LavenderHouse1Text_1d8d6:
	TX_FAR _LavenderHouse1Text_1d8d6
	db "@"

LavenderHouse1Text2:
	TX_ASM
	CheckEvent EVENT_RESCUED_MR_FUJI
	jr nz, .asm_06470
	ld hl, LavenderHouse1Text_1d8f4
	call PrintText
	jr .asm_3d208
.asm_06470
	ld hl, LavenderHouse1Text_1d8f9
	call PrintText
.asm_3d208
	jp TextScriptEnd

LavenderHouse1Text_1d8f4:
	TX_FAR _LavenderHouse1Text_1d8f4
	db "@"

LavenderHouse1Text_1d8f9:
	TX_FAR _LavenderHouse1Text_1d8f9
	db "@"

LavenderHouse1Text3:
	TX_FAR _LavenderHouse1Text3
	TX_ASM
	ld a, PSYDUCK
	call PlayCry
	jp TextScriptEnd

LavenderHouse1Text4:
	TX_FAR _LavenderHouse1Text4
	TX_ASM
	ld a, NIDORINO
	call PlayCry
	jp TextScriptEnd

LavenderHouse1Text5:
    TX_ASM
    CheckEvent EVENT_RESCUED_MR_FUJI
    jr nz, .rescued
    ld hl, FujiNotHereText
    call PrintText
    jr .done
.rescued
    CheckEvent EVENT_GOT_POKE_FLUTE
    jr nz, .postFlute
    ld hl, LavenderHouse1Text_1d94c
    call PrintText
    lb bc, POKE_FLUTE, 1
    call GiveItem
    jr nc, .BagFullPokeFlute
    ld hl, ReceivedFluteText
    call PrintText
    SetEvent EVENT_GOT_POKE_FLUTE
    jr .postFlute
.BagFullPokeFlute
    ld hl, FluteNoRoomText
    call PrintText
    jr .postFlute
.postFlute
    CheckEvent EVENT_BEAT_GIOVANNI_CAVE_REMATCH
    jr z, .preGiovanni
    CheckEvent EVENT_GOT_ANCIENT_FLUTE
    jr nz, .postAncient
    ld hl, FujiAncientFluteText
    call PrintText
    lb bc, ANCIENT_FLUTE, 1
    call GiveItem
    jr nc, .BagFullAncient
    ld hl, ReceivedAncientFluteText
    call PrintText
    SetEvent EVENT_GOT_ANCIENT_FLUTE
    jr .done
.BagFullAncient
    ld hl, AncientFluteNoRoomText
    call PrintText
    jr .done
.postAncient
    ld hl, FujiPostAncientText
    call PrintText
    jr .done
.preGiovanni
    ld hl, MrFujiAfterFluteText
    call PrintText
.done
    jp TextScriptEnd

LavenderHouse1Text_1d94c:
	TX_FAR _LavenderHouse1Text_1d94c
	db "@"

ReceivedFluteText:
	TX_FAR _ReceivedFluteText
	TX_SFX_KEY_ITEM
	TX_FAR _FluteExplanationText
	db "@"

FluteNoRoomText:
	TX_FAR _FluteNoRoomText
	db "@"

MrFujiAfterFluteText:
	TX_FAR _MrFujiAfterFluteText
	db "@"

FujiNotHereText:
    TX_FAR _FujiNotHereText
    db "@"

FujiAncientFluteText:
    TX_FAR _FujiAncientFluteText
    db "@"

ReceivedAncientFluteText:
    TX_FAR _ReceivedAncientFluteText
    TX_SFX_KEY_ITEM
    db "@"

AncientFluteNoRoomText:
    TX_FAR _AncientFluteNoRoomText
    db "@"

FujiPostAncientText:
    TX_FAR _FujiPostAncientText
    db "@"

LavenderHouse1Text6:
	TX_FAR _LavenderHouse1Text6
	db "@"

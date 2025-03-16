CinnabarLabFossilRoom_Script:
	call EnableAutoTextBoxDrawing
    	; Show Blaine post-Giovanni
    	CheckEvent EVENT_BEAT_GIOVANNI_CAVE_REMATCH
    	ret z
    	ld a, HS_CINNABAR_LAB_BLAINE  ; $C2
    	ld [wMissableObjectIndex], a
    	predef ShowObject
    	; Higgs revival steps
    	CheckEvent EVENT_GAVE_HIGGS_TO_BLAINE
    	jr z, .checkDNA
    	CheckEvent EVENT_HIGGS_STILL_REVIVING
    	jr z, .checkDNA
    	ld a, [wWalkCounter]
    	and a
    	ret z
    	dec a
    	ld [wWalkCounter], a
    	ret nz
    	ResetEvent EVENT_HIGGS_STILL_REVIVING
.checkDNA
    	; DNA revival steps
    	CheckEvent EVENT_GAVE_DNA_TO_BLAINE
    	ret z
    	CheckEvent EVENT_DNA_STILL_REVIVING
    	ret z
    	ld a, [wWalkCounter]
    	and a
    	ret z
    	dec a
    	ld [wWalkCounter], a
    	ret nz
    	ResetEvent EVENT_DNA_STILL_REVIVING
    	ret

CinnabarLabFossilRoom_TextPointers:
	dw Lab4Text1
	dw Lab4Text2
    	dw BlaineLabText

Lab4Script_GetFossilsInBag:
; construct a list of all fossils in the player's bag
	xor a
	ld [wFilteredBagItemsCount], a
	ld de, wFilteredBagItems
	ld hl, FossilsList
.loop
	ld a, [hli]
	and a
	jr z, .done
	push hl
	push de
	ld [wd11e], a
	ld b, a
	predef GetQuantityOfItemInBag
	pop de
	pop hl
	ld a, b
	and a
	jr z, .loop

	; A fossil's in the bag
	ld a, [wd11e]
	ld [de], a
	inc de
	push hl
	ld hl, wFilteredBagItemsCount
	inc [hl]
	pop hl
	jr .loop
.done
	ld a, $ff
	ld [de], a
	ret

FossilsList:
	db DOME_FOSSIL
	db HELIX_FOSSIL
	db OLD_AMBER
    	db HIGGS_FOSSIL  ; Added MEW fossil
	db $00

Lab4Text1:
	TX_ASM
	CheckEvent EVENT_GAVE_FOSSIL_TO_LAB
	jr nz, .asm_75d96
	ld hl, Lab4Text_75dc6
	call PrintText
	call Lab4Script_GetFossilsInBag
	ld a, [wFilteredBagItemsCount]
	and a
	jr z, .asm_75d8d
	callba GiveFossilToCinnabarLab
	jr .asm_75d93
.asm_75d8d
	ld hl, Lab4Text_75dcb
	call PrintText
.asm_75d93
	jp TextScriptEnd
.asm_75d96
	CheckEventAfterBranchReuseA EVENT_LAB_STILL_REVIVING_FOSSIL, EVENT_GAVE_FOSSIL_TO_LAB
	jr z, .asm_75da2
	ld hl, Lab4Text_75dd0
	call PrintText
	jr .asm_75d93
.asm_75da2
	call LoadFossilItemAndMonNameBank1D
	ld hl, Lab4Text_75dd5
	call PrintText
	SetEvent EVENT_LAB_HANDING_OVER_FOSSIL_MON
	ld a, [wFossilMon]
	ld b, a
	ld c, 35
	call GivePokemon
	jr nc, .asm_75d93
	ResetEvents EVENT_GAVE_FOSSIL_TO_LAB, EVENT_LAB_STILL_REVIVING_FOSSIL, EVENT_LAB_HANDING_OVER_FOSSIL_MON
	jr .asm_75d93

Lab4Text_75dc6:
	TX_FAR _Lab4Text_75dc6
	db "@"

Lab4Text_75dcb:
	TX_FAR _Lab4Text_75dcb
	db "@"

Lab4Text_75dd0:
	TX_FAR _Lab4Text_75dd0
	db "@"

Lab4Text_75dd5:
	TX_FAR _Lab4Text_75dd5
	db "@"

Lab4Text2:
	TX_ASM
	ld a, $3
	ld [wWhichTrade], a
	predef DoInGameTradeDialogue
	jp TextScriptEnd

BlaineLabText:
    TX_ASM
    CheckEvent EVENT_BEAT_GIOVANNI_CAVE_REMATCH
    jr z, .done
    CheckEvent EVENT_GAVE_DNA_TO_BLAINE
    jr nz, .dnaReviving
    CheckEvent EVENT_GAVE_HIGGS_TO_BLAINE
    jr nz, .higgsReviving
    ; Intro dialogue
    ld hl, BlaineLabIntroText
    call PrintText
    ld a, HIGGS_FOSSIL
    ld [wcf91], a
    call IsItemInBag
    jr z, .done           ; Changed to z (not found)
    ld hl, BlaineLabHiggsText
    call PrintText
    call BlaineLabScript_RemoveItem
    SetEvent EVENT_GAVE_HIGGS_TO_BLAINE
    ld a, 240  ; 4x normal fossil steps
    ld [wWalkCounter], a
    SetEvent EVENT_HIGGS_STILL_REVIVING
    jr .done
.higgsReviving
    CheckEvent EVENT_HIGGS_STILL_REVIVING
    jr nz, .wait
    ld hl, BlaineLabHiggsFailedText
    call PrintText
    ; Check DNA Codes after Higgs fails
    ld a, DNA_CODES
    ld [wcf91], a
    call IsItemInBag
    jr z, .done           ; Changed to z (not found)
    ld hl, BlaineLabDNAText
    call PrintText
    call BlaineLabScript_RemoveItem
    SetEvent EVENT_GAVE_DNA_TO_BLAINE
    ld a, 240  ; 4x steps
    ld [wWalkCounter], a
    SetEvent EVENT_DNA_STILL_REVIVING
    jr .done
.wait
    ld hl, BlaineLabWaitText
    call PrintText
    jr .done
.dnaReviving
    CheckEvent EVENT_DNA_STILL_REVIVING
    jr nz, .wait
    ld hl, BlaineLabMewText
    call PrintText
    lb bc, MEW, 30  ; Level 30 Mew
    call GivePokemon
    jr nc, .done
    ld hl, BlainePostMewText
    call PrintText
    ResetEvents EVENT_GAVE_DNA_TO_BLAINE, EVENT_DNA_STILL_REVIVING
.done
    jp TextScriptEnd

BlaineLabScript_RemoveItem:
    ld hl, wBagItems
    ld bc, $0000
.loop
    ld a, [hli]
    cp $ff
    ret z
    cp [wcf91]           ; Compare with item ID in wcf91
    jr z, .foundItem
    inc hl
    inc c
    jr .loop
.foundItem
    ld hl, wNumBagItems
    ld a, c
    ld [wWhichPokemon], a
    ld a, 1
    ld [wItemQuantity], a
    jp RemoveItemFromInventory

LoadFossilItemAndMonNameBank1D:
	jpba LoadFossilItemAndMonName

; Text Pointers
BlaineLabIntroText:
    TX_FAR _BlaineLabIntroText
    db "@"

BlaineLabHiggsText:
    TX_FAR _BlaineLabHiggsText
    db "@"

BlaineLabHiggsFailedText:
    TX_FAR _BlaineLabHiggsFailedText
    db "@"

BlaineLabDNAText:
    TX_FAR _BlaineLabDNAText
    db "@"

BlaineLabWaitText:
    TX_FAR _BlaineLabWaitText
    db "@"

BlaineLabMewText:
    TX_FAR _BlaineLabMewText
    db "@"

BlainePostMewText:
    TX_FAR _BlaineLabPostMewText
    db "@"

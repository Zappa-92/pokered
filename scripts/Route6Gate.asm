Route6Gate_Script:
	call EnableAutoTextBoxDrawing
	ld hl, Route6Gate_ScriptPointers
	ld a, [wRoute6GateCurScript]
	call CallFunctionInTable
	ret

Route6Gate_ScriptPointers:
	dw Route6GateScript0
	dw Route6GateScript1


Route6GateScript0:
	ld a, [wd728]
	bit 6, a
	ret nz                  ; Gate already open, exit
    	ld hl, CoordsData_1e08c
    	call ArePlayerCoordsInArray
    	ret nc                  ; Wrong position, exit
    	ld a, PLAYER_DIR_RIGHT
    	ld [wPlayerMovingDirection], a
    	xor a
    	ld [hJoyHeld], a
    	CheckEvent EVENT_GAVE_GUARD_DRINK  ; Track if drink was given
    	jr nz, .drinkAlreadyGiven
    	callba RemoveGuardDrink     ; Check for drink
    	ld a, [$ffdb]
    	and a
    	jr z, .noDrink                  ; No drink, deny
    	SetEvent EVENT_GAVE_GUARD_DRINK ; Mark drink as given
    	ld a, [wObtainedBadges]
    	bit 3, a
    	jr z, .firstDrinkNoBadge        ; Drink given, no badge   Drink + Badge on first try
	ld hl, wd728
	set 6, [hl]                     ; Open gate
	ld a, $3                        ; "Thanks!" + "Glug glug... you can go"
	ld [hSpriteIndexOrTextID], a
	jp DisplayTextID
.noDrink:
	ld a, $2                        ; "I'm thirsty... trouble ahead!"
	ld [hSpriteIndexOrTextID], a
	call DisplayTextID
	call Route6GateScript_1e0a1     ; Move guard
	ld a, $1
	ld [wRoute6GateCurScript], a
	ret
.firstDrinkNoBadge:
    	ld a, $5                        ; "Glug glug... Team Rocket!"
    	ld [hSpriteIndexOrTextID], a
    	call DisplayTextID
    	call Route6GateScript_1e0a1
    	ld a, $1
    	ld [wRoute6GateCurScript], a
    	ret
.drinkAlreadyGiven:
   	ld a, [wObtainedBadges]
    	bit 3, a
    	jr z, .noBadgeAfterDrink        ; Drink given, still no badge   Drink given previously, now has badge
    	ld hl, wd728
    	set 6, [hl]                     ; Open gate
    	ld a, $4                        ; "Thanks for drinks... keep on!"
    	ld [hSpriteIndexOrTextID], a    ; Skip "Glug glug" since already drank
    	jp DisplayTextID
.noBadgeAfterDrink:
    	ld a, $6                        ; "Thanks, but Team Rocket..."
    	ld [hSpriteIndexOrTextID], a
    	call DisplayTextID
    	call Route6GateScript_1e0a1
    	ld a, $1
    	ld [wRoute6GateCurScript], a
    	ret

CoordsData_1e08c:
	db $02,$03
	db $02,$04,$FF

Route6GateScript1:
	ld a, [wSimulatedJoypadStatesIndex]
	and a
	ret nz
	call Delay3
	xor a
	ld [wJoyIgnore], a
	ld [wRoute6GateCurScript], a
	ret

Route6GateScript_1e0a1:
	ld hl, wd730
	set 7, [hl]
	ld a, $80
	ld [wSimulatedJoypadStatesEnd], a
	ld a, $1
	ld [wSimulatedJoypadStatesIndex], a
	xor a
	ld [wSpriteStateData2 + $06], a
	ld [wOverrideSimulatedJoypadStatesMask], a
	ret

Route6Gate_TextPointers:
	dw _SaffronGateText_1dfe7            ; ID 1 (unused in script, but kept for safety)
	dw _SaffronGateText_1dfe7            ; ID 2 ("I'm thirsty... trouble ahead!")
    	dw _SaffronGateText_8aaa9            ; ID 3 ("Thanks!" + "Glug glug...")
    	dw _SaffronGateText_1dff6            ; ID 4 ("Thanks... keep on!")
    	dw _SaffronGateText_FirstDrinkNoBadge ; ID 5 ("Glug glug... Team Rocket!")
    	dw _SaffronGateText_NoBadgeAfterDrink ; ID 6 ("Thanks, but Team Rocket...")

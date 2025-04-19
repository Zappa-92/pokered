SECTION "Adjust Damage", ROMX, BANK[$10]

; function to adjust the base damage of an attack to account for type effectiveness
AdjustDamageForMoveType:
; values for player turn
	ld hl, wBattleMonType
	ld a, [hli]
	ld b, a    ; b = type 1 of attacker
	ld c, [hl] ; c = type 2 of attacker
	ld hl, wEnemyMonType
	ld a, [hli]
	ld d, a    ; d = type 1 of defender
	ld e, [hl] ; e = type 2 of defender
	ld a, [wPlayerMoveType]
	ld [wMoveType], a
	ld a, [H_WHOSETURN]
	and a
	jr z, .next
; values for enemy turn
	ld hl, wEnemyMonType
	ld a, [hli]
	ld b, a    ; b = type 1 of attacker
	ld c, [hl] ; c = type 2 of attacker
	ld hl, wBattleMonType
	ld a, [hli]
	ld d, a    ; d = type 1 of defender
	ld e, [hl] ; e = type 2 of defender
	ld a, [wEnemyMoveType]
	ld [wMoveType], a
.next
	ld a, [wMoveType]
	cp b ; does the move type match type 1 of the attacker?
	jr z, .sameTypeAttackBonus
	cp c ; does the move type match type 2 of the attacker?
	jr z, .sameTypeAttackBonus
	jr .skipSameTypeAttackBonus
.sameTypeAttackBonus
; if the move type matches one of the attacker's types
	ld hl, wDamage + 1
	ld a, [hld]
	ld h, [hl]
	ld l, a    ; hl = damage
	ld b, h
	ld c, l    ; bc = damage
	srl b
	srl b
	rr c   	   ; bc = floor(0.5 * damage)
	add hl, bc ; hl = floor(1.5 * damage)
; store damage
	ld a, h
	ld [wDamage], a
	ld a, l
	ld [wDamage + 1], a
	ld hl, wDamageMultipliers
	set 7, [hl]
.skipSameTypeAttackBonus
	ld a, $0A
    	ld [wDamageMultipliers], a
	ld a, [wMoveType]
	ld b, a
	ld hl, TypeEffects
.loop
	ld a, [hli] ; a = "attacking type" of the current type pair
	cp $ff
	jr z, .done
	cp b ; does move type match "attacking type"?
	jr nz, .nextTypePair
	ld a, [hl] ; a = "defending type" of the current type pair
	cp d ; does type 1 of defender match "defending type"?
	jr z, .matchingPairFound
	cp e ; does type 2 of defender match "defending type"?
	jr z, .matchingPairFound
	jr .nextTypePair
.matchingPairFound
; if the move type matches the "attacking type" and one of the defender's types matches the "defending type"
	push hl
	push bc
	inc hl
ld a, [hl]  ; Multiplier ($0F, $05, $00)
    ld [H_MULTIPLIER], a
    cp $00
    jr z, .typeImmunity
    push de
    ld hl, wDamageMultipliers
    ld a, [hl]
    ld [H_MULTIPLICAND + 2], a
    xor a
    ld [H_MULTIPLICAND], a
    ld [H_MULTIPLICAND + 1], a
    call Multiply
    ld a, 10
    ld [H_DIVISOR], a
    ld b, 4
    call Divide
    ld a, [H_QUOTIENT + 3]
    ld [wDamageMultipliers], a
    pop de
    ld a, [H_MULTIPLIER]
    xor a
    ld [H_MULTIPLICAND], a
    ld hl, wDamage
    ld a, [hli]
    ld [H_MULTIPLICAND + 1], a
    ld a, [hld]
    ld [H_MULTIPLICAND + 2], a
    call Multiply
    ld a, 10
    ld [H_DIVISOR], a
    ld b, $04
    call Divide
    ld a, [H_QUOTIENT + 2]
    ld [hli], a
    ld b, a
    ld a, [H_QUOTIENT + 3]
    ld [hl], a
    or b
    jr nz, .skipTypeImmunity
.typeImmunity
    ld a, $0A
    ld [wDamageMultipliers], a
	inc a
	ld [wMoveMissed], a
.skipTypeImmunity
	pop bc
	pop hl
.nextTypePair
	inc hl
	inc hl
	jp .loop
.done
	ret

CalculateRageDamage:
    ld a, [H_WHOSETURN]
    and a
    ld hl, wPlayerBattleStatus2
    jr z, .playerRage
    ld hl, wEnemyBattleStatus2
.playerRage
    bit USING_RAGE, [hl]
    ret z  ; Return if not using Rage
    ld a, [wRageCounter]
    and a
    ret z  ; Return if counter is 0
    dec a  ; Number of boosts (counter - 1)
    ret z  ; Return if no boosts
    ld b, a  ; Store boosts in b
    ld a, [wDamage + 1]  ; Low byte of damage
    ld c, a  ; Save original damage
    ld a, b
    add a  ; Multiply counter by 2
    add a  ; Multiply by 4
    add a  ; Multiply by 8
    add b  ; Multiply by 9
    add b  ; Multiply by 10
    add c  ; Add to original damage
    ld [wDamage + 1], a  ; Store low byte
    ld a, [wDamage]  ; High byte
    adc 0  ; Add carry
    ld [wDamage], a
    ; Cap at 999
    cp 999 / $100
    jr c, .noCap
    jr nz, .capDamage
    ld a, [wDamage + 1]
    cp 999 % $100
    jr c, .noCap
.capDamage
    ld a, 999 / $100
    ld [wDamage], a
    ld a, 999 % $100
    ld [wDamage + 1], a
.noCap
    ret

CalculateDamage:
; input:
;   b: attack
;   c: opponent defense
;   d: base power
;   e: level

    ld a, [H_WHOSETURN] ; whose turn?
    and a
    ld a, [wPlayerMoveEffect]
    jr z, .effect
    ld a, [wEnemyMoveEffect]
.effect

; EXPLODE_EFFECT halves defense.
    cp EXPLODE_EFFECT
    jr nz, .ok
    srl c
    jr nz, .ok
    inc c ; ...with a minimum value of 1 (used as a divisor later on)
.ok

; Multi-hit attacks may or may not have 0 bp.
    cp TWO_TO_FIVE_ATTACKS_EFFECT
    jr z, .skipbp
    cp $1e
    jr z, .skipbp

; Calculate OHKO damage based on remaining HP.
    cp OHKO_EFFECT
    jp z, JumpToOHKOMoveEffect

; Don't calculate damage for moves that don't do any.
    ld a, d ; base power
    and a
    ret z
.skipbp

    xor a
    ld hl, H_DIVIDEND
    ldi [hl], a
    ldi [hl], a
    ld [hl], a

; Multiply level by 2
    ld a, e ; level
    add a
    jr nc, .nc
    push af
    ld a, 1
    ld [hl], a
    pop af
.nc
    inc hl
    ldi [hl], a

; Divide by 5
    ld a, 5
    ldd [hl], a
    push bc
    ld b, 4
    call Divide
    pop bc

; Add 2
    inc [hl]
    inc [hl]

    inc hl ; multiplier

; Multiply by attack base power
    ld [hl], d
    call Multiply

; Multiply by attack stat
    ld [hl], b
    call Multiply

; Divide by defender's defense stat
    ld [hl], c
    ld b, 4
    call Divide

; Divide by 50
    ld [hl], 50
    ld b, 4
    call Divide

    ld hl, wDamage
    ld b, [hl]
    ld a, [H_QUOTIENT + 3]
    add b
    ld [H_QUOTIENT + 3], a
    jr nc, .asm_3dfd0

    ld a, [H_QUOTIENT + 2]
    inc a
    ld [H_QUOTIENT + 2], a
    and a
    jr z, .asm_3e004

.asm_3dfd0
    ld a, [H_QUOTIENT]
    ld b, a
    ld a, [H_QUOTIENT + 1]
    or a
    jr nz, .asm_3e004

    ld a, [H_QUOTIENT + 2]
    cp 998 / $100
    jr c, .asm_3dfe8
    cp 998 / $100 + 1
    jr nc, .asm_3e004
    ld a, [H_QUOTIENT + 3]
    cp 998 % $100
    jr nc, .asm_3e004

.asm_3dfe8
    inc hl
    ld a, [H_QUOTIENT + 3]
    ld b, [hl]
    add b
    ld [hld], a

    ld a, [H_QUOTIENT + 2]
    ld b, [hl]
    adc b
    ld [hl], a
    jr c, .asm_3e004

    ld a, [hl]
    cp 998 / $100
    jr c, .asm_3e00a
    cp 998 / $100 + 1
    jr nc, .asm_3e004
    inc hl
    ld a, [hld]
    cp 998 % $100
    jr c, .asm_3e00a

.asm_3e004
; cap at 997
    ld a, 997 / $100
    ld [hli], a
    ld a, 997 % $100
    ld [hld], a

.asm_3e00a
; add 2
    inc hl
    ld a, [hl]
    add 2
    ld [hld], a
    jr nc, .applyCrit
    inc [hl]
.applyCrit
    ld a, [wCriticalHitOrOHKO]
    and a
    jr z, .rageBoost
    ld a, [hli]
    ld h, [hl]
    ld l, a
    add hl, hl
    ld a, h
    ld [wDamage], a
    ld a, l
    ld [wDamage + 1], a
    cp 999 / $100
    jr c, .rageBoost
    jr nz, .capDamage
    ld a, l
    cp 999 % $100
    jr c, .rageBoost
.capDamage
    ld a, 999 / $100
    ld [wDamage], a
    ld a, 999 % $100
    ld [wDamage + 1], a
.rageBoost
    call CalculateRageDamage
    call AdjustDamageForMoveType
.done
    ld a, 1
    and a
    ret

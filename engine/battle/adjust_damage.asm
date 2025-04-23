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

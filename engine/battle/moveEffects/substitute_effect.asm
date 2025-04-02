SubstituteEffect_:
	ld c, 50
	call DelayFrames
	ld hl, wBattleMonMaxHP
	ld de, wPlayerSubstituteHP
	ld bc, wPlayerBattleStatus2
	ld a, [H_WHOSETURN]
	and a
	jr z, .notEnemy
	ld hl, wEnemyMonMaxHP
	ld de, wEnemySubstituteHP
	ld bc, wEnemyBattleStatus2
.notEnemy
	ld a, [bc]
	bit HAS_SUBSTITUTE_UP, a ; user already has substitute?
	jr nz, .alreadyHasSubstitute
; quarter health to remove from user
; assumes max HP is 1023 or lower
	push bc
	ld a, [hli]
	ld b, [hl]
	srl a
	rr b
	srl a
	rr b ; max hp / 4
	push de
	ld de, wBattleMonHP - wBattleMonMaxHP
	add hl, de ; point hl to current HP low byte
    ld a, [hli]
    ld d, a                    ; d = HP high
    ld a, [hl]
    sub b                      ; Low byte - 25%
    ld e, a                    ; e = result low
    ld a, d
    sbc 0                      ; High byte carry
    jr c, .notEnoughHP         ; Fail if HP < 25%
    ld a, e
    cp b
    jr z, .notEnoughHP         ; Fail if HP = 25% (low bytes match)
    ld a, d
    sub 0                      ; Check high byte
    jr nz, .subtractHP         ; Proceed if high byte differs
    ld a, e
    cp 1                       ; If HP - 25% = 0, adjust
    jr nz, .subtractHP
    inc b                      ; Increase cost to leave 1 HP
.subtractHP
    ld a, [hld]
    sub b
    ld [hli], a                ; Update HP low
    ld a, [hl]
    sbc 0
    ld [hld], a                ; Update HP high
    jr nc, .setSubstitute
    inc a
    ld [hli], a                ; Set HP to 1 if underflow
    inc a
    ld [hl], a
.setSubstitute
    pop de
    ld a, b
    ld [de], a                 ; Substitute HP = 25%
    pop bc
    ld h, b
    ld l, c
    set HAS_SUBSTITUTE_UP, [hl]
	ld a, [wOptions]
	bit 7, a ; battle animation is enabled?
	ld hl, PlayCurrentMoveAnimation
	ld b, BANK(PlayCurrentMoveAnimation)
	jr z, .animationEnabled
	ld hl, AnimationSubstitute
	ld b, BANK(AnimationSubstitute)
.animationEnabled
	call Bankswitch ; jump to routine depending on animation setting
	ld hl, SubstituteText
	call PrintText
	jpab DrawHUDsAndHPBars
.alreadyHasSubstitute
	ld hl, HasSubstituteText
	jr .printText
.notEnoughHP
	ld hl, TooWeakSubstituteText
.printText
	jp PrintText

SubstituteText:
	TX_FAR _SubstituteText
	db "@"

HasSubstituteText:
	TX_FAR _HasSubstituteText
	db "@"

TooWeakSubstituteText:
	TX_FAR _TooWeakSubstituteText
	db "@"

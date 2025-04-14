SECTION "Battle Animations", ROMX, BANK[$10]

HandleExplodingAnimation:
    ld a, [H_WHOSETURN]
    and a
    ld hl, wEnemyMonType1
    ld de, wEnemyBattleStatus1
    ld a, [wPlayerMoveNum]
    jr z, .player
    ld hl, wBattleMonType1
    ld de, wEnemyBattleStatus1
    ld a, [wEnemyMoveNum]
.player
    cp SELFDESTRUCT
    jr z, .isExplodingMove
    cp EXPLOSION
    ret nz
.isExplodingMove
    ld a, [de]
    bit INVULNERABLE, a
    ret nz
    ld a, [hli]
    cp GHOST
    ret z
    ld a, [hl]
    cp GHOST
    ret z
    ld a, [wMoveMissed]
    and a
    ret nz
    ld a, 5
    ld [wAnimationType], a
    ret

; show 2 stages of the player mon getting smaller before disappearing
AnimateRetreatingPlayerMon:
	coord hl, 1, 5
	lb bc, 7, 7
	call ClearScreenArea
	coord hl, 3, 7
	lb bc, 5, 5
	xor a
	ld [wDownscaledMonSize], a
	ld [hBaseTileID], a
	predef CopyDownscaledMonTiles
	ld c, 4
	call DelayFrames
	call .clearScreenArea
	coord hl, 4, 9
	lb bc, 3, 3
	ld a, 1
	ld [wDownscaledMonSize], a
	xor a
	ld [hBaseTileID], a
	predef CopyDownscaledMonTiles
	call Delay3
	call .clearScreenArea
	ld a, $4c
	Coorda 5, 11
.clearScreenArea
	coord hl, 1, 5
	lb bc, 7, 7
call ClearScreenArea
ret

; center's mon's name on the battle screen
; if the name is 1 or 2 letters long, it is printed 2 spaces more to the right than usual
; (i.e. for names longer than 4 letters)
; if the name is 3 or 4 letters long, it is printed 1 space more to the right than usual
; (i.e. for names longer than 4 letters)
CenterMonName:
	push de
	inc hl
	inc hl
	ld b, $2
.loop
	inc de
	ld a, [de]
	cp "@"
	jr z, .done
	inc de
	ld a, [de]
	cp "@"
	jr z, .done
	dec hl
	dec b
	jr nz, .loop
.done
	pop de
	ret

PlayBattleAnimation2:
; play animation ID at a and animation type 6 or 3
	ld [wAnimationID], a
	ld a, [H_WHOSETURN]
	and a
	ld a, $6
	jr z, .storeAnimationType
	ld a, $3
.storeAnimationType
	ld [wAnimationType], a
	jp PlayBattleAnimationGotID

PlayCurrentMoveAnimation:
; animation at MOVENUM will be played unless MOVENUM is 0
; resets wAnimationType
	xor a
	ld [wAnimationType], a
	ld a, [H_WHOSETURN]
	and a
	ld a, [wPlayerMoveNum]
	jr z, .notEnemyTurn
	ld a, [wEnemyMoveNum]
.notEnemyTurn
	and a
	ret z

PlayBattleAnimationGotID:
; play animation at wAnimationID
	push hl
	push de
	push bc
	predef MoveAnimation
	pop bc
	pop de
	pop hl
	ret

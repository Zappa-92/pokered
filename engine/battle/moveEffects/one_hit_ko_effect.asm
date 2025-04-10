OneHitKOEffect_:
    xor a
    ld [wMoveMissed], a
    ld hl, wDamage
    xor a
    ld [hli], a
    ld [hl], a ; Set the damage output to zero
    dec a
    ld [wCriticalHitOrOHKO], a ; Initialize OHKO flag to $FF
    ; Compare levels
    ld hl, wBattleMonLevel
    ld de, wEnemyMonLevel
    ld a, [H_WHOSETURN]
    and a
    jr z, .compareLevels
    ld hl, wEnemyMonLevel
    ld de, wBattleMonLevel
.compareLevels
    ld a, [hl]                           ; Load user's level
    ld b, a
    ld a, [de]                           ; Load target's level
    sub b                                ; a = target's level - user's level
    jr nc, .targetHigher                 ; If target's level >= user's level
    ; User's level is higher
    cpl         ; Invert bits (one’s complement)
    inc a       ; Add 1 (two’s complement)
    ld b, a                              ; b = level difference
    sla a                                ; a = level difference * 2
    add b                                ; a = level difference * 3 (3% per level)
    ld b, a                              ; b = 3 * level difference
    ld a, 30                             ; Base accuracy: 30%
    add b                                ; Add 3% per level difference
    ld b, a                              ; b = calculated accuracy (30 + 3 * level difference)
    jr .rollForHit
.targetHigher
    cp 5                                 ; Check if target is 5+ levels higher
    jr nc, .miss                         ; If so, accuracy is 0% (always miss)
    ld b, a                              ; b = level difference
    ld a, 30                             ; Base accuracy: 30%
    sub b                                ; Subtract 1% per level difference
    ld b, a                              ; b = calculated accuracy (30 - level difference)
.rollForHit
    ld a, b
    and a
    jr z, .miss                          ; If accuracy is 0, miss
    ld b, a                              ; b = accuracy
    call BattleRandom                    ; a = random value (0-255)
    ld c, a
    ld a, b
    add a                                ; a = accuracy * 2 (since 255 = 100%)
    jr nc, .noOverflow
    ld a, 255                            ; Cap at 255
.noOverflow
    cp c                                 ; Compare random value to scaled accuracy
    jr c, .miss                          ; If random value >= accuracy, miss
    ; Move hits
    ld hl, wDamage
    ld a, $ff
    ld [hli], a
    ld [hl], a                           ; Set damage to 65535
    ld a, $2
    ld [wCriticalHitOrOHKO], a           ; Set OHKO flag
    ret
.miss
    ld a, $1
    ld [wMoveMissed], a                  ; Set move missed flag
    ret

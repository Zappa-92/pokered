HealEffect_:
    ld a, [H_WHOSETURN]
    and a
    ld de, wBattleMonHP
    ld hl, wBattleMonMaxHP
    ld a, [wPlayerMoveNum]
    jr z, .healEffect
    ld de, wEnemyMonHP
    ld hl, wEnemyMonMaxHP
    ld a, [wEnemyMoveNum]
.healEffect
    ld b, a                    ; Save move ID
    ld a, [de]
    cp [hl]                    ; Compare HP high bytes
    inc de
    inc hl
    ld a, [de]
    sbc [hl]                   ; Compare HP low bytes
    jp z, .failed              ; Fail if HP is maxed
    ld a, b                    ; Restore move ID
    cp REST
    jr nz, .healHP             ; Skip Rest-specific logic
    push hl
    push de
    push af
    ld c, 50
    call DelayFrames
    ld hl, wBattleMonStatus
    ld a, [H_WHOSETURN]
    and a
    jr z, .restEffect
    ld hl, wEnemyMonStatus
.restEffect
    ld a, [hl]
    and a                      ; Any status?
    jr z, .noStatusRest        ; Skip stat restore if no status
    ; Check Burn and Paralysis
    ld b, a                    ; Save original status
    bit BRN, a                 ; Burn?
    jr z, .checkParalysis
    push bc                    ; Save status
    call RestoreAttack         ; Restore Attack
    pop bc
.checkParalysis
    bit PAR, b                 ; Paralysis?
    jr z, .clearStatus
    call RestoreSpeed          ; Restore Speed
.clearStatus
    ld a, 2                    ; Sleep for 2 turns
    ld [hl], a                 ; Clear status, set Sleep
    ld hl, FellAsleepBecameHealthyText
    jr .printRestText
.noStatusRest
    ld a, 2
    ld [hl], a                 ; Set Sleep
    ld hl, StartedSleepingEffect
.printRestText
    call PrintText
    pop af
    pop de
    pop hl
.healHP
    ld a, [hld]
    ld [wHPBarMaxHP], a
    ld c, a                    ; Max HP low
    ld a, [hl]
    ld [wHPBarMaxHP+1], a
    ld b, a                    ; Max HP high
    jr z, .gotHPAmountToHeal   ; Skip halving if Rest
    srl b
    rr c                       ; Half max HP for Recover/Softboiled
.gotHPAmountToHeal
    ld a, [de]
    ld [wHPBarOldHP], a
    add c
    ld [de], a
    ld [wHPBarNewHP], a
    dec de
    ld a, [de]
    ld [wHPBarOldHP+1], a
    adc b
    ld [de], a
    ld [wHPBarNewHP+1], a
    inc hl
    inc de
    ld a, [de]
    dec de
    sub [hl]
    dec hl
    ld a, [de]
    sbc [hl]
    jr c, .playAnim
    ld a, [hli]
    ld [de], a
    ld [wHPBarNewHP+1], a
    inc de
    ld a, [hl]
    ld [de], a
    ld [wHPBarNewHP], a
.playAnim
    ld hl, PlayCurrentMoveAnimation
    call BankswitchEtoF
    ld a, [H_WHOSETURN]
    and a
    coord hl, 10, 9
    ld a, $1
    jr z, .updateHPBar
    coord hl, 2, 2
    xor a
.updateHPBar
    ld [wHPBarType], a
    predef UpdateHPBar2
    ld hl, DrawHUDsAndHPBars
    call BankswitchEtoF
    ld hl, RegainedHealthText
    jp PrintText
.failed
    ld c, 50
    call DelayFrames
    ld hl, PrintButItFailedText_
    jp BankswitchEtoF

; Stat restoration routines
RestoreAttack:
    ld a, [H_WHOSETURN]
    and a
    ld hl, wBattleMonAttack    ; Player’s Attack
    jr z, .callRestoreStat
    ld hl, wEnemyMonAttack     ; Enemy’s Attack
.callRestoreStat
    ld c, 2                    ; Attack index
    jr RestoreStat

RestoreSpeed:
    ld a, [H_WHOSETURN]
    and a
    ld hl, wBattleMonSpeed     ; Player’s Speed
    jr z, .callRestoreStat
    ld hl, wEnemyMonSpeed      ; Enemy’s Speed
.callRestoreStat
    ld c, 4                    ; Speed index
    jr RestoreStat

RestoreStat:
    push hl                    ; Save stat address
    ld a, [H_WHOSETURN]
    and a
    ld hl, wPartyMon1HPExp - 1 ; Player’s stat exp base
    ld de, wBattleMonDVs       ; Player’s DVs
    ld a, [wBattleMonLevel]    ; Player’s level
    jr z, .setLevel
    ld hl, wEnemyMonHPExp - 1  ; Enemy’s stat exp base
    ld de, wEnemyMonDVs        ; Enemy’s DVs
    ld a, [wCurEnemyLVL]       ; Enemy’s level
.setLevel
    ld [wCurEnemyLVL], a       ; Set level for CalcStat
    ld b, 1                    ; Consider stat exp
    ; c already set (2 = Attack, 4 = Speed)
    call CalcStat              ; Calculate stat
    pop hl                     ; Restore stat address
    ld a, [H_MULTIPLICAND+2]   ; Low byte
    ld [hli], a
    ld a, [H_MULTIPLICAND+1]   ; High byte
    ld [hl], a
    ret

StartedSleepingEffect:
	TX_FAR _StartedSleepingEffect
	db "@"

FellAsleepBecameHealthyText:
	TX_FAR _FellAsleepBecameHealthyText
	db "@"

RegainedHealthText:
	TX_FAR _RegainedHealthText
	db "@"

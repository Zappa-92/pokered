; engine/battle/status_effects.asm
SECTION "Status Effects", ROMX, BANK[$10]

; checks for various status conditions affecting the player mon
; stores whether the mon cannot use a move this turn in Z flag
CheckPlayerStatusConditions:
    ld hl, wBattleMonStatus
    ld a, [hl]
    and SLP                             ; Sleep mask
    jr z, .FrozenCheck
; sleeping
    dec a
    ld [wBattleMonStatus], a            ; Decrement sleep turns
    and a
    jr z, .WakeUp
    ; Still asleep
    ld hl, FastAsleepText
    call PrintText                      ; "Fast asleep!" (bank TBD)
    jr .sleepDone
.WakeUp
    ld hl, WokeUpText
    call PrintText                      ; "Woke up!" (bank TBD)
    xor a
    ld [wPlayerSelectedMove], a         ; Clear move for reselection
    ld hl, MoveSelectionMenu
    jpab MoveSelectionMenu              ; Bank F
.sleepDone
    xor a
    ld [wPlayerUsedMove], a             ; No move used this turn
    ld hl, ExecutePlayerMoveDone
    jpab ExecutePlayerMoveDone          ; Bank F

.FrozenCheck
    bit FRZ, [hl]
    jr z, .HeldInPlaceCheck
    ; Check for thawing (20% chance)
    callab BattleRandom                 ; Bank F
    cp 51                               ; 51/256 ≈ 20%
    jr nc, .stillFrozen
    ; Thaw the Pokémon
    ld a, [hl]
    res FRZ, a
    ld [hl], a
    ld hl, ThawedOutText
    call PrintText                      ; "Thawed out!" (bank TBD)
    jr .HeldInPlaceCheck
.stillFrozen
    ld hl, IsFrozenText
    call PrintText                      ; "Is frozen!" (bank TBD)
    jr .sleepDone

.HeldInPlaceCheck
    ld a, [wEnemyBattleStatus1]
    bit USING_TRAPPING_MOVE, a          ; Enemy using Wrap, etc.?
    jp z, .FlinchedCheck
    ld hl, CantMoveText
    call PrintText                      ; "Can't move!" (bank TBD)
    ld hl, ExecutePlayerMoveDone
    jpab ExecutePlayerMoveDone          ; Bank F

.FlinchedCheck
    ld hl, wPlayerBattleStatus1
    bit FLINCHED, [hl]
    jp z, .HyperBeamCheck
    res FLINCHED, [hl]                  ; Clear flinch
    ld hl, FlinchedText
    call PrintText                      ; "Flinched!" (bank TBD)
    ld hl, ExecutePlayerMoveDone
    jpab ExecutePlayerMoveDone          ; Bank F

.HyperBeamCheck
    ld hl, wPlayerBattleStatus2
    bit NEEDS_TO_RECHARGE, [hl]
    jr z, .AnyMoveDisabledCheck
    res NEEDS_TO_RECHARGE, [hl]         ; Clear recharge
    ld hl, MustRechargeText
    call PrintText                      ; "Must recharge!" (bank TBD)
    ld hl, ExecutePlayerMoveDone
    jpab ExecutePlayerMoveDone          ; Bank F

.AnyMoveDisabledCheck
    ld hl, wPlayerDisabledMove
    ld a, [hl]
    and a
    jr z, .ConfusedCheck
    dec a
    ld [hl], a
    and $F                              ; Disable counter hit 0?
    jr nz, .ConfusedCheck
    ld [hl], a
    ld [wPlayerDisabledMoveNumber], a
    ld hl, DisabledNoMoreText
    call PrintText                      ; "Disabled no more!" (bank TBD)

.ConfusedCheck
    ld a, [wPlayerBattleStatus1]
    add a                               ; Check confusion bit
    jr nc, .TriedToUseDisabledMoveCheck
    ld hl, wPlayerConfusedCounter
    dec [hl]
    jr nz, .IsConfused
    ld hl, wPlayerBattleStatus1
    res CONFUSED, [hl]                  ; Clear confusion
    ld hl, ConfusedNoMoreText
    call PrintText                      ; "Confusion gone!" (bank TBD)
    jr .TriedToUseDisabledMoveCheck
.IsConfused
    ld hl, IsConfusedText
    call PrintText                      ; "Is confused!" (bank TBD)
    xor a
    ld [wAnimationType], a
    ld a, CONF_ANIM - 1
    callab PlayMoveAnimation            ; Bank F
    callab BattleRandom                 ; Bank F
    cp $80                              ; 50% chance to hurt self
    jr c, .TriedToUseDisabledMoveCheck
    ld hl, wPlayerBattleStatus1
    ld a, [hl]
    and 1 << CONFUSED                   ; Keep only confusion
    ld [hl], a
    callab HandleSelfConfusionDamage    ; Bank F
    jr .MonHurtItselfOrFullyParalysed

.TriedToUseDisabledMoveCheck
    ld a, [wPlayerDisabledMoveNumber]
    and a
    jr z, .ParalysisCheck
    ld hl, wPlayerSelectedMove
    cp [hl]
    jr nz, .ParalysisCheck
    callab PrintMoveIsDisabledText      ; Bank F
    ld hl, ExecutePlayerMoveDone
    jpab ExecutePlayerMoveDone          ; Bank F

.ParalysisCheck
    ld hl, wBattleMonStatus
    bit PAR, [hl]
    jr z, .BideCheck
    callab BattleRandom                 ; Bank F
    cp $3F                              ; 25% chance to be paralyzed
    jr nc, .BideCheck
    ld hl, FullyParalyzedText
    call PrintText                      ; "Fully paralyzed!" (bank TBD)

.MonHurtItselfOrFullyParalysed
    ld hl, wPlayerBattleStatus1
    bit CHARGING_UP, [hl]
    jr z, .clearOtherStatuses
    ; Fly/Dig interrupted
    ld a, [wPlayerNumAttacksLeft]
    and a
    jr z, .clearOtherStatuses
    res CHARGING_UP, [hl]
    res INVULNERABLE, [hl]
    xor a
    ld [wPlayerNumAttacksLeft], a
    ld a, [wChargeMoveNum]
    ld [wPlayerMoveNum], a
    callab MoveHitTest                  ; Bank F
    jr c, .hitFailed
    callab GetDamageVarsForPlayerAttack ; Bank F
    jr z, .hitFailed
    callab CriticalHitTest              ; Bank F
    callab CalculateDamage              ; Bank F
    callab ApplyDamageToEnemyPokemon    ; Bank F
.hitFailed
.clearOtherStatuses
    ld a, [hl]
    and $FF ^ ((1 << STORING_ENERGY) | (1 << THRASHING_ABOUT) | (1 << USING_TRAPPING_MOVE))
    ld [hl], a                          ; Clear specific statuses
    ld hl, ExecutePlayerMoveDone
    jpab ExecutePlayerMoveDone          ; Bank F

.BideCheck
    ld hl, wPlayerBattleStatus1
    bit STORING_ENERGY, [hl]
    jr z, .ThrashingAboutCheck
    xor a
    ld [wPlayerMoveNum], a
    ld hl, wDamage
    ld a, [hli]
    ld b, a
    ld c, [hl]
    ld hl, wPlayerBideAccumulatedDamage + 1
    ld a, [hl]
    add c
    ld [hld], a
    ld a, [hl]
    adc b
    ld [hl], a                          ; Accumulate damage
    ld hl, wPlayerNumAttacksLeft
    dec [hl]
    jr z, .UnleashEnergy
    ld hl, ExecutePlayerMoveDone
    jpab ExecutePlayerMoveDone          ; Bank F
.UnleashEnergy
    res STORING_ENERGY, [hl]
    ld hl, UnleashedEnergyText
    call PrintText                      ; "Unleashed energy!" (bank TBD)
    ld a, 1
    ld [wPlayerMovePower], a
    ld hl, wPlayerBideAccumulatedDamage + 1
    ld a, [hld]
    add a
    ld b, a
    ld [wDamage + 1], a
    ld a, [hl]
    rl a                                ; Double damage
    ld [wDamage], a
    or b
    jr nz, .next
    ld a, 1
    ld [wMoveMissed], a
.next
    xor a
    ld [hli], a
    ld [hl], a
    ld a, BIDE
    ld [wPlayerMoveNum], a
    ld hl, handleIfPlayerMoveMissed
    jpab handleIfPlayerMoveMissed       ; Bank F

.ThrashingAboutCheck
    bit THRASHING_ABOUT, [hl]
    jr z, .MultiturnMoveCheck
    ld a, THRASH
    ld [wPlayerMoveNum], a
    ld hl, ThrashingAboutText
    call PrintText                      ; "Thrashing about!" (bank TBD)
    ld hl, wPlayerNumAttacksLeft
    dec [hl]
    callab CalculateDamage
    callab ApplyDamageToEnemyPokemon ; Apply damage after calculation
    push hl
    ld hl, wPlayerBattleStatus1
    res THRASHING_ABOUT, [hl]
    set CONFUSED, [hl]                  ; Confuse after thrashing
    callab BattleRandom                 ; Bank F
    and 3
    inc a
    inc a                               ; 2-5 turns confused
    ld [wPlayerConfusedCounter], a
    pop hl
    callab CalculateDamage
    callab ApplyDamageToEnemyPokemon ; Apply damage after calculation
.MultiturnMoveCheck
    ld hl, wPlayerBattleStatus1
    bit ATTACKING_MULTIPLE_TIMES, [hl]
    jp z, .RageCheck
    ld hl, AttackContinuesText
    call PrintText                      ; "Attack continues!" (bank TBD)
    ld a, [wPlayerNumAttacksLeft]
    dec a
    ld [wPlayerNumAttacksLeft], a
    jr z, .lastHit
    callab GetDamageVarsForPlayerAttack ; Bank F
    jr z, .skipDamage
    callab CriticalHitTest              ; Bank F
    callab CalculateDamage              ; Bank F
    callab ApplyDamageToEnemyPokemon    ; Bank F
.skipDamage
    ld hl, getPlayerAnimationType
    jpab getPlayerAnimationType         ; Bank F
.lastHit
    res ATTACKING_MULTIPLE_TIMES, [hl]
    ld hl, getPlayerAnimationType
    jpab getPlayerAnimationType         ; Bank F

.RageCheck
    ld a, [wPlayerBattleStatus2]
    bit USING_TRAPPING_MOVE, a
    jp nz, .multiturnMove
    bit USING_RAGE, a
    jp z, .checkPlayerStatusConditionsDone
    ld a, [wRageTurnsLeft]
    and a
    jr z, .rageEnded
    dec a
    ld [wRageTurnsLeft], a
    jr nz, .continueRage
.rageEnded
    res USING_RAGE, a
    ld [wPlayerBattleStatus2], a
    xor a
    ld [wRageCounter], a
    ld hl, RageEndedText
    call PrintText                      ; "Rage has ended!" (bank TBD)
    jp .checkPlayerStatusConditionsDone
.continueRage
    ld a, RAGE
    ld [wd11e], a
    call GetMoveName                    ; Bank TBD
    call CopyStringToCF4B               ; Bank TBD
    ld a, [wRageAccuracy]
    ld [wPlayerMoveAccuracy], a         ; Reset accuracy
    xor a
    ld [wPlayerMoveEffect], a
    ld hl, PlayerCanExecuteMove
    jpab PlayerCanExecuteMove           ; Bank F
.multiturnMove
    ld hl, AttackContinuesText
    call PrintText                      ; "Attack continues!" (bank TBD)
    ld a, [wPlayerNumAttacksLeft]
    dec a
    ld [wPlayerNumAttacksLeft], a
    ld hl, getPlayerAnimationType
    jp nz, getPlayerAnimationType       ; Bank F
    jpab getPlayerAnimationType         ; Bank F

.returnToHL
    xor a                               ; Z flag set: can move
    ret

.checkPlayerStatusConditionsDone
    ld a, $1                            ; Z flag clear: can't move
    and a
    ret

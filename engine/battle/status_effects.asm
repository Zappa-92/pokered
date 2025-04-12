SECTION "Status Effects", ROMX, BANK[$10]

; checks for various status conditions affecting the player mon
; stores whether the mon cannot use a move this turn in Z flag
CheckPlayerStatusConditions:
	ld hl, wBattleMonStatus
	ld a, [hl]
	and SLP ; sleep mask
	jr z, .FrozenCheck
; sleeping
	dec a
	ld [wBattleMonStatus], a ; decrement number of turns left
	and a
	jr z, .WakeUp
	; Still asleep
	ld hl, FastAsleepText
	call PrintText
	jr .sleepDone
.WakeUp
	ld hl, WokeUpText
	call PrintText
	; Clear last move to force new selection
    	xor a
	ld [wPlayerSelectedMove], a
    	; Jump to move selection
    	ld hl, MoveSelectionMenu  ; Sets up move menu, calls SelectMenuItem
    	jp .returnToHL
.sleepDone
	xor a
	ld [wPlayerUsedMove], a
	ld hl, ExecutePlayerMoveDone
	jp .returnToHL

.FrozenCheck
	bit FRZ, [hl]
	jr z, .HeldInPlaceCheck
	; Check for thawing (20% chance)
	call BattleRandom
	cp 51 ; 51/256 ≈ 20%
	jr nc, .stillFrozen
	; Thaw the Pokémon
	ld a, [hl]
	res FRZ, a
	ld [hl], a
	ld hl, ThawedOutText
	call PrintText
	jr .HeldInPlaceCheck
.stillFrozen
	ld hl, IsFrozenText
	call PrintText
	jr .sleepDone

.HeldInPlaceCheck
	ld a, [wEnemyBattleStatus1]
	bit USING_TRAPPING_MOVE, a ; is enemy using a mult-turn move like wrap?
	jp z, .FlinchedCheck
	ld hl, CantMoveText
	call PrintText
	ld hl, ExecutePlayerMoveDone ; player can't move this turn
	jp .returnToHL

.FlinchedCheck
	ld hl, wPlayerBattleStatus1
	bit FLINCHED, [hl]
	jp z, .HyperBeamCheck
	res FLINCHED, [hl] ; reset player's flinch status
	ld hl, FlinchedText
	call PrintText
	ld hl, ExecutePlayerMoveDone ; player can't move this turn
	jp .returnToHL

.HyperBeamCheck
	ld hl, wPlayerBattleStatus2
	bit NEEDS_TO_RECHARGE, [hl]
	jr z, .AnyMoveDisabledCheck
	res NEEDS_TO_RECHARGE, [hl] ; reset player's recharge status
	ld hl, MustRechargeText
	call PrintText
	ld hl, ExecutePlayerMoveDone ; player can't move this turn
	jp .returnToHL

.AnyMoveDisabledCheck
	ld hl, wPlayerDisabledMove
	ld a, [hl]
	and a
	jr z, .ConfusedCheck
	dec a
	ld [hl], a
	and $f ; did Disable counter hit 0?
	jr nz, .ConfusedCheck
	ld [hl], a
	ld [wPlayerDisabledMoveNumber], a
	ld hl, DisabledNoMoreText
	call PrintText

.ConfusedCheck
	ld a, [wPlayerBattleStatus1]
	add a ; is player confused?
	jr nc, .TriedToUseDisabledMoveCheck
	ld hl, wPlayerConfusedCounter
	dec [hl]
	jr nz, .IsConfused
	ld hl, wPlayerBattleStatus1
	res CONFUSED, [hl] ; if confused counter hit 0, reset confusion status
	ld hl, ConfusedNoMoreText
	call PrintText
	jr .TriedToUseDisabledMoveCheck
.IsConfused
	ld hl, IsConfusedText
	call PrintText
	xor a
	ld [wAnimationType], a
	ld a, CONF_ANIM - 1
	call PlayMoveAnimation
	call BattleRandom
	cp $80 ; 50% chance to hurt itself
	jr c, .TriedToUseDisabledMoveCheck
	ld hl, wPlayerBattleStatus1
	ld a, [hl]
	and 1 << CONFUSED ; if mon hurts itself, clear every other status from wPlayerBattleStatus1
	ld [hl], a
	call HandleSelfConfusionDamage
	jr .MonHurtItselfOrFullyParalysed

.TriedToUseDisabledMoveCheck
; prevents a disabled move that was selected before being disabled from being used
	ld a, [wPlayerDisabledMoveNumber]
	and a
	jr z, .ParalysisCheck
	ld hl, wPlayerSelectedMove
	cp [hl]
	jr nz, .ParalysisCheck
	call PrintMoveIsDisabledText
	ld hl, ExecutePlayerMoveDone ; if a disabled move was somehow selected, player can't move this turn
	jp .returnToHL

.ParalysisCheck
	ld hl, wBattleMonStatus
	bit PAR, [hl]
	jr z, .BideCheck
	call BattleRandom
	cp $3F ; 25% to be fully paralyzed
	jr nc, .BideCheck
	ld hl, FullyParalyzedText
	call PrintText

.MonHurtItselfOrFullyParalysed
    ld hl, wPlayerBattleStatus1
    bit CHARGING_UP, [hl]
    jr z, .clearOtherStatuses
    ; Fly/Dig interrupted: Attempt attack phase
    ld a, [wPlayerNumAttacksLeft]
    and a
    jr z, .clearOtherStatuses  ; Already completed
    res CHARGING_UP, [hl]
    res INVULNERABLE, [hl]
    xor a
    ld [wPlayerNumAttacksLeft], a
    ld a, [wChargeMoveNum]
    ld [wPlayerMoveNum], a
    call MoveHitTest
    jr c, .hitFailed
    call GetDamageVarsForPlayerAttack
    jr z, .hitFailed
    call CriticalHitTest
    call CalculateDamage
    call ApplyDamageToEnemyPokemon
.hitFailed
.clearOtherStatuses
    ld a, [hl]
    and $ff ^ ((1 << STORING_ENERGY) | (1 << THRASHING_ABOUT) | (1 << USING_TRAPPING_MOVE))
    ld [hl], a
    ld hl, ExecutePlayerMoveDone
    jp .returnToHL

.BideCheck
	ld hl, wPlayerBattleStatus1
	bit STORING_ENERGY, [hl] ; is mon using bide?
	jr z, .ThrashingAboutCheck
	xor a
	ld [wPlayerMoveNum], a
	ld hl, wDamage
	ld a, [hli]
	ld b, a
	ld c, [hl]
	ld hl, wPlayerBideAccumulatedDamage + 1
	ld a, [hl]
	add c ; accumulate damage taken
	ld [hld], a
	ld a, [hl]
	adc b
	ld [hl], a
	ld hl, wPlayerNumAttacksLeft
	dec [hl] ; did Bide counter hit 0?
	jr z, .UnleashEnergy
	ld hl, ExecutePlayerMoveDone
	jp .returnToHL ; unless mon unleashes energy, can't move this turn
.UnleashEnergy
	ld hl, wPlayerBattleStatus1
	res STORING_ENERGY, [hl] ; not using bide any more
	ld hl, UnleashedEnergyText
	call PrintText
	ld a, 1
	ld [wPlayerMovePower], a
	ld hl, wPlayerBideAccumulatedDamage + 1
	ld a, [hld]
	add a
	ld b, a
	ld [wDamage + 1], a
	ld a, [hl]
	rl a ; double the damage
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
	ld hl, handleIfPlayerMoveMissed ; skip damage calculation, DecrementPP and MoveHitTest
	jp .returnToHL

.ThrashingAboutCheck
	bit THRASHING_ABOUT, [hl] ; is mon using thrash or petal dance?
	jr z, .MultiturnMoveCheck
	ld a, THRASH
	ld [wPlayerMoveNum], a
	ld hl, ThrashingAboutText
	call PrintText
	ld hl, wPlayerNumAttacksLeft
	dec [hl] ; did Thrashing About counter hit 0?
	ld hl, PlayerCalcMoveDamage ; skip DecrementPP
	jp nz, .returnToHL
	push hl
	ld hl, wPlayerBattleStatus1
	res THRASHING_ABOUT, [hl] ; no longer thrashing about
	set CONFUSED, [hl] ; confused
	call BattleRandom
	and 3
	inc a
	inc a ; confused for 2-5 turns
	ld [wPlayerConfusedCounter], a
	pop hl ; skip DecrementPP
	jp .returnToHL

.MultiturnMoveCheck
    ld hl, wPlayerBattleStatus1
    bit ATTACKING_MULTIPLE_TIMES, [hl]
    jp z, .RageCheck
    ; Continuing multi-hit move
    ld hl, AttackContinuesText
    call PrintText
    ld a, [wPlayerNumAttacksLeft]
    dec a
    ld [wPlayerNumAttacksLeft], a
    jr z, .lastHit
    ; Recalculate damage for each hit
    call GetDamageVarsForPlayerAttack
    jr z, .skipDamage  ; Skip if move power is 0
    call CriticalHitTest
    call CalculateDamage
    call ApplyDamageToEnemyPokemon
.skipDamage
    ld hl, getPlayerAnimationType
    jp .returnToHL
.lastHit
    res ATTACKING_MULTIPLE_TIMES, [hl]
    ld hl, getPlayerAnimationType
    jp .returnToHL

.RageCheck
    ld a, [wPlayerBattleStatus2]
    bit USING_TRAPPING_MOVE, [hl]
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
    res USING_RAGE, [hl]
    xor a
    ld [wRageCounter], a
    ld hl, RageEndedText
    call PrintText
    jp .checkPlayerStatusConditionsDone
.continueRage
    ld a, RAGE
    ld [wd11e], a
    call GetMoveName
    call CopyStringToCF4B
    ; Reset accuracy to initial value to prevent stacking
    ld a, [wRageAccuracy]
    ld [wPlayerMoveAccuracy], a
    xor a
    ld [wPlayerMoveEffect], a
    ld hl, PlayerCanExecuteMove
    jp hl
.multiturnMove
    ld hl, AttackContinuesText
    call PrintText
    ld a, [wPlayerNumAttacksLeft]
    dec a
    ld [wPlayerNumAttacksLeft], a
    ld hl, getPlayerAnimationType
    jp nz, hl
    jp hl

.returnToHL
	xor a
	ret

.checkPlayerStatusConditionsDone
	ld a, $1
	and a
	ret


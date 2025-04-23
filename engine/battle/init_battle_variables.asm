InitBattleVariables:
    ld a, [hTilesetType]
    ld [wSavedTilesetType], a
    xor a                      ; a = 0
    ld [wActionResultOrTookBattleTurn], a
    ld [wBattleResult], a
    ld hl, wPartyAndBillsPCSavedMenuItem
    ld [hli], a
    ld [hli], a
    ld [hli], a
    ld [hl], a
    ld [wListScrollOffset], a
    ld [wCriticalHitOrOHKO], a
    ld [wBattleMonSpecies], a
    ld [wPartyGainExpFlags], a
    ld [wPlayerMonNumber], a
    ld [wEscapedFromBattle], a
    ld [wMapPalOffset], a
    ld hl, wPlayerHPBarColor
    ld [hli], a                ; wPlayerHPBarColor
    ld [hl], a                 ; wEnemyHPBarColor
    ld hl, wCanEvolveFlags
    ld b, $3c
.loop
    ld [hli], a
    dec b
    jr nz, .loop
    ; Clear new switch flags
    ld [wPlayerSwitched], a    ; Added: Clear player Teleport switch flag
    ld [wEnemySwitched], a     ; Added: Clear enemy Teleport switch flag
    ld [wForceEnemyToSwitch], a ; Added: Clear Whirlwind/Roar enemy switch flag
    ld [wForcePlayerToSwitch], a ; Added: Clear enemy Whirlwind/Roar player switch flag
    inc a                      ; POUND
    ld [wTestBattlePlayerSelectedMove], a
    ld a, [wCurMap]
    cp SAFARI_ZONE_EAST
    jr c, .notSafariBattle
    cp SAFARI_ZONE_CENTER_REST_HOUSE
    jr nc, .notSafariBattle
    ld a, BATTLE_TYPE_SAFARI
    ld [wBattleType], a
.notSafariBattle
    jpab PlayBattleMusic

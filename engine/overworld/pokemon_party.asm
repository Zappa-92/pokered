SECTION "Pokemon Party Check", ROMX, BANK[$10]

;adding function to check if a pokemon is in party, for GIOVANNI event
IsPokemonInParty:
    push bc
    push hl

    ld a, [wPartyCount]
    ld b, a
    ld hl, wPartySpecies

.loop
    ld a, [hli]

    cp MEWTWO
    jr z, .found

    ; probar offset por las dudas
    ld c, a
    ld a, MEWTWO
    dec a
    cp c
    jr z, .found

    dec b
    jr nz, .loop

.not_found
    xor a
    jr .done

.found
    ld a, 1
    or a

.done
    pop hl
    pop bc
    ret

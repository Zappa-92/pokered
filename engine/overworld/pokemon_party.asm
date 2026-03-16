SECTION "Pokemon Party Check", ROMX, BANK[$10]

;adding function to check if a pokemon is in party, for GIOVANNI event
IsPokemonInParty:
; Input: a = Pokémon ID to check
; Output: z flag set if not in party, nz if found
    push bc
    push de
    push hl
    ld [wcf91], a        ; Store input Pokémon ID
    ld hl, wPartySpecies
    ld b, 6  ; Party size
.loop
    ld a, [hli]
    ld c, a
    ld a, [wcf91]
    cp c ; Compare with input Pokémon ID
    jr z, .found
    dec b
    jr nz, .loop
    xor a  ; Set z flag (not found)
    jr .done
.found
    ld a, 1  ; Clear z flag (found)
.done
    pop hl
    pop de
    pop bc
    ret

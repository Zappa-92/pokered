SECTION "Pokemon Party Check", ROMX, BANK[$10]

;adding function to check if a pokemon is in party, for GIOVANNI event
IsPokemonInParty:
; Input: a = Pokémon ID
; Output: Z = 1 → NO está
;         Z = 0 → SÍ está
    push bc
    push hl
    ld b, a              ; guardar Pokémon buscado
    ld hl, wPartySpecies
    inc hl               ; SALTEAR el count
.loop
    ld a, [hli]
    cp $FF               ; fin de lista
    jr z, .not_found
    cp b
    jr z, .found
    jr .loop
.found
    or a                 ; Z = 0
    jr .done
.not_found
    xor a                ; Z = 1
.done
    pop hl
    pop bc
    ret

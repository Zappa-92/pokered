SECTION "Pokemon Party Check", ROMX, BANK[$10]

;adding function to check if a pokemon is in party, for GIOVANNI event
IsPokemonInParty:
; Input: a = Pokémon ID
; Output: Z = 1 → NO está
;         Z = 0 → SÍ está

    push bc
    push hl

    ld b, a                  ; Pokémon buscado
    ld a, [wPartyCount]
    and a
    jr z, .not_found         ; party vacía

    ld c, a                  ; cantidad en C
    ld hl, wPartySpecies

.loop
    ld a, [hli]
    cp b
    jr z, .found

    dec c
    jr nz, .loop

.not_found
    xor a                    ; Z = 1
    jr .done

.found
    ld a, 1
    or a                     ; Z = 0

.done
    pop hl
    pop bc
    ret

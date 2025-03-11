EvolveTradeMon:
    ld a, [wPartyCount]
    dec a
    ld [wWhichPokemon], a
    ld a, [wInGameTradeReceiveMonSpecies] ; Assuming species stored here
    cp GRAVELER
    jr z, .ok
    cp HAUNTER
    jr z, .ok
    cp KADABRA
    jr z, .ok
    cp MACHOKE
    ret nz
.ok
    ld a, $1
    ld [wForceEvolution], a
    ld a, LINK_STATE_TRADING
    ld [wLinkState], a
    callab TryEvolvingMon
    xor a
    ld [wLinkState], a
    jp PlayDefaultMusic

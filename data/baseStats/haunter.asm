db DEX_HAUNTER ; pokedex id
db 60 ; base hp
db 60 ; base attack
db 55 ; base defense
db 95 ; base speed
db 105 ; base special
db GHOST ; species type 1
db GHOST ; species type 2
db 90 ; catch rate
db 126 ; base exp yield
INCBIN "pic/bmon/haunter.pic",0,1 ; 66, sprite dimensions
dw HaunterPicFront
dw HaunterPicBack
; attacks known at lvl 0
db LICK
db NIGHT_SHADE
db CONFUSE_RAY
db 0
db 3 ; growth rate
; learnset
	tmlearn 6
	tmlearn 0
	tmlearn 20,21,24
	tmlearn 25,29,31,32
	tmlearn 34,36
	tmlearn 42,44,46,47
	tmlearn 50
db 0 ; padding

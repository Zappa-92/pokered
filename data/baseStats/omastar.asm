db DEX_OMASTAR ; pokedex id
db 90 ; base hp
db 65 ; base attack
db 125 ; base defense
db 60 ; base speed
db 115 ; base special
db ROCK ; species type 1
db WATER ; species type 2
db 45 ; catch rate
db 199 ; base exp yield
INCBIN "pic/bmon/omastar.pic",0,1 ; 66, sprite dimensions
dw OmastarPicFront
dw OmastarPicBack
; attacks known at lvl 0
db WITHDRAW
db HORN_ATTACK
db WATER_GUN
db 0
db 0 ; growth rate
; learnset
	tmlearn 6,7,8
	tmlearn 9,10,11,12,13,14,15
	tmlearn 17,19,20
	tmlearn 31,32
	tmlearn 33,34,40
	tmlearn 44
	tmlearn 50,53
db 0 ; padding

db DEX_KRABBY ; pokedex id
db 45 ; base hp
db 95 ; base attack
db 90 ; base defense
db 50 ; base speed
db 35 ; base special
db WATER ; species type 1
db WATER ; species type 2
db 225 ; catch rate
db 115 ; base exp yield
INCBIN "pic/bmon/krabby.pic",0,1 ; 55, sprite dimensions
dw KrabbyPicFront
dw KrabbyPicBack
; attacks known at lvl 0
db LEER
db BUBBLE
db 0
db 0
db 0 ; growth rate
; learnset
	tmlearn 3,6,8
	tmlearn 9,10,11,12,13,14
	tmlearn 20
	tmlearn 31,32
	tmlearn 34
	tmlearn 44
	tmlearn 50,51,53,54
db 0 ; padding

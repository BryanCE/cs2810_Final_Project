.orig x3000		
lea r0, welcome	; outputting the beginning storyline
puts
lea r0, instruction1
puts					; x6e or 110 = n
getc					; x7a or 122 = z
						;x65 or 101 = e for exit


						    
st r0, enemypicked   	; storing the result of the input in enemyPicked label
						; from r0 

ld r1, enemypicked
ld r2, ascii_e 			;loading the value of e to compare against enemyPicked
not r1, r1
add r1, r1 #1
add r1, r1, r2
BRz exit ; branching to exit if e was pressed
				
lea r0, readytofight	; get ready to fight 
puts

and r0, r0, #0 			; clearing r0 before next instruction

;------------------------------------begin fight loop------------------------------
;k = x006b or 107 
;p = x0070 or 112 
fight 
	ld r5, yourhitpoints ;loading a register with your hit points 
	ld r6, enemyhitpoints ; loading r6 with the enemies hit points
	

yourattack	
	lea r0, kickorpunch ;choose a kick or punch you make a hit first
	puts
	getc 	;getting k or p input from user 
 
	add r1, r0 #0 ;saving the value for k or p in r1
	ld r2, kicking
	ld r3, punching
	not r2,r2		;making a negative of r2 and r3 to compare against input
	not r3,r3
	add r2,r2 #1 ;add one for 2's compliment
	add r3,r3 #1
	add r4, r2, r1  ;checking for a kick
	BRz kickloop	;if a kick was used branch to kickloop
	add r4, r3, r1  ;checking for a punch
	BRz punchloop	;if a punch was used branch to punchLoop

enemyattack	  ; enemy attacks opposite of what user attacks

	ld r2, kicking
	ld r3, punching
	not r2,r2		;making a negative of r2 and r3 to compare against input
	not r3,r3
	add r2,r2 #1 ;add one for 2's compliment
	add r3,r3 #1
	add r4, r2, r1  ;checking for a kick
	BRz enemypunchloop	;if a kick was used branch to enemypunchloop
	add r4, r3, r1  ;checking for a punch
	BRz enemykickloop	;if a punch was used branch to enemykickloop

punchloop
	add r6, r6, #-10 ; damage to enemy
	BR enemyattack
kickloop
	add r6, r6, #-15 ; damage to enemy
	BR enemyattack

enemypunchloop
	add r5, r5, #-10 ; damage to user
	BR checkhealth

enemykickloop
	add r5, r5, #-15 ; damage to user 
	BR checkhealth	

checkhealth  ; check user and enemy health to see if continue fighting

exit 
	and r0, r0, #0
	lea r0, quitgame;------------something wrong here
	puts
	trap x25
	
welcome .stringz "Welcome to Zoltan!\nYour whole life you've wanting to know your future.\nThere is only one way!\nYou must fight!"				
enemypicked .fill x0000
yourhitpoints .fill #100  ;or could be x0064 in hex
enemyhitpoints .fill #100 ;or could be x0064 in hex
kick .fill #-15
punch .fill #-10
kicking .fill x006b
punching .fill x0070
ascii_e .FILL x0065
quitgame .stringz "You must be Scared!";-------------something wrong here
kickorpunch .stringz "\nk = kick p = punch\n"
readytofight .stringz "Get ready to fight!\n"
instruction1 .stringz "\nChoose your opponent\nPress Z for a Zombie or N for a Ninja\nOr e to exit\nWhich do you choose?\n"

.end ; end
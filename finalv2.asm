.orig x3000		

lea r0, welcome	; outputting the beginning storyline
puts

welcome .stringz "Welcome to Zoltan!\nYour whole life you've wanting to know your future.\nThere is only one way!\nYou must fight!"				
instruction1 .stringz "\nChoose your opponent\nPress Z for a Zombie or N for a Ninja\nOr e to exit\nWhich do you choose?\n"
readytofight .stringz "Get ready to fight!\n"
enemyPicked .fill x0000
wanttoexit .fill x65 ; or 101 in decimal
zombie .fill x7a ; storing z ascii
ninja .fill x6e ; storing n ascii
play 
	lea r0, instruction1
	puts					; x6e or 110 = n
	getc					; x7a or 122 = z
							;x65 or 101 = e for exit
								
	st r0, enemyPicked   	; storing the result of the input in enemyPicked label
							; from r0 

	ld r1, enemyPicked ; load a register with the hex value for the enemy they picked
	ld r2, wanttoexit ; load a register with the exit character in hex
	not r1, r1        ; make this character a negative of itself to check against the exit character
	add r1, r1 #1     ; kind of like subtracting to check for a charcter
	add r3, r1, r2	  ; store the result in r3 should be zero if they want to exit
	BRz EXIT ; branching to exit if e was pressed

	and r1,r1,#0 ; clear r1 for next test
	and r2,r2,#0 ; clear r2 for next test
	and r3,r3,#0 ; clear r3 for next test

	lea r0, readytofight	; get ready to fight 
	puts
	ld r1, enemyPicked    ; reload r1 with which enemy has been picked
	ld r2, ninja
	ld r3, zombie
	not r1, r1       
	add r1, r1 #1     
	add r4, r1, r2    ; check for ninja save result in r4
	BRz fightingNinja

	add r4, r1, r3    ; check for zombie save result in r4	
	BRz fightingZombie
;---------------------------youlost------------------------------------------------
youLost
	lea r0, loser
	puts 
	getc
	ld r2, playAgain ;loading r2 with p for play again
	ld r3, wanttoexit ;load r3 with exit character
	add r1,r0,#0 ;moving character to r1
	not r1,r1
	add r1,r1,#1
	add r4,r1,r2 ;checking to see if player wants to play again saving result in r4
	BRz play
	add r4, r1, r3 ; checing for exit character
	BRz EXIT
;----------------------------------------------------------------------------------
;------------------------------------begin fight loop------------------------------
;k = x006b or 107 
;p = x0070 or 112 
;-------------------which enemy did you choose then jump to fight loop------------
fightingNinja
	ld r5, yourhitpoints ;loading a register with your hit points 
	ld r6, enemyhitpoints ; loading r6 with the enemies hit points

	lea r0, fightingN
	puts
	jsr Inthefight
	
	
fightingZombie
	ld r5, yourhitpoints ;loading a register with your hit points 
	ld r6, enemyhitpoints ; loading r6 with the enemies hit points
	
	lea r0, fightingZ
	puts
	jsr Inthefight
;------------------------------------------------------------------------------------------------

Inthefight	

	add r5, r5, #0 ; if your hit points are negative branch to you lost
	BRn youLost
	add r6, r6, #0 ; if the enemies points are negative branch to fortune
	BRn fortune
	
	lea r0, kickorpunch ;choose a kick or punch you make a hit first
	puts
	getc 	;getting k or p input from user 
	add r1, r0, #0 ; moving k or p value into r1
	ld r2, kicking
	ld r3, punching
	not r1, r1
	add r1, r1, #1
	add r4, r1,r2   ;checking for a kick
	BRz youKick
	add r4, r1, r3  ;checking for a punch
	BRz youPunch

	add r5, r5, #0
	BRp enemyTurn

youPunch
	add r6, r6, #-10
	BRnzp enemyTurn
youKick
	add r6, r6, #-15
	BRnzp enemyTurn
	
enemyTurn
	
randomstart
    and r4, r4, #0 ;clears reg 4
	lea r0, enterPicksHit ;using timing of enter key to randomly pick which hit gets executed on you
	puts
    BR randomnum

randomzero
	and r4, r4, #0
	BR randomnum

randomnum
    add r4, r4, #1 ;increments R4 by one and continues to loop
    add r2, r4, #0 
    add r2, r2, #-11 ;random number range 1-10
    BRz randomzero ;if it reaches upper limit branch to zero
    ldi r3, kbsrstore ;check for keyboard press
    BRzp randomnum ;loop back if no press
	st r4, temprand ;storage of "random" number generated
    BRn gettinghit

gettinghit
	getc ;to clear the buffer

	loop1
		add r5, r5, #-1; decrement user hit points
		add r4, r4, #-1 ;decrement by 1 every loop
		BRnz Inthefight
		BRp loop1
			
	;------------------------needs work above-----------------------------------------

fortune
	


	
	
	
EXIT 
	and r0, r0, #0
	lea r0, quitgame
	puts
	trap x25

pressedEnter .fill x0A
yourhitpoints .fill #100  ;or could be x0064 in hex
enemyhitpoints .fill #100 ;or could be x0064 in hex
kicked .fill #-15
punched .fill #-10
kicking .fill x006b
punching .fill x0070
playAgain .fill x70 ;p= 112 or x70
kbsrstore .fill xFE00
temprand .fill x0000
kbdrval .fill xFE02 
quitgame .stringz "You must be Scared!"
kickorpunch .stringz "\nk = kick p = punch\n"
fightingN .stringz "\nYou chose to fight a NINJA good luck!\n" 
fightingZ .stringz "\nYou chose to fight a Zombie good luck!\n"
loser .stringz "\nSorry but you did not earn your fortune! \nPress p to play again or e to exit.\n"
enterPicksHit .stringz "\nPress enter to defend\n"

trap x25 ; final shut down of program
.end ; end

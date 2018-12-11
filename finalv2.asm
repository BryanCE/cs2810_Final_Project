<<<<<<< HEAD

=======
>>>>>>> 96af55c692168f2c284c1bce14a1cf07ca3bf6ab
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
<<<<<<< HEAD
	jsr fortrandstart
youWon
	lea r0, winner
	puts
	jsr fortrandstart
	
playAgain .fill x70 ;p= 112 or x70
zhitpoints .fill #19  ;or could be x0032 in hex
nhitpoints .fill #22
enemyhitpoints .fill #45 ;or could be x0064 in hex
kicked .fill #-9
punched .fill #-5
=======
	getc
	ld r2, playAgain ;loading r2 with p for play again
	ld r3, wanttoexit ;load r3 with exit character
	add r1,r0,#0 ;moving character to r1
	not r1,r1
	add r1,r1,#1
	add r4,r1,r2 ;checking to see if player wants to play again saving result in r4
	BRz play
	add r4, r1, r3 ; checking for exit character
	BRz EXIT

playAgain .fill x70 ;p= 112 or x70
yourhitpoints .fill #50  ;or could be x0032 in hex
enemyhitpoints .fill #100 ;or could be x0064 in hex
kicked .fill #-15
punched .fill #-10
>>>>>>> 96af55c692168f2c284c1bce14a1cf07ca3bf6ab
kicking .fill x006b
punching .fill x0070
kbsrstore .fill xFE00
temprand .fill x0000
pressedEnter .fill x0A
kickorpunch .stringz "\nk = kick p = punch\n"
fightingN .stringz "\nYou chose to fight a Ninja good luck!\n" 
fightingZ .stringz "\nYou chose to fight a Zombie good luck!\n"
<<<<<<< HEAD
loser .stringz "\nYou Lost!\n"
winner .stringz "\nYou Won!\n"
kickeffect .stringz "\n KAPOW!\n"
puncheffect .stringz "\n WHAM!\n"
=======
loser .stringz "\nPress p to play again or e to exit.\n"
;----------------------------------------------------------------------------------
>>>>>>> 96af55c692168f2c284c1bce14a1cf07ca3bf6ab
;------------------------------------begin fight loop------------------------------
;k = x006b or 107 
;p = x0070 or 112 
;-------------------which enemy did you choose then jump to fight loop------------
fightingNinja
<<<<<<< HEAD
	ld r5, nhitpoints ;loading a register with ninja hit points 
	ld r6, enemyhitpoints ; loading r6 with the enemies hit points
=======
	ld r5, yourhitpoints ;loading a register with your hit points 
	ld r6, enemyhitpoints ; loading r6 with the enemies hit points

>>>>>>> 96af55c692168f2c284c1bce14a1cf07ca3bf6ab
	lea r0, fightingN
	puts
	jsr Inthefight
	
<<<<<<< HEAD
fightingZombie
	ld r5, zhitpoints ;loading a register with zombie hit points 
	ld r6, enemyhitpoints ; loading r6 with the enemies hit points
=======
	
fightingZombie
	ld r5, yourhitpoints ;loading a register with your hit points 
	ld r6, enemyhitpoints ; loading r6 with the enemies hit points
	
>>>>>>> 96af55c692168f2c284c1bce14a1cf07ca3bf6ab
	lea r0, fightingZ
	puts
	jsr Inthefight
;------------------------------------------------------------------------------------------------

Inthefight	
<<<<<<< HEAD
	add r5, r5, #0 ; if your hit points are negative branch to you lost
	BRn youLost
	add r6, r6, #0 ; if the enemies points are negative branch to fortune
	BRn youWon
=======

	add r5, r5, #0 ; if your hit points are negative branch to you lost
	BRn fortrandstart
	add r6, r6, #0 ; if the enemies points are negative branch to fortune
	BRn fortrandstart
	
>>>>>>> 96af55c692168f2c284c1bce14a1cf07ca3bf6ab
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
<<<<<<< HEAD
	
	add r5, r5, #0 ;if enemy isnt dead it's there turn
	BRp enemyTurn
	
youPunch
	add r6, r6, #-10
	lea r0, puncheffect
	puts
	BRnzp enemyTurn
youKick
	add r6, r6, #-15
	lea r0, kickeffect
	puts
=======

	add r5, r5, #0
	BRp enemyTurn

youPunch
	add r6, r6, #-10
	BRnzp enemyTurn
youKick
	add r6, r6, #-15
>>>>>>> 96af55c692168f2c284c1bce14a1cf07ca3bf6ab
	BRnzp enemyTurn
	
enemyTurn
	
<<<<<<< HEAD
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
		st r4, temprand ;storage of "random" number generated
		ldi r3, kbsrstore ;check for keyboard press
		BRzp randomnum ;loop back if no press
		BRn gettinghit

gettinghit
	getc ;to clear the buffer
=======
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
	st r4, temprand ;storage of "random" number generated
    ldi r3, kbsrstore ;check for keyboard press
    BRzp randomnum ;loop back if no press
    BRn gettinghit

gettinghit

getc ;to clear the buffer
>>>>>>> 96af55c692168f2c284c1bce14a1cf07ca3bf6ab

loop1
	add r5, r5, #-1; decrement user hit points
	add r4, r4, #-1 ;decrement by 1 every loop
	BRnz Inthefight
	BRp loop1
			
EXIT 
	and r0, r0, #0 ;clearing registers
	and r1, r1, #0
<<<<<<< HEAD
	add r1, r5,#0 ;test for damage to user to see if they played
	add r2,r1,#0 ;moving hit points for comparison
	not r1, r1
	add r1, r1, #1
	add r1, r1, r2
=======
	ld r1, yourhitpoints ;test for damage to user to see if they played
	not r1, r1
	add r1, r1, #1
	add r1, r1, r5
>>>>>>> 96af55c692168f2c284c1bce14a1cf07ca3bf6ab
	BRz noplay
	BRnp yesplay

noplay	
	lea r0, quitgame
	puts
	trap x25; or halt
yesplay
	lea r0, quitgame0
	puts
	trap x25; or halt

enterPicksHit .stringz "\nPress enter to defend\n" 
quitgame .stringz "\nNo fortune for cowards!\n"
quitgame0 .stringz "\nThanks for playing!\n"

<<<<<<< HEAD
=======

>>>>>>> 96af55c692168f2c284c1bce14a1cf07ca3bf6ab
fortrandstart
	and r4, r4, #0 ;clears reg 4
	lea r0, enterforfortune ;using timing of enter key to randomly pick which hit gets executed on you
	puts
    BR fortrandnum

fortrandzero
	and r4, r4, #0
	BR fortrandnum

fortrandnum
    add r4, r4, #1 ;increments R4 by one and continues to loop
    add r2, r4, #0 
    add r2, r2, #-4 ;random number range 1-3
    BRz fortrandzero ;if it reaches upper limit branch to zero
	st r4, temprand2 ;storage of "random" number generated
    ldi r3, kbsrstore2 ;check for keyboard press
	BRzp fortrandnum ;loop back if no press
	BRn fortuneresult
    
<<<<<<< HEAD
=======

>>>>>>> 96af55c692168f2c284c1bce14a1cf07ca3bf6ab
fortuneresult
	getc ;to clear the buffer
	and r1, r1, #0; clear r1
	add r2, r5, #0
	add r1, r1, r2; add user hit points to check if negative
	BRn badfortune
	BRzp goodfortune

goodfortune
	ld r2, temprand2
	add r3, r2, #-2
	BRn printgood1
	BRz printgood2
	BRp printgood3

badfortune
	ld r2, temprand2
	add r3, r2, #-2
	BRn printbad1
	BRz printbad2
	BRp printbad3

printgood1
	lea r0, goodfortune1
	puts
	jsr yesplay

printgood2
	lea r0, goodfortune2
	puts
	jsr yesplay

printgood3
	lea r0, goodfortune3
	puts
	jsr yesplay

goodfortune1 .stringz "\nA golden egg of opportunity falls into your lap this month.\n"
goodfortune2 .stringz "\nA new perspective will come with the new year.\n"
goodfortune3 .stringz "\nNow is a good time to buy stock.\n"

printbad1
	lea r0, badfortune1
	puts
	jsr yesplay

printbad2
	lea r0, badfortune2
	puts
	jsr yesplay

printbad3
	lea r0, badfortune3
	puts
	jsr yesplay

kbsrstore2 .fill xFE00
temprand2 .fill x0000
enterforfortune .stringz "\nPress f for your fortune.\n"
badfortune1 .stringz "\nYou smell like beef.\n"
badfortune2 .stringz "\nMoist pickles of bulbous girth await you next week.\n"
badfortune3 .stringz "\nYour life will end miserably, though nobody will notice.\n"

trap x25 ; final shut down of program
<<<<<<< HEAD
.end ; end
=======
.end ; end
>>>>>>> 96af55c692168f2c284c1bce14a1cf07ca3bf6ab

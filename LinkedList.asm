# Author: Jesse Jimenez
# Date  : 5/23/2022 
# Purpose: Implement a linked list data structure in MIPS

.data 
fwdBracket: 	.asciiz "["
space:		.asciiz " "
bckBracket:	.asciiz "]"
link:		.asciiz "---"
nullSym:		.asciiz "---[NULL]"
menu:		.asciiz "\nPress a key for the following selections\n1)Add node\n2)Print list\n3)Reverse list\n4)List size\n5)Clear list\n6)End program "
table:		.word default,case1,case2,case3,case4,case5,case6 # array of addresses  
null:		.byte '\0' 
wrongInput:	.asciiz "\nWrong format please enter an integer 1 - 6\n"
caseNum1:		.asciiz "\nPlease enter an integer to be added to the linked list\n"
caseNum2:		.asciiz "\nCase 2"
caseNum3:		.asciiz "\nCase 3"
caseNum4:		.asciiz "\nCase 4"
caseNum5:		.asciiz "\nCase 5"
caseNum6:		.asciiz "\nCase 6"

.text #source code
	# Prints string passes label address %x and perserves arg <reg>
	.macro printf %x
	addi	$sp,$sp,-8 # allocate 8 bytes on stack
	sw	$a0,0($sp) # store value onto stack
	sw	$v0,4($sp) # store value 4th byte on stack
	li	$v0,4  # set os to print string
	la	$a0,%x #load address of label
	syscall 
	lw	$a0,0($sp) #restore a0
	lw	$v0,4($sp) #restore v0
	addi	$sp,$sp,8  #deallocate stack
	.end_macro

.globl main
main: 	
	li	$s0,0    # int i
	la	$s1,null #headptr = NULL
	move	$a2,$s1  #arg gets address of NULL
	move	$a1,$a2
	# Implement a do while loop 
main_Loop:
  	
	printf (menu)
	addi	$sp,$sp,-4
	sw	$a1,0($sp)
	# Ask for user input to select cases  
	li	$v0,5 # read integer
	syscall 	#os read integer 
	la	$a1,table #Addres of table
	move	$a0,$v0  #move int to arg 
	# getAddress(int index, int* ptr)
	jal	getAddress
	lw	$a1,0($sp)
	addi	$sp,$sp,4
	jr	$v0
	case1: # Ask user input for integer and allocate memory on the heap 
	printf(caseNum1)
		li	$v0, 5 # read int
		syscall 
		# $a0 = int,$a1 = headptr, $a3 = null
		move	$a3,$s1
		move	$a0,$v0
		jal	pushNode
		j breakCase
	case2: # Print nodes in the list
	printf(caseNum2)
		j breakCase
	case3: # Reverse linked list
	printf(caseNum3)
		j breakCase
	case4: # Get list size
	printf(caseNum4)
		j breakCase
	case5: # Clear list
	printf(caseNum5) 
		j breakCase
	case6: # End program
	printf(caseNum6)
	li	$s0,1 
		j breakCase
	default: 
		# Let user know wrong input 
		printf(wrongInput)
		breakCase: 
	beq $s0,$zero,main_Loop # while($s0 == 0) goto main_Loop 
	
#Terminate program
li $v0, 10 
syscall
 
 
 # Procdure $v0 returns starting address of the jump table
 # $a0 int arg will determine address returned $v0
 # $a1 word arg will contain array of addresses
 .globl getAddress
 getAddress: 
 ble	$a0,$zero,not_Valid # if ($a0 =< $zero) goto Not_Valid
 bgt	$a0,6,not_Valid #if($a0 > 5) goto Not_Valid
 sll	$t0,$a0,2 # index multiple of sizeof(address)
 add	$t1,$t0,$a1 # Array + index 
 lw	$v0,0($t1) # result = (Array + index)
 jr	$ra # return 
 not_Valid: 
 lw	$v0,0($a1) # get default address
 jr $ra # return
 
#
# struct Node
#{
#	Node* next; 
#	int data; 
#}
#

# createNode() allocate memory in the heap initalize data memebers and return $v0 pointer to new node
.globl createNode
createNode:
	#Allocate memory in the heap and return address
	move	$t0,$a0 # get data
	li	$v0,9
	li	$a0,8
	syscall 	# os request
	sw	$t0,0($v0) # Node->data = data 
jr	$ra #return to calling function

# Adds node in front of linked list reassings new head pointer
# a0 = int, a1 = headptr, a2 = null pointer
.globl pushNode
pushNode: 
# Check if head is null
bne $a1,$a2,not_Empty #if($a1 != NULL) goto not_Empty
	# save return address to the stack
	addi	$sp,$sp,-4
	sw	$ra,0($sp)  
	jal	createNode 
	sw	$a1,4($v0) # Node->next = NULL 
	move	$a1,$v0   #head = *Node;
	lw	$ra,0($sp)#restore the $ra 
	addi	$sp,$sp,4 #deallocate the stack
	jr	$ra 	#return to caller
not_Empty: 
	addi	$sp,$sp,-4
	sw	$ra,0($sp)
	# list is not empty rearrange pointers
	jal	createNode
	# $v0->next = $a1(headptr)
	la	$t1,0($a1)
	sw	$t1,4($v0)
	# head = $v0 
	move	$a1,$v0 
	lw	$ra,0($sp)
	addi	$sp,$sp,4
jr 	$ra # return to calling function

.globl size
size: 
jr 	$ra # return to calling function

# Iterate list and print each node until null is reached
.globl printList
printList: 
jr	$ra # return to calling function

# Reverse linked list with pointers 
.globl reverse
reverse: 
jr	$ra # return to calling function

# Reassign headptr to null
.globl clear
clear: 
jr	$ra # return to calling function 

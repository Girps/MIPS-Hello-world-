# Author: Jesse Jimenez
# Date  : 5/23/2022 
# Purpose: Implement a linked list data structure in MIPS

.data 
fwdBracket: 	.asciiz "["
space:		.asciiz " "
bckBracket:	.asciiz "]"
link:		.asciiz "---"
nullSym:		.asciiz "NULL"
menu:		.asciiz "Press a key for the following selections\n1)Add node\n2)Print list\n3)Reverse list\n4)List size\55)Clear list6)End program "
table:		.word default,case1,case2,case3,case4,case5,case6 # array of addresses  

.text #source code
.globl main
main: 	
	default: 
	
	case1: # Ask user input for integer and allocate memory on the heap 
		 
	case2: # Print nodes in the list
	
	case3: # Reverse linked list
	
	case4: # Get list size
	
	case5: # Clear list 
	
	case6: # End program 
	

#Terminate program
li $v0, 10 
syscall 

# createNode() allocate memory in the heap initalize data memebers and return pointer to new node
.globl create_Node
create_Node: 
jr	$ra #return to calling function

# Reassigns head pointer to new node and assigns new node in the list
.globl add_List
add_List: 
jr 	$ra # return to calling function

.globl size
size: 
jr 	$ra # return to calling function

# Iterate list and print each node until null is reached
.globl print_List
print_List: 
jr	$ra # return to calling function

# Reverse linked list with pointers 
.globl reverse
reverse: 
jr	$ra # return to calling function

# Reassign headptr to null
.globl clear
clear: 
jr	$ra # return to calling function 
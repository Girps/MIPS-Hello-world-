
# Jesse Jimenez
.data # data allocation

arr:    .asciiz "Hello world\n"

.text # source code

la  $a0, arr
li  $v0,4 # print string
syscall 



#Terminate program
li $v0, 10 
syscall 

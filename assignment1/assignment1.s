	.file	"code.c"             #Directive for  the compiled c file
	.text 						 #Directive  for the text segment
	.globl	calculateFrequency   #Directive for making the calculatefrequency function scope Global 
	.type	calculateFrequency, @function #Directive for the type of calculateFrequency is a function
calculateFrequency:              #The start of the function implementation
.LFB0:            				 #Label serves as the marker for the start of the basic block of the function
	.cfi_startproc               #Debugging directive indicating the start of a new procedure 
	endbr64                      # indicates that code is part of the basic block and sets up control flow tracking for that block
	pushq	%rbp                 #Pushes the value of base register onto the stack
	.cfi_def_cfa_offset 16       #Debugging Directive setting the CFA offset to be 16 bytes 
	.cfi_offset 6, -16           #directive indicating that the previous value of base register is  stored at an offset of -16 from the current  CFA
	movq	%rsp, %rbp           #setting new stack base pointer
	.cfi_def_cfa_register 6      #directive informing the debugger that rbp is used as the base register for the current funvtion stack frame
	movq	%rdi, -24(%rbp)      #storing the first argument of the calculatefrequency function at an offset of -24 bytes from the base register, storing the pointer to arr1
	movl	%esi, -28(%rbp)      #storing the second  argument of the calculatefrequency function at an offset of -28 bytes from the base register,storing the value of n
	movq	%rdx, -40(%rbp)      #storing the third argument of the calculatefrequency function at an offset of -40 bytes from the base register, storing the pointer to fr1
	movl	$0, -12(%rbp)        #initialising value 0 at -12 bytes offset from the base register , initialising value of i=0 in calculate frequency
	jmp	.L2                      #uncondintional jump to L2
.L7:                             #start of L7 Label
	movl	$1, -4(%rbp)         #initilasing value 1 at -4 bytes offset from the base register , initialising the value of ctr=1 in calculate frequency
	movl	-12(%rbp), %eax      #storing the value of -12(rbp) in eax ,storing the value of i in eax
	addl	$1, %eax             #increasing the value of eax by 1 ,increasing the value of i by 1 ;i=i+1
	movl	%eax, -8(%rbp)       #storing the value of eax in -8 bytes offset from rbp ,storing the increased value of i in -8 bytes from rbp
	jmp	.L3                      #unconditional jump to L3
.L5:							 #start of label 5 
	movl	-12(%rbp), %eax      #store the value of -12(rbp) in eax, store the value of i in eax register
	cltq                         #convert double word to quad word and store in rax register ,stores value of i                                                                                                                                
	leaq	0(,%rax,4), %rdx     #multiply the value of rax register with 4 and add 0 and store the value in rdx, multiply the value of i with 4 for the accessing the element arr1[i] 
	movq	-24(%rbp), %rax      #stores the pointer address value of arr1 in -24(rbp) to rax
	addq	%rdx, %rax           #add the value of rdx with address value of rax and store in rax,stores the pointer address of arr1[i]
	movl	(%rax), %edx         #move the value stored at pointer address stored in rax into edx register ,storing the value of arr1[i] in edx register                                                                   
	movl	-8(%rbp), %eax       #store the value of -8(rbp) in eax,storing the value of j in eax register
	cltq						 #convert double word to quad word and stores in rax register, stores the value of j
	leaq	0(,%rax,4), %rcx     #multiply the value of rax register with 4 and add 0 and store in rcx register, multiply the value of j with 4 for accessing the element arr1[j]
	movq	-24(%rbp), %rax      #stores the pointer address value of arr1 in -24(rbp) to rax
	addq	%rcx, %rax           #adding the value of rcx with address value stored at rax and store in rax, stores the pointer address to arr1[j]
	movl	(%rax), %eax         #move the value stored at pointer address stored in rax into eax register ,stores the value of arr1[j] value 
	cmpl	%eax, %edx           #compares the value of eax and edx ,compares arr1[i] and arr1[j] and stores the result in processor flags
	jne	.L4                      #jump to L4 if values in eax and edx registers are not equal
	addl	$1, -4(%rbp)         #increases the value of -4(rbp) by 1, increasing the value of ctr ;ctr++ is executed 
	movl	-8(%rbp), %eax       #storing the value of -8(rbp) into eax register,storing the value of j into eax register
	cltq						 #convert double word to quad word and stores in rax register, stores the value of j
	leaq	0(,%rax,4), %rdx     #multiply the value of rax register with 4 and add 0 and store in rdx register, multiply the value of j with 4 for accessing the element fr1[j]
	movq	-40(%rbp), %rax      #stores the pointer address value of fr1 in -40(rbp) to rax
	addq	%rdx, %rax           #adding the value of rdx with address value stored at rax and store in rax, stores the pointer address to fr1[j]
	movl	$0, (%rax)           #storing the value 0 at address pointed by pointer ,fr1[j]=0
.L4:                             #start of label L4
	addl	$1, -8(%rbp)         #adding a value 1 to -8(rbp) and storing in -8(rbp),increasing the value of j by 1
.L3:							 #start of Label L3
	movl	-8(%rbp), %eax       #moving the value at -8 bytes offset from rbp into eax ,storing the value i+1 in eax
	cmpl	-28(%rbp), %eax      #comparing the value of -28(rbp) and eax, executing the logical statemnt j<n
	jl	.L5                      #if eax value is less than -28(rbp) jump to L5, i.e if j<n execute the for loop which calculates the frequency and updates fr1 array
	movl	-12(%rbp), %eax      #stores the value of -12(rbp) into eax register ,stores the value of i
	cltq                         #convert double word to quad word and stores in rax register, stores the value of i
	leaq	0(,%rax,4), %rdx     #multiply the value of rax register with 4 and add 0 and store the value in rdx, multiply the value of i with 4 for the accessing the element fr1[i] 
	movq	-40(%rbp), %rax      #stores the pointer address value of fr1 in -40(rbp) to rax
	addq	%rdx, %rax           #adding the value of rdx with address value stored at rax and store in rax, stores the pointer address to fr1[i]
	movl	(%rax), %eax         #move the value stored at the address pointed by the pointer into eax, stores fr1[i] 
	testl	%eax, %eax           #performs a bitwise AND operation ,sets the Zero flag if the result is zero, checking wether fr1[i]!=0 
	je	.L6                      #jump to label L6 if zero flag is set ,fr1[i]=0 so going to L6 to increase the value of i and enter next iteration
	movl	-12(%rbp), %eax      #stores the value of -12(rbp) into eax register ,stores the value of i
	cltq                         #convert double word to quad word and stores in rax register, stores the value of i
	leaq	0(,%rax,4), %rdx     #multiply the value of rax register with 4 and add 0 and store the value in rdx, multiply the value of i with 4 for the accessing the element fr1[i] 
	movq	-40(%rbp), %rax      #stores the pointer address value of fr1 in -40(rbp) to rax
	addq	%rax, %rdx           #adding the value of rdx with address value stored at rax and store in rdx, stores the pointer address to fr1[i]
	movl	-4(%rbp), %eax       #storing the value of -4(rbp) into eax register ,storing the value of ctr into eax register
	movl	%eax, (%rdx)         #move the value stored in eax register to the address pointed by the pointer into rdx, executes  fr1[i] = ctr
.L6:                             #start of label L6
	addl	$1, -12(%rbp)        #increases the value of -12(rbp) by 1 ,increasing the value of i by 1
.L2:                             #Start of L2 Label
	movl	-12(%rbp), %eax      #moving value stored at -12 bytes offset from base register into eax register
	cmpl	-28(%rbp), %eax      #comparing the value of -28 bytes offset from rbp and value in eax,result stored in processor flags ,executing the logical statement(i<n)
	jl	.L7                      #if value in eax is less than -28(rbp) , jump to l7, if i<n the function enters the for loop
	nop                          #used for padding or other purposes 
	nop                          #using for padding or other purposes 
	popq	%rbp                 #pops the value of base pointer from the stack
	.cfi_def_cfa 7, 8            #specifies the value of new stack pointer and offset from this new Frame is 8 bytes 
	ret                          #pops return address from the stack 
	.cfi_endproc                 #directive for ending the procedure
.LFE0:                           #start of label LFE0
	.size	calculateFrequency, .-calculateFrequency  #specifying the size of the calculateFrequency operation
	.section	.rodata          #define a read only data section
.LC0:                            #start of label LC0
	.string	"Element\tFrequency" #defines the String which will be used for printing the output
.LC1:                            #start of label LC1
	.string	"%d\t%d\n"           #defines the string which will be used in printing the output of the array
	.text                        # Directive for text segment
	.globl	printArrayWithFrequency #Directive for global scope of printArrayWithFrequency Function
	.type	printArrayWithFrequency, @function #Directive for type of the printArrayWithFrequency and declaring it as a function
printArrayWithFrequency:         #the start of function implementation
.LFB1:                           #Label serves as the marker for the start of the basic block of the function
	.cfi_startproc               #Debugging directive indicating the start of a new procedure
	endbr64						 #indicates that code is part of the basic block and sets up control flow tracking for that block
	pushq	%rbp				 #Pushes the value of base register onto the stack
	.cfi_def_cfa_offset 16       #Debugging Directive setting the CFA offset to be 16 bytes 
	.cfi_offset 6, -16           #directive indicating that the previous value of base register is  stored at an offset of -16 from the current  CFA
	movq	%rsp, %rbp           #setting new stack base pointer
	.cfi_def_cfa_register 6      #directive informing the debugger that rbp is used as the base register for the current funvtion stack frame
	subq	$48, %rsp            #adjusting the stack pointer for allocating space for local variables 
	movq	%rdi, -24(%rbp)      #storing the first argument of the printArraywithFrequency function at an offset of -24 bytes from the base register, storing the pointer to arr1
	movq	%rsi, -32(%rbp)      #storing the second argument of the printArraywithFrequency function at an offset of -32 bytes from the base register, storing the pointer to fr1
	movl	%edx, -36(%rbp)      #storing the third  argument of the printArraywithFrequency function at an offset of -36 bytes from the base register,storing the value of n
	leaq	.LC0(%rip), %rax     #address of the string in LC0 is stored in rax register
	movq	%rax, %rdi           #address stored in rax is passed into rdi to prepare for function call of 'puts'
	call	puts@PLT             #puts is a standard library function that prints a null terminated string
	movl	$0, -4(%rbp)         #moving the value 0 into -4(rbp),initialising the value of i to 0
	jmp	.L9                      #unconditional jump to label L9
.L11:                            #start of label L11
	movl	-4(%rbp), %eax       #moving the value of -4(rbp) into eax register,storing the value of i in eax register
	cltq                         #convert double word to quad word and stores in rax register, stores the value of i
	leaq	0(,%rax,4), %rdx     #multiply the value of rax register with 4 and add 0 and store the value in rdx, multiply the value of i with 4 for the accessing the element fr1[i] 
	movq	-32(%rbp), %rax      #stores the pointer address value of fr1 in -32(rbp) to rax register
	addq	%rdx, %rax           #adding the value of rdx with address value stored at rax and store in rax, stores the pointer address to fr1[i]
	movl	(%rax), %eax         #move the value stored at the address pointed by the pointer into eax, stores fr1[i] 
	testl	%eax, %eax           #performs a bitwise AND operation ,sets the Zero flag if the result is zero, checking wether fr1[i]!=0 
	je	.L10                     #jump to label L10 if zero flag is set ,fr1[i]=0 so going to L10 to increase the value of i and enter next iteration
	movl	-4(%rbp), %eax       #moving the value of -4(rbp) into eax register,storing the value of i in eax register
	cltq                         #convert double word to quad word and stores in rax register, stores the value of i
	leaq	0(,%rax,4), %rdx     #multiply the value of rax register with 4 and add 0 and store the value in rdx, multiply the value of i with 4 for the accessing the element fr1[i] 
	movq	-32(%rbp), %rax      #stores the pointer address value of fr1 in -32(rbp) to rax register
	addq	%rdx, %rax           #adding the value of rdx with address value stored at rax and store in rax, stores the pointer address to fr1[i]
	movl	(%rax), %edx         #move the value stored at the address pointed by the pointer into edx, stores fr1[i] 
	movl	-4(%rbp), %eax       #moving the value of -4(rbp) into eax register,storing the value of i in eax register
	cltq                         #convert double word to quad word and stores in rax register, stores the value of i
	leaq	0(,%rax,4), %rcx     #multiply the value of rax register with 4 and add 0 and store the value in rcx, multiply the value of i with 4 for the accessing the element arr1[i] 
	movq	-24(%rbp), %rax      #stores the pointer address value of arr1 in -24(rbp) to rax register
	addq	%rcx, %rax           #adding the value of rcx with address value stored at rax and store in rax, stores the pointer address to arr1[i]
	movl	(%rax), %eax         #move the value stored at the address pointed by the pointer into eax, stores arr1[i] 
	movl	%eax, %esi           #move the value stored in eax to esi register,stores arr1[i]
	leaq	.LC1(%rip), %rax     #address of the string in LC1 is stored in rax register
	movq	%rax, %rdi           #address stored in rax is passed into rdi to prepare for function call of 'printf'
	movl	$0, %eax             #stores 0 value in eax register
	call	printf@PLT           #calls the printf function and prints the arguments passed in esi,edx and eax registers ,hence printing arr1[i] and fr1[i]
.L10:                            #start of Label L10
	addl	$1, -4(%rbp)         #adding a value of 1 to the value at -4(rbp),increasing the value of i by 1
.L9:                             #start of Label L9
	movl	-4(%rbp), %eax       #moving the value of -4(rbp) into eax register,storinf the value of i
	cmpl	-36(%rbp), %eax      #comparing the value of -36(rbp) and eax ,executing the statement i<n
	jl	.L11                     #jump to label L11 if the value of eax is less than -36(rbp);i.e , i<n
	nop                          #used for padding or other purposes
	nop                          #used for padding or other purposes
	leave                        #used to release the current stack frame
	.cfi_def_cfa 7, 8            #specifies the value of new stack pointer and offset from this new Frame is 8 bytes 
	ret                          #pops return address from the stack
	.cfi_endproc                 #directive for ending the procedure
.LFE1:                           #start of label LFE1
	.size	printArrayWithFrequency, .-printArrayWithFrequency  #specifying the size of the printArrayWithFrequency operation
	.section	.rodata          #define a read only data section
	.align 8                     #align the memory location to 8 byte boundary
.LC2:                            #start of label LC2
	.string	"\n\nCount frequency of each integer element of an array:"  #defines the String which will be used for printing the output
	.align 8                     #align the memory location to 8 byte boundary
.LC3:                            #start of label LC3
	.string	"------------------------------------------------"   #defines the String which will be used for printing the output
	.align 8                     #align the memory location to 8 byte boundary
.LC4:                            #start of Label LC4
	.string	"Input the number of elements to be stored in the array :" #defines the String which will be used for printing the output
.LC5:                            #start of Label LC5
	.string	"%d"                 #defines the string which will be used in printing the output of the array
	.align 8                     #align the memory location to 8 byte boundary
.LC6:                            #start of label LC6
	.string	"Enter each elements separated by space: "  #defines the string which will be used in printing the output of the array
	.text                        #Directive  for the text segment
	.globl	main                 #Directive for making the main function scope Global 
	.type	main, @function      #Directive for the type of main is a function
main:                            #start of main function implementation
.LFB2:                           #start of label LFB2
	.cfi_startproc               #Debugging directive indicating the start of a new procedure
	endbr64                      #indicates that code is part of the basic block and sets up control flow tracking for that block
	pushq	%rbp                 #Pushes the value of base register onto the stack
	.cfi_def_cfa_offset 16       #Debugging Directive setting the CFA offset to be 16 bytes 
	.cfi_offset 6, -16           #directive indicating that the previous value of base register is  stored at an offset of -16 from the current  CFA
	movq	%rsp, %rbp           #setting new stack base pointer
	.cfi_def_cfa_register 6      #directive informing the debugger that rbp is used as the base register for the current funvtion stack frame
	subq	$832, %rsp           #adjusting the stack pointer for allocating space for local variables 
	movq	%fs:40, %rax         #stores the value at a offset of 40 bytes from fs register into rax register 
	movq	%rax, -8(%rbp)       #moves the value stored in rax register to -8(rbp)
	xorl	%eax, %eax           #XOR opearion on eax itself makes all the bits of eax to be zero
	leaq	.LC2(%rip), %rax     #address of the string in LC2 is stored in rax register
	movq	%rax, %rdi           #address stored in rax is passed into rdi to prepare for function call of 'puts'
	call	puts@PLT             #puts is a standard library function that prints a null terminated string
	leaq	.LC3(%rip), %rax     #address of the string in LC3 is stored in rax register
	movq	%rax, %rdi           #address stored in rax is passed into rdi to prepare for function call of 'puts'
	call	puts@PLT             #puts is a standard library function that prints a null terminated string
	leaq	.LC4(%rip), %rax     #address of the string in LC4 is stored in rax register
	movq	%rax, %rdi           #address stored in rax is passed into rdi to prepare for function call of 'printf'
	movl	$0, %eax             #storing value 0 in eax register for execution of printf
	call	printf@PLT            #prints the arguments passed into rdi register 
	leaq	-828(%rbp), %rax     #loads the address of -828(rbp) into rax register ,for storing the value of n
	movq	%rax, %rsi           #move the value in rax register to rsi register
	leaq	.LC5(%rip), %rax     #address of the string in LC5 is stored in rax register
	movq	%rax, %rdi           #address stored in rax is passed into rdi to prepare for function call of 'scanf'
	movl	$0, %eax             #storing value 0 in eax register for execution of scanf
	call	__isoc99_scanf@PLT   #calling the scanf function with the passed arguments ,taking input of n and stores at -828(rbp)
	leaq	.LC6(%rip), %rax     #address of the string in LC6 is stored in rax register
	movq	%rax, %rdi           #address stored in rax is passed into rdi to prepare for function call of 'printf'
	movl	$0, %eax             #storing value 0 in eax register for execution of printf
	call	printf@PLT           #prints the arguments passed into rdi register 
	movl	$0, -824(%rbp)       #stores the value 0 at -824(rbp) ,initialises i value to 0
	jmp	.L13                     #unconditional jump to label L13
.L14:                            #start of Label L14 
	leaq	-816(%rbp), %rdx     #loads the address of -816(rbp) into rdx register
	movl	-824(%rbp), %eax     #store the value of -824(rbp) into eax register
	cltq                         #convert double word to quad word and stores in rax register, stores the value of i
	salq	$2, %rax             #perfroms a left shift of 2 bits on the value in rax register,indirectly multiplying the original number i with 4 to go to address of arr1[i] for input 
	addq	%rdx, %rax           #adding the value in rdx to rax and storing in rax register.stores the address of pointer  arr1[i]
	movq	%rax, %rsi           #storing value of rax into rsi for providing the address of arr1[i] in subsequent steps as an argument
	leaq	.LC5(%rip), %rax     #address of the string in LC5 is stored in rax register
	movq	%rax, %rdi           #address stored in rax is passed into rdi to prepare for function call of 'scanf'
	movl	$0, %eax             #storing value 0 in eax register for execution of scanf
	call	__isoc99_scanf@PLT   #calling the scanf function with the passed arguments ,taking input of arr1[i] and stores at -828(rbp)
	addl	$1, -824(%rbp)       #storing the value of 1 into -824(rbp),increasing the value of i by 1 for next iteration
.L13:                            #start of label L13 
	movl	-828(%rbp), %eax     #loads the value of -828(rbp) into eax register loads the value of n
	cmpl	%eax, -824(%rbp)     #compares the values in both registers, checking the statement i<n
	jl	.L14                     #jump to label L14 if i<n
	movl	$0, -820(%rbp)       #stores the value 0 into -820(rbp) ,intialises i with value 0 for second for loop for setting frequencies fr1[i]=-1
	jmp	.L15                     #unconditional jump  L15
.L16:                            #start of label L16 
	movl	-820(%rbp), %eax     #stores the value of -820(rbp) into eax register,stores the value of i 
	cltq                         #convert double word to quad word and stores in rax register, stores the value of i
	movl	$-1, -416(%rbp,%rax,4)#stores the value of -1 at the address of rbp+rax*4 i.e fr1[i]=-1
	addl	$1, -820(%rbp)       #loads 1 into -820(rbp), increases the value of i by 1 
.L15:                            #start of Label L15
	movl	-828(%rbp), %eax     #loads the value of -828(rbp) into eax register loads the value of n
	cmpl	%eax, -820(%rbp)     #compares the values in both registers, checking the statement i<n
	jl	.L16                     #jump to label L14 if i<n
	movl	-828(%rbp), %ecx     #loads the value of n into ecx register 
	leaq	-416(%rbp), %rdx     #loads the pointer address of fr1 array for passing as argument
	leaq	-816(%rbp), %rax     #loads the pointer address of arr1 array 
	movl	%ecx, %esi           #loads the value of ecx into esi register for passing as argument 
	movq	%rax, %rdi           #loads the value of rax into rdi register for passing as argument
	call	calculateFrequency   #calling the calculate frequency function
	movl	-828(%rbp), %edx     #loads the value of n into ecx register
	leaq	-416(%rbp), %rcx     #loads the pointer address of fr1 array
	leaq	-816(%rbp), %rax     #loads the pointer address of arr1 array 
	movq	%rcx, %rsi           #loads the value of rcx into rsi register for passing as argument 
	movq	%rax, %rdi           #loads the value of rax into rdi register for passing as argument
	call	printArrayWithFrequency #calling the printArrayWithFrequency function
	movl	$0, %eax             #storing value 0 in eax register 
	movq	-8(%rbp), %rdx       #moves the value of -8(rbp) into register rdx
	subq	%fs:40, %rdx         #subtracts the value at 40 bytes offset from fs register and rdx and stores in rdx register
	je	.L18                     #if the subtraction is zero,jump to label L18
	call	__stack_chk_fail@PLT #instruction that checks stack corruption or stack tampering
.L18:                            #start of Label L18
	leave                        #used to release the current stack frame
	.cfi_def_cfa 7, 8            #specifies the value of new stack pointer and offset from this new Frame is 8 bytes 
	ret                          #pops return address from the stack
	.cfi_endproc                 #directive for ending the procedure
.LFE2:                           #start of Label LFE2
	.size	main, .-main         #specifying the size of the main function
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0" #provides information about the source of the compiled code
	.section	.note.GNU-stack,"",@progbits #creates a new section controlling the stack
	.section	.note.gnu.property,"a"       #creaton of another section with an attribute 
	.align 8                      #align the memory location to 8 byte boundary
	.long	1f - 0f               #calculates the difference between the labels,represents offset between the labels
	.long	4f - 1f               #calculates the difference between the labels,represents offset between the labels
	.long	5                     # 4 byte integer literal value with value 5
0:                                #start of label 0
	.string	"GNU"                 #string GNU for debugger
1:                                #start of label 1 
	.align 8                      #align the memory location to 8 byte boundary
	.long	0xc0000002            #specifies a 4 byte long integer with given value
	.long	3f - 2f               #calculates the difference between the labels,represents offset between the labels
2:                                #start of label 2
	.long	0x3                   #align the memory location to 8 byte boundary
3:                                #start of label 3
	.align 8                      #align the memory location to 8 byte boundary
4:                                #start of label 4

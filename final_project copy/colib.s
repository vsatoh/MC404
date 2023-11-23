.text
.globl set_engine
set_engine:

    li a7, 10

    ecall

    ret

.globl set_handbrake
set_handbrake:

    li a7, 11

    ecall
    
    ret

.globl read_sensor_distance
read_sensor_distance:   

    li a7, 13
    
    ecall

    ret

.globl get_position

get_position:

    li a7, 15

    ecall 

    ret
    
.globl get_rotation
get_rotation:

    li a7, 16

    ecall 

    ret

.globl get_time

get_time:

    li a7, 20

    ecall 

    ret

    ret
.globl puts

puts:

 li t0, 0

    li t1, 0

    mv t2, a0

    puts_loop:

        lb t3, 0(t2)                # Loads the next byte of the string

        beq t3, t0, puts_loop_done  # If it is equal to 0, the loops is done

        addi t1, t1, 1              # Else, increments 1 to the counter

        addi t2, t2, 1              # adds 1 to the address of the string

        j puts_loop

    puts_loop_done:
        
        add t4, a0, t1          # Puts the '\n' at the end of the string
        li t0, '\n'
        sb t0, 0(t4)


        # Write ecall
        addi t1, t1, 1
        mv a1, t1
        li a7, 18
        ecall


        li t0, 0            # Store the '\0' back to the end of the string 
        sb t0, 0(t4)


        ret


.globl gets
gets:
/*
    Receives in a0 the adress of the string that will save the input
    
    Return in a0 the adress of the string
*/
    mv t0, a0       # saving the adress to iterate
    mv t3, a0       # saving the address to return in the end
    1:
    # iterating and putting into the string
        mv a0, t0           # loading the address
        li a1, 1            # have only 1 byte
        li a7, 17           # syscall read (63)
        ecall
        becall:
        lb t1, 0(t0)        # checking if the byte is '\n'
        li t2, '\n'         
        beq t1, t2, 1f      # if it is equal, than finish the loop

        addi t0, t0, 1      # next term
        j 1b                # looping
    1:
        li t1, 0         
        sb t1, 0(t0)        # storing the value '\0' and putting in the end of the string

    mv a0, t3               # returning the value to a0
    
    ret 
.globl atoi
atoi:
    # Recieves an string in a0 and returns the int value associated with it
    addi sp, sp, -4
    sw ra, 0(sp)     
            


    for_loop_atoi:                  # For loop that iterates over the string in a0 until it finds a character that is not equal to a whitespace

        # Reads next byte
        lb a1, 0(a0)


        li t0, ' '

        bne a1, t0, not_whitespace

        addi a0, a0, 1


        j for_loop_atoi

    not_whitespace:
        # When it finds the non-whitespace character, checks if it is a plus, a minus signal or none of them
        li t2, '+'
        li t3, '-'

        beq a1, t2, positive
        beq a1, t3, negative


        not_signed:     # If it is not signed, then the digit is already a part of the number

            jal ra, char_to_positive_int    # Sends it to char_to_positive_int function

            
            lw ra, 0(sp)
            addi sp, sp, 4   # Gets back the ra value stored in s0 and returns

            ret
        

        positive:
            # If it is a positive number, we skip the signal and call the char_to_positive_int function
            addi a0, a0, 1  

            jal ra, char_to_positive_int

            lw ra, 0(sp)
            addi sp, sp, 4 

            ret

        negative:
            # If it is a negative number, we skip the singal
            addi a0, a0, 1
            
            jal ra, char_to_positive_int        # Call the char_to_positive_int function

            li t0, -1

            mul a0, a0, t0          # and then multiply the result of that function by -1

            lw ra, 0(sp)
            addi sp, sp, 4 

            ret


char_to_positive_int:
    # String comes in a0

    addi sp, sp, -4

    sw ra, 0(sp)

    li a2, 0

    li a3, 0


    ctpi_loop:     
        # Loop that iterates over the string and calculates the integer value that corresponds to it
        li t0, 1

            lb a1, 0(a0)

            # Once the char is read, we keep in the loop until a non number digit is found 

            li t1, '0'
            li t3, '9'
            li t2, 10
            
            
            blt a1, t1, done        # If the digit read is smaller than '0' or greater than '9', we are done looping
            blt t3, a1, done
            
            
            addi a1, a1, -48        # Calculates the int value that corresponds to the digit read
            
            mul a2, a2, t2      # Multiplies the constant corresponded to the index of iteration, i.e t0, by 10
            add a2, a2, a1      # Adds the new number to this constant

            addi a0, a0, 1 

        j ctpi_loop

    done:
        
        mv a0, a2       # Once we are done, we store the integer value in a0 and return

        lw ra, 0(sp)        

        add sp, sp, 4

        ret



.globl itoa
itoa:
    # Function that recieves a int value in a0, the buffer to be filled in a1 and the base in a2

    addi sp, sp, -4

    sw ra, 0(sp)

    li t0, 10

    li t1, 16

    beq a2, t0, decimal_case

    beq a2, t1, hexadecimal_case

    decimal_case:
        
        jal ra, itoa_decimal

        lw ra, 0(sp)

        addi sp, sp, 4

        ret

    hexadecimal_case:

         
        jal ra, itoa_hexadecimal

        lw ra, 0(sp)

        addi sp, sp, 4

        ret



itoa_decimal:   

    # Function that recieves a int value in a0, the buffer to be filled in a1 and the base in a2



    addi sp, sp, -4     

    sw ra, 0(sp)

    li t1, 16

    li t2, 10

    li t3, 0       

    mv t4, a1 



    blt a0, t3, negative_number

    j loop_decimal

    negative_number:

        li t0, '-'

        sb t0, 0(t4)

        addi t4, t4, 1

        li t0, -1

        mul a0, a0, t0




    loop_decimal:

        # Loops that gets the char digits that correspondes to the number checked and stacks these digits in the stack
       
        beqz a0, done_decimal        # if the value of a0 is 0, then the loop's done

        rem t0, a0, t2                      # Gets in a2 the remainder of the division of a0 by 10


        addi t0, t0, 48                 # Gets the integer that correspond to the digit checked

        addi sp, sp, -4                 # Stacks the digit 

        sb t0, 0(sp)



        # Once the calculus of the digit is already done, we update a0 by the result of division of a0 by 10 

        div a0, a0, t2          

        addi t3, t3, 1          # Increments 1 to the counter of the number of digits necessary to write the number in hexadecimal

        j loop_decimal

        
    done_decimal:

        beqz t3, zero_case          # Checks if the number to be printed equals to 0

    unstack_decimal_loop:   
        # Else, we go into the loop to unstack the digits stacked in the previous loop and write them

        beqz t3, unstack_decimal_done               # If we reach 0 with the counter, we are done unstacking

        
        lb t0, 0(sp)                    # Else, we unstack the byte 

        addi sp, sp, 4

        # Writes the byte in the string 

        sb t0, 0(t4)

        addi t4, t4, 1


        # Decrements 1 to the counter

        addi t3, t3, -1

        j unstack_decimal_loop

    
    zero_case_decimal:

        li t0, '0'          # If the number is 0, we write a 0 (edge case)

        sb t0, 0(t4)

        addi t4, t4, 1


    unstack_decimal_done:

        li t0, 0     # Once the unstacking is done, we store a \0 at the end of the string  

        sb t0, 0(t4)

        mv a0, a1
    
        lw ra, 0(sp)

        addi sp, sp, 4

        ret





itoa_hexadecimal:
    # The number comes in a0, the string in a1 and the base in a2

    addi sp, sp, -4

    sw ra, 0(sp)

    li t1, 16           

    li t2, 10       

    li t3, 0            # Initializes the counter

    mv t4, a1

    loop_hexadecimal:

        # Loop that gets the remainder of the division of a0 by 16 and stores it in the stack until the value of a0 is 0

        beqz a0, done_hexadecimal        # if the value of a0 is 0, then the loop's done

        rem a2, a0, t1                      # Gets in a2 the remainder of the division of a0 by 16

        calculates_digit:

            blt a2, t2, smaller_than_10     # Checks if the number in a2 is smaller or greater than 10

            j bigger_than_10

            smaller_than_10:

                # Gets the char digit asscoiated with the number in a2 and stores it in the stack

                addi a2, a2, 48     

                addi sp, sp, -4

                sb a2, 0(sp)

                j digit_done

            
            bigger_than_10:

                # Gets the char digit asscoiated with the number in a2 and stores it in the stack

                addi a2, a2, 55

                addi sp, sp, -4

                sb a2, 0(sp)

        digit_done:

            # Once the calculus of the digit is already done, we update a0 by the result of division of a0 by 16 

            div a0, a0, t1

            addi t3, t3, 1          # Increments 1 to the counter of the number of digits necessary to write the number in hexadecimal

            j loop_hexadecimal 

        
    done_hexadecimal:

        beqz t3, zero_case      # If the number is 0, we write a 0 and a \n

    

    unstack_for:

        beqz t3, unstack_done       # If we the counter reaches 0, we are done with the unstacking

        
        lb t0, 0(sp)            # Else, we unstack another byte from the stack

        addi sp, sp, 4

        # Write the byte unstacked


        sb t0, 0(t4)

        addi t4, t4, 1


        addi t3, t3, -1  # Decrements the counter by 1

        j unstack_for

    
    zero_case:

        li t0, '0'      # Writes a 0 

        sb t0, 0(t4)

        addi t4, t4, 1
        


    unstack_done:

        li t0, 0       # Writes a 0 and returns

        sb t0, 0(t4)

        mv a0, a1
    
        lw ra, 0(sp)

        addi sp, sp, 4          # Unstack the return adress and returns to that point

        ret 

.globl strlen_custom

strlen_custom:  
    # Function that returns the lenght of a string without the 0

    mv t0, a0       # Moves the initial address of the string to t0

    li t1, 0

    li t2, 0 # Starts the counter

    strlen_loop:

        lb t3, 0(t0)        # Reads next byte

        beq t3, t1, strlen_finished     # If the next byte is equal to 0, we exit the loop

        addi t2, t2, 1          # Else we increment 1 to the counter and to the string's pointer

        addi t0, t0, 1

        j strlen_loop       

    strlen_finished:

        mv a0, t2

        ret


        
.globl approx_sqrt
approx_sqrt:

    # Function that calculates the approximate square root of a number using the babilonian method

    # The number which the sqrt we have to calculate comes in a0 and the number of iterations in a1

    li t0, 0    # Starts the counter

    li t1, 2

    mv t2, a0

    bab_loop:

        beq t0, a1, bab_done

        divu t3, a0, t2 

        add t3, t3, t2 

        divu t3, t3, t1

        mv t2, t3

        addi t0, t0, 1

        j bab_loop

    bab_done:

    mv a0, t2

    ret




.globl get_distance
get_distance:
  # Saves the ra

    addi sp, sp, -4

    sw ra, 0(sp)


    # Makes the subtraction between the a and b coordinates
    sub t0, a0, a3

    sub t1, a1, a4

    sub t2, a2, a5

    # Squares these subtractions
    
    mul t0, t0, t0

    mul t1, t1, t1

    mul t2, t2, t2


    # Adds them all
    add t0, t0, t1

    add t0, t0, t2

    mv a0, t0

    li a1, 25

    # Computes the sqrt

    jal ra, approx_sqrt


    # Loads back the ra and saves it 
    lw ra, 0(sp)

    addi sp, sp, 4

    ret 



.globl fill_and_pop

fill_and_pop:
    # Recieves the head node in a0 and the fill node in a1

    li t0, 0        # Starts the counter

    li t1, 8

    mv t3, a0

    mv t4, a1

    copy_loop:              # For loop that copies all of the 8 atributes of the head node into de fill node

        beq t0, t1, copy_done       # If the counter reaches 8, it's done

        lw t2, 0(t3)            # Loads from head node a0

        sw t2, 0(t4)            # Stores in fill node a1

        addi t3, t3, 4          # Increments by 4 both pointers

        addi t4, t4, 4

        addi t0, t0, 1

        j copy_loop

    copy_done:


    lw a0, 28(a0)                # Checks if it is equal to 0

    beqz a0, final_case

    j normal_case

    final_case:

        li a0, -1

        ret
    
    normal_case:    
        ret 

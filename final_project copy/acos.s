
.bss

.align 4
isr_stack: .skip 512
isr_stack_end:

.text

.set gpt,      0xFFFF0100
.set car,      0xFFFF0300
.set serial_port,   0xFFFF0500

.globl _start
      
_start:

    li sp, 0x07FFFFFC 

    la t0, int_handler  # Load the address of the routine that will handle interrupts

    csrw mtvec, t0      # (and syscalls) on the register MTVEC to set
                      # the interrupt array.

    la a0, isr_stack_end # t0 <= base da pilha

    csrw mscratch, a0 


    csrr t1, mstatus        # Update the mstatus.MPP
    li t2, ~0x1800          # field (bits 11 and 12)
    and t1, t1, t2          # with value 00 (U-mode)
    csrw mstatus, t1
 
    la t0, main        # Loads the user software
    csrw mepc, t0           # entry point into mepc

    mret

   
    
int_handler:
/*
    Syscall and Interrupts handler
*/
    stacking:
    # We first save the context
    csrrw sp, mscratch, sp
    addi sp, sp, -64

    sw t0, 0(sp)

    sw t1, 4(sp)

    sw t2, 8(sp)

    sw t3, 12(sp)

    sw t4, 16(sp)

    sw t5, 20(sp)

    sw t6, 24(sp)

    sw a1, 28(sp)

    sw a2, 32(sp)

    sw a3, 36(sp)

    sw a4, 40(sp)

    sw ra, 44(sp)
    
    # Then, based on the ecall that was called, we call the correspondent function to be executed


    li t0, 10                   # syscall engine and steering                  
    beq a7, t0, engine_syscall

    li t0, 11                   # syscall set hand break
    beq a7, t0, handbrake_syscall

    li t0, 12                   # syscall read sensors                
    beq a7, t0, sensors_syscall

    li t0, 13                   # syscall read sensor distance                
    beq a7, t0, sensor_distance_syscall

    li t0, 15                   # syscall get position
    beq a7, t0, position_syscall

    li t0, 16                   # syscall get rotation               
    beq a7, t0, rotation_syscall

    li t0, 17                   # syscall read serial                 
    beq a7, t0, read_serial_syscall

    li t0, 18                   # syscall write serial                
    beq a7, t0, write_serial_syscall

    li t0, 20                   # syscall get system time                
    beq a7, t0, get_time_syscall

    engine_syscall:     

        jal ra, set_engine

        j syscall_done

    handbrake_syscall:     

        jal ra, set_handbrake

        j syscall_done
    sensors_syscall:         
                    
        jal ra, read_sensors

        j syscall_done

    sensor_distance_syscall:   

        jal ra, read_sensors_distance

        j syscall_done

    position_syscall:       

        jal ra, get_position

        j syscall_done

    rotation_syscall:     

        jal ra, get_rotation

        j syscall_done

    read_serial_syscall:        
                     
        jal ra, read_serial

        j syscall_done
    write_serial_syscall:     

        jal ra, write_serial

        j syscall_done

    get_time_syscall:   
                           
        jal ra, get_systime

    syscall_done:

    # Once the function was already executed:
  
    csrr t0, mepc     # load return address (address of the instruction that invoked the syscall)
    addi t0, t0, 4    # adds 4 to the return address (to return after ecall) 
    csrw mepc, t0     # stores the return address back on mepc
    
   unstacking:
        # We unstack the context back

        lw t0, 0(sp)

        lw t1, 4(sp)

        lw t2, 8(sp)

        lw t3, 12(sp)

        lw t4, 16(sp)

        lw t5, 20(sp)

        lw t6, 24(sp)

        lw a1, 28(sp)

        lw a2, 32(sp)

        lw a3, 36(sp)

        lw a4, 40(sp)

        lw ra, 44(sp)

        addi sp, sp, 64            
        csrrw sp, mscratch, sp

    mret              


# Ecall funtions:

set_engine:

    # Ecall that sets the engine to go foward, to brake or to go backwards and the wheel direction

        li t0, car  

        # Checks if the value in ao (engine direction) is in the [-1, 1] interval. If not, it's an invalid entry

        li t1, -1

        li t2, 1

        blt a0, t1, invalid

        blt t2, a0, invalid

        # Checks if the value in a1 (wheel direction) is in the [-127, 127] interval. If not, it's an invalid entry

        li t1, -127

        li t2, 127

        blt a1, t1, invalid

        blt t2, a1, invalid

        # If all of the entries are valid, set the values to the MMIO prot

        sb a0, 0x21(t0)

        sb a1, 0x20(t0)

        
        li a0, 0

        ret


        invalid:    
            # If the entries are invalid, set the return as -1 
            li a0, -1

            ret

set_handbrake:

    li t0, car              # Sets the value in a0 to the MMIO correspondent to the handbrake

    beqz a0, valid

    li t1, 1

    beq a0, t1, valid

    li t1, -1

    beq a0, t1, valid

    li a0, -1

    

    ret

    valid: 

    sb a0, 0x22(t0)

    li a0, 0 

    ret

read_sensors:
        # Function that reads the image from the line camera and returns the adress of the first element of a 256 byte array
        li t0, car

        # Triggers the reading 
        li t2, 1

        sb t2, 0x01(t0)

        # Waits until the reading by the camera finishes

        busy_waiting_camera:

            lb t2, 0x01(t0)

            beqz t2, waiting_camera_done

            j busy_waiting_camera
        
        waiting_camera_done:
            # Once the reading by the camera is done we start a loop to cop

            mv t3, a0

            addi t0, t0, 36

            li t1, 0   # Starts the counter

            li t4, 256

            copying_loop:

                beq t1, t4, copying_done        # If we copied 256 bytes, then we exit the loop
                
                lb t2, 0(t0)                    # Else, we load the next t0 element

                sb t2, 0(t3)                    # and store it on the stirng given as entry

                addi t0, t0, 1                  # Then we increment both strings and the counter t1

                addi t3, t3, 1

                addi t1, t1, 1

                j copying_loop
            
            copying_done:
            
                ret

read_sensors_distance:

   li t0, car          
        
        # Triggers the ultrassonic sensor to check the distance in front of the car

        li t1, 1        

        sb t1, 0x2(t0)

        busy_waiting_ultrassonic:   # Waits for the reading to be done 

            lb t1, 0x2(t0)

            beqz t1, waiting_done_ultrassonic

            j busy_waiting_ultrassonic
        
        waiting_done_ultrassonic:
            # Gets the value read and puts into the return variable in .data section

            lw t1, 0x1C(t0)

            mv a0, t1 

            ret

get_position:
    
    li t0, car

    li t1, 1

    sb t1, 0(t0)    

    # Waits until the reading is done

    busy_waiting_position:

        lb t1, 0(t0)

        beqz t1, waiting_done_position

        j busy_waiting_position

    waiting_done_position:

        # Once the reading is finished, we get the x, y and z position and set them in their variables in .data section

        lw t1, 0x10(t0)

        sw t1, 0(a0)


        lw t1, 0x14(t0)

        sw t1, 0(a1)


        lw t1, 0x18(t0)

        sw t1, 0(a2)

        ret

get_rotation:
  # Triggers the position sensors to start the reading 
        li t0, car

        li t1, 1

        sb t1, 0(t0)    

        # Waits until the reading is done

        busy_waiting_rotation:

            lb t1, 0(t0)

            beqz t1, waiting_done_rotation

            j busy_waiting_rotation

        waiting_done_rotation:

            # Once the rotation data is read, we store the angle in x in a0, the angle in y in a1 and the angle in z in a2

            lw t1, 0x04(t0)

            sw t1, 0(a0)


            lw t1, 0x08(t0)

            sw t1, 0(a1)


            lw t1, 0x0C(t0)

            sw t1, 0(a2)

            ret

read_serial:
        
        mv t0, a0           # address to iterate
        mv t1, a1           # size to limitate the iteration
        li t2, serial_port  
        2:
            li t3, 1        
            sb t3, 0x02(t2)           # storing the value 1 to start to reads the next byte
            1:
                lb t3, 0x02(t2)         # checking the triggers
                beqz t3, 1f             # if it is zero, already read the byte
                j 1b                    
            1:
                lb t3, 0x03(t2)         # getting the byte
                sb t3, 0x00(t0)         # putting the byte into the string
                addi t1, t1, -1
                beqz t1, 2f
                addi t0, t0, 1          # next byte of the string
                j 2b                    # if the string is not ended, loops
        2:
        
        # getting the size
        mv t0, a0
        3:
            lb t1, 0(t0) 
            beqz t1, 3f
            addi t0, t0, 1
            j 3b
        3:

        sub a0, t0, a0

        ret

write_serial:
        # Writes down a string given
        # String address comes in a0 and it's size comes in a1

        mv t4, a0

        li t0, serial_port

        li t1, 0     # Starts the counter



        writing_loop:   # Starts the loop that iterates over the chars of the string and prints them

            beq a1, t1, writing_done        # If the number of iterations done is equal to the value in a1, we exit the loop

            lb t2, 0(t4)

            sb t2, 0x01(t0)


            li t2, 1            # Triggers the writing 

            sb t2, 0(t0)

            writing_busy_waiting:       # Waits for the writing of the byte to be completed

                lb t2, 0(t0)

                beqz t2, writing_busy_done

                j writing_busy_waiting


            writing_busy_done:  # Once its done, we increment 1 in both string and counter 

                addi t4, t4, 1

                addi t1, t1, 1

                j writing_loop

        writing_done:


            ret

get_systime:

        li t0, gpt

        li t2, 1

        sw t2, 0(t0)

        busy_waiting_gpt:

            lw t2, 0(t0)

            beqz t2, gpt_done

            j busy_waiting_gpt

        gpt_done:

            lw t1, 0x04(t0)

            mv a0, t1

            ret
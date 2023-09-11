read:
    li a0, 0  // file descriptor = 0 (stdin)
    la a1, input_address //  buffer to write the data
    li a2, 1  // size (reads only 1 byte)
    li a7, 63 // syscall read (63)
    ecall

input_address: .skip 0x10  // buffer

write:
    li a0, 1            // file descriptor = 1 (stdout)
    la a1, string       // buffer
    li a2, 19           // size
    li a7, 64           // syscall write (64)
    ecall    
string:  .asciz "Hello! It works!!!\n"

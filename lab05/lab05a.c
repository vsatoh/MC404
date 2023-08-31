#include <stdio.h>

// int read(int __fd, const void *__buf, int __n){
//     int ret_val;
//   __asm__ __volatile__(
//     "mv a0, %1           # file descriptor\n"
//     "mv a1, %2           # buffer \n"
//     "mv a2, %3           # size \n"
//     "li a7, 63           # syscall write code (63) \n"
//     "ecall               # invoke syscall \n"
//     "mv %0, a0           # move return value to ret_val\n"
//     : "=r"(ret_val)  // Output list
//     : "r"(__fd), "r"(__buf), "r"(__n)    // Input list
//     : "a0", "a1", "a2", "a7"
//   );
//   return ret_val;
// }

// void write(int __fd, const void *__buf, int __n)
// {
//   __asm__ __volatile__(
//     "mv a0, %0           # file descriptor\n"
//     "mv a1, %1           # buffer \n"
//     "mv a2, %2           # size \n"
//     "li a7, 64           # syscall write (64) \n"
//     "ecall"
//     :   // Output list
//     :"r"(__fd), "r"(__buf), "r"(__n)    // Input list
//     : "a0", "a1", "a2", "a7"
//   );
// }

// void exit(int code)
// {
//   __asm__ __volatile__(
//     "mv a0, %0           # return code\n"
//     "li a7, 93           # syscall exit (64) \n"
//     "ecall"
//     :   // Output list
//     :"r"(code)    // Input list
//     : "a0", "a7"
//   );
// }

// void _start()
// {
//   int ret_code = main();
//   exit(ret_code);
// }

// #define STDIN_FD  0
// #define STDOUT_FD 1

int potencia(int num_base, int n) {
    int num_pot = 1;
    for(int i = 0; i < n; i++) {
        num_pot *= num_base;
    }
    return num_pot;
}

void converte_dec_bin(int num) {
    int num_aux = num, n_aux;
    while(num_aux != 0) {
        num_aux = num_aux/2;
        n_aux++;
    }
    char resp[32];
    for(int i = 0; i < 4-n_aux; i++) {
        for(int j = 0; j < 4; j++) {
            resp[i] = '0';
        }
    }
}

int converte_char_int(char str[], int n) {
    int numero_final = 0;
    for(int i = 1; i <= n; i++) {
        numero_final += (str[i-1] - '0')*potencia(10, n-i);
    }
    return numero_final;
}


unsigned int converte_dec_bin(int num) {
    if(num == 0 | num == 1) {
        return num;
    }
    else if(num%2 == 1) {
        return converte_dec_bin(num/2)*10 + 1; 
    }
    return converte_dec_bin(num/2)*10;
}


int main() {
    // char str[30];
    // int n = read(STDIN_FD, str, 30);

    char masc3[32] = "00000000000000000000000000000111";
    char masc5[32] = "00000000000000000000000000011111";
    char masc8[32] = "00000000000000000000000011111111";
    char masc11[32] = "00000000000000000000011111111111";
    for(int i = 0; i < 32; i++) {
        printf("%c", masc3[i]);
    }
    // int num[5];
    // char mtrx_str[5][6];

    // for(int i = 0; i < 5; i++) {
    //     for(int j = 0; j < 5; j++) {
    //         mtrx_str[i][j] = str[6*i + j];
    //     }
    // }

    // for(int i = 0; i < 5; i++) {
    //     num[i] = converte_char_int(mtrx_str[i], 5);
    // }

    // write(STDOUT_FD, str, 30);


}
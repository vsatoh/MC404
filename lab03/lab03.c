#include  <stdio.h>

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

int converte_char_int(char str[], int n) {
    int numero_final = 0;
    for(int i = 1; i <= n; i++) {
        numero_final += (str[i-1] - '0')*potencia(10, n-i);
    }
    return numero_final;
}

int converte_dec_binario(int num) {
    if(num == 1 || num == 0) {
        return num;
    }
    else if(num%2 == 0) {
        return converte_dec_binario(num/2)*10;
    }
    return converte_dec_binario(num/2)*10 + 1;
}

int converte_hex_dec(char str[], int n) {
    char hex[16] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};
    int num = 0;
    for(int i = 0; i < n; i++) {
        for(int j = 0; j < 16; j++) {
            if(str[i] == hex[j]) {
                num+=j*potencia(16,n-1-i);
            }
        }
    }
    return num;
}

// char converte_int_char(int num, int n, char str[]) {
//     for(int i = 0; i < n; i++) {
//         str[i] = num/potencia(10, n-i) + '0';
//     }

// }

int main()
{
    char str[20];
    //int n = read(STDIN_FD, str, 20);
    int n = 5;
    scanf("%s", str);

    // int num = converte_char_int(str,n);
    // num += num;

    // for(int i = 1; i <= n; i++) {
    //     str[i-1] = num/potencia(10, n-i) + '0';
    //     num = num%potencia(10, n-i);

    // }
    int num = converte_hex_dec(str,n);
    printf("%d", num);
    // for(int i = 0; i < n; i++) {
    //     printf("%c", str[i]);
    // }
    //write(STDOUT_FD, str, n);
    return 0;
}

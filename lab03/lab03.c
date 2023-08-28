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

void imprime(char str[], int n) {
    for(int i = 0; i < n; i++) {
        printf("%c", str[i]);
    }
    printf("\n");
}

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

int converte_dec_bin(int num) {
    int n = 0;
    int num_aux = num;
    while (num_aux != 0)
    {
        num_aux = num_aux/2;
        n++;
    }
    char resp[n+2];
    resp[0] = '0';
    resp[1] = 'b';
    for(int i = n+1; i >= 2; i--) {
        if(num%2 == 0) {
            resp[i] = '0';
        } 
        else {
            resp[i] = '1';
        }
        num=num/2;
    }
    for(int i = 0; i < n+2; i++) {
        printf("%c", resp[i]);
    }
    return n;
}

int polinomio_bin(char str[], int n) {
    int num = 0;
    for(int i = 0; i < n; i++) {
        if(str[i] == '1') {
            num += potencia(2,n-1-i);
        }
    }
    return num;
}

int converte_dec_bin2(int num) {
    int n = 0, aux = 0;
    int num_aux = num;
    while (num_aux != 0)
    {
        num_aux = num_aux/2;
        n++;
    }
    char resp[n], resp_fim[34];
    resp_fim[0] = '0';
    resp_fim[1] = 'b';
    for(int i = n-1; i >= 0; i--) {
        if(num%2 == 0) {
            resp[i] = '0';
        } 
        else {
            resp[i] = '1';
        }
        num=num/2;
    }
    //sub 1
    int pos = n-1;
    while(aux == 0) {
        if(resp[pos] == '1') {
            resp[pos] = '0';
            aux = 1;
        } else {
            resp[pos] = '1';
        }
        pos--;
    }

    for(int i = 0; i < n; i++) {
        if(resp[i] == '1') {
            resp[i] = '0';
        }
        else {
            resp[i] = '1';
        }
    }
    for(int i = 2; i < 34 - n; i++) {
        resp_fim[i] = '1';
    }
    for(int i = 34 - n; i < 34; i++) {
        resp_fim[i] = resp[i - 34 + n];
    }
    for(int i = 0; i < 34; i++) {
        printf("%c", resp_fim[i]);
    }
    char so_bin[32];
    for(int i = 0; i < 32; i++) {
        so_bin[i] = resp_fim[i+2];
    }

    int out_num = polinomio_bin(so_bin, 32);
    return out_num;
}

int soma_um_bin(char str[], int n) {
    int i = n-1, aux = 0, num;
    while (aux == 0) {
        if(str[i] == '0') {
            str[i] = '1';
            aux = 1;
        }
        else {
            str[i] = '0';
        }
        i--;
    }
    num = polinomio_bin(str, n);
    return num;
}

int converte_bin_dec(char str[], int num) {
    int n = 0;
    int num_aux = num;
    while (num_aux != 0)
    {
        num_aux = num_aux/2;
        n++;
    }
    char resp[n];
    for(int i = n-1; i >= 0; i--) {
        if(num%2 == 0) {
            resp[i] = '0';
        } 
        else {
            resp[i] = '1';
        }
        num=num/2;
    }

    char bin_cp2[n];
    if(resp[0] == '1' && n == 32) {
        for(int i = 0; i < n; i++) {
            if(resp[i]== '1') {
                bin_cp2[i] = '0';
            }
            else {
                bin_cp2[i] = '1';
            }
        }
        num = soma_um_bin(bin_cp2, n);
        return num*-1;
    }
    num = polinomio_bin(resp, n);
    return num;
}

int converte_bin_dec2(char resp[], int n) {
    int num;
    char bin_cp2[n];
    if(resp[0] == '1' && n == 32) {
        for(int i = 0; i < n; i++) {
            if(resp[i]== '1') {
                bin_cp2[i] = '0';
            }
            else {
                bin_cp2[i] = '1';
            }
        }
        num = soma_um_bin(bin_cp2, n);
        return num*-1;
    }
    num = polinomio_bin(resp, n);
    return num;
}

void converte_hex_bin(char str[], int n) {
    char hex[16] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};
    int num = 0;
    for(int i = 0; i < n; i++) {
        for(int j = 0; j < 16; j++) {
            if(str[i] == hex[j]) {
                num+=j*potencia(16,n-1-i);
            }
        }
    }
    printf("%d\n", num);
    converte_dec_bin(num);
}

int converter_hex_dec(char str[], int n) {
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

void converter_dec_hex(int num) {
    char hex[16] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};
    int num_aux = num, n = 0;
    while (num_aux != 0)
    {
        num_aux = num_aux/16;
        n++;
    }
    char resp[n+2];
    resp[0] = '0';
    resp[1] = 'x';
    for (int i = n+1; i >= 2; i--) {
        for (int j = 0; j < 16; j++) {
            if(num%16 == j) {
                resp[i] = hex[j];
            }
        }
        num=num/16;
    }
    for(int i = 0; i < n+2; i++) {
        printf("%c", resp[i]);
    }   
    printf("\n");
}

void converte_int_char(int num) {
    int num_aux = num, n = 0;
    while (num_aux != 0)
    {
        num_aux = num_aux/10;
        n++;
    }
    if(num < 0) {
        char str[n+1];
        str[0] = '-';
        for(int i = 1; i < n; i++) {
            str[i] = num/potencia(10, n-1-i) + '0';
            num%=potencia(10, n-1-i);
            imprime(str,n+1);
        }
        imprime(str,n+1);
    }
    else {
        char str[n];
        for(int i = 0; i < n; i++) {
            str[i] = num/potencia(10, n-1-i) + '0';
            num%=potencia(10, n-1-i);
        }
        imprime(str,n);
    }

    //write(STDOUT_FD, str, n);
}

int main()
{
    char str[32];
    //int n = read(STDIN_FD, str, 20);
    int n = 8;
    int num;
    scanf("%s", str);
    if(str[0] == '0' && str[1] == 'b') {
        imprime(str, n);
        num = converte_bin_dec2(str, n);
        converte_int_char(num);
        converter_dec_hex(num);
    }
    else if(str[0] == '0' && str[1] == 'x') {
        num = converter_hex_dec(str,n);
        int tam_bin = converte_dec_bin(num);
        printf("\n");
        num = converte_bin_dec(str, num);
        printf("%d",num);
        printf("\n");
        imprime(str, n);
    }
    else if(str[0] == '-') {
        char str_aux[32];
        for(int i = 1; i < n; i++) {
            str_aux[i-1] = str[i];
        }
        num = converte_char_int(str_aux,n-1);
        num = converte_dec_bin2(num);
        imprime(str,n);
        converter_dec_hex(num);
    }
    else {
        num = converte_char_int(str,n);
        converte_dec_bin(num);
        printf("\n");
        imprime(str,n);
        converter_dec_hex(num);
    }

    // for(int i = 0; i < n; i++) {
    //     printf("%c", str[i]);
    // }
    //write(STDOUT_FD, str, n);
    return 0;
}

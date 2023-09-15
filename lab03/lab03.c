int read(int __fd, const void *__buf, int __n){
    int ret_val;
  __asm__ __volatile__(
    "mv a0, %1           # file descriptor\n"
    "mv a1, %2           # buffer \n"
    "mv a2, %3           # size \n"
    "li a7, 63           # syscall write code (63) \n"
    "ecall               # invoke syscall \n"
    "mv %0, a0           # move return value to ret_val\n"
    : "=r"(ret_val)  // Output list
    : "r"(__fd), "r"(__buf), "r"(__n)    // Input list
    : "a0", "a1", "a2", "a7"
  );
  return ret_val;
}

void write(int __fd, const void *__buf, int __n)
{
  __asm__ __volatile__(
    "mv a0, %0           # file descriptor\n"
    "mv a1, %1           # buffer \n"
    "mv a2, %2           # size \n"
    "li a7, 64           # syscall write (64) \n"
    "ecall"
    :   // Output list
    :"r"(__fd), "r"(__buf), "r"(__n)    // Input list
    : "a0", "a1", "a2", "a7"
  );
}

void exit(int code)
{
  __asm__ __volatile__(
    "mv a0, %0           # return code\n"
    "li a7, 93           # syscall exit (64) \n"
    "ecall"
    :   // Output list
    :"r"(code)    // Input list
    : "a0", "a7"
  );
}

void _start()
{
  int ret_code = main();
  exit(ret_code);
}

#define STDIN_FD  0
#define STDOUT_FD 1

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
int polinomio_bin(char str[], int n) {
    int num = 0;
    for(int i = 0; i < n; i++) {
        if(str[i] == '1') {
            num += potencia(2,n-1-i);
        }
    }
    return num;
}

void converte_dec_bin2(int num) {
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
    // for(int i = 0; i < 34; i++) {
    //     printf("%c", resp_fim[i]);
    // }
    write(STDOUT_FD, resp_fim, 34);
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
    char hex[16] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};
    int num = 0;
    for(int i = 0; i < n; i++) {
        for(int j = 0; j < 16; j++) {
            if(str[i] == hex[j]) {
                num+=j*potencia(16,n-1-i);
            }
        }
    }
    converte_dec_bin(num);
}

int converter_hex_dec(char str[], int n) {
    char hex[16] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};
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
    char hex[16] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};
    int num_aux = num, n = 0;
    while (num_aux != 0)
    {
        num_aux = num_aux/16;
        n++;
    }
    char resp[n+3];
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
    // for(int i = 0; i < n+2; i++) {
    //     printf("%c", resp[i]);
    // }   
    // printf("\n");
    resp[n+2] = '\n';
    write(STDOUT_FD, resp, n+3);
}

void converter_dec_hex2(int num) {
    char hex[16] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};
    int num_aux = num, n = 0, aux = 0;
    while (num_aux != 0)
    {
        num_aux = num_aux/16;
        n++;
    }
    char resp[n];
    for (int i = n-1; i >= 0; i--) {
        for (int j = 0; j < 16; j++) {
            if(num%16 == j) {
                resp[i] = hex[j];
            }
        }
        num=num/16;
    }
    //sub 1
    int i = n - 1, j = 0, aux2 = 0;
    while(aux == 0) {
        j = 0;
        aux2 = 0;
        while(aux2 == 0) {
            if(resp[i] == '0') {
                resp[i] = 'f';
                aux2 = 1;
            }
            else if(resp[i] == hex[j]){
                resp[i] = hex[j-1];
                aux2 = 1;
                aux = 1;
            }
            j++;
        }
        i--;
    }
    //complemento
    for(i = 0; i < n; i++) {
        j = 0;
        aux2 = 0;
        while(aux2 == 0) {
            if(resp[i] == hex[j]) {
                resp[i] = hex[15-j];
                aux2 = 1;
            }
            j++;
        }

    }

    char resp_final[10];
    resp_final[0] = '0';
    resp_final[1] = 'x';
    for(i = 2; i < 10 - n; i++) {
        resp_final[i] = 'f';
    }
    for(i = 10 - n; i < 10; i++) {
        resp_final[i] = resp[i-10+n];
    }
    // for(i = 0; i < 10; i++) {
    //     printf("%c", resp_final[i]);
    // }
    write(STDOUT_FD, resp_final, 10);
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
        }
        write(STDOUT_FD, str, n+1);
    }
    else {
        char str[n];
        for(int i = 0; i < n; i++) {
            str[i] = num/potencia(10, n-1-i) + '0';
            num%=potencia(10, n-1-i);
        }
        write(STDOUT_FD, str, n);
    }
    //write(STDOUT_FD, str, n);
}

void converte_dec_hex_en(int num) {
    char hex[16] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};
    int num_aux = num, n = 0;
    while (num_aux != 0)
    {
        num_aux = num_aux/16;
        n++;
    }
    char resp[8];
    // resp[0] = '0';
    // resp[1] = 'x';
    for(int i = 0; i < 8-n; i++) {
        resp[i] = '0';
    }
    //add 0
    for (int i = 7; i >= 8-n; i--) {
        for (int j = 0; j < 16; j++) {
            if(num%16 == j) {
                resp[i] = hex[j];
            }
        }
        num=num/16;
    }

    //inverter
    char resp_invertido[8];
    for(int i = 0; i <= 6; i+=2) {
        resp_invertido[i] = resp[6-i];
        resp_invertido[i+1] = resp[7-i];
    } 
    int numdec = converter_hex_dec(resp_invertido, 8);
    converte_int_char(numdec);
}

void converter_hex_hex_en(char str[],int n) {
    char str_n[n-2];
    for(int i = 2; i < n; i++) {
        str_n[i-2] = str[i];
    }
    n = n -2;
    char resp[8];
    for(int i = 0; i < 8-n; i++) {
        resp[i] = '0';
    }
    for(int i = 8-n; i < 8; i++) {
        resp[i] = str_n[i-8+n];
    }
    char resp_invertido[8];
    for(int i = 0; i <= 6; i+=2) {
        resp_invertido[i] = resp[6-i];
        resp_invertido[i+1] = resp[7-i];
    } 
    int numdec = converter_hex_dec(resp_invertido, 8);
    converte_int_char(numdec);
}

void converter_neg_hex_en(int num) {
    char hex[16] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};
    int num_aux = num, n = 0, aux = 0;
    while (num_aux != 0)
    {
        num_aux = num_aux/16;
        n++;
    }
    char resp[n];
    for (int i = n-1; i >= 0; i--) {
        for (int j = 0; j < 16; j++) {
            if(num%16 == j) {
                resp[i] = hex[j];
            }
        }
        num=num/16;
    }
    //sub 1
    int i = n - 1, j = 0, aux2 = 0;
    while(aux == 0) {
        j = 0;
        aux2 = 0;
        while(aux2 == 0) {
            if(resp[i] == '0') {
                resp[i] = 'f';
                aux2 = 1;
            }
            else if(resp[i] == hex[j]){
                resp[i] = hex[j-1];
                aux2 = 1;
                aux = 1;
            }
            j++;
        }
        i--;
    }
    //complemento
    for(i = 0; i < n; i++) {
        j = 0;
        aux2 = 0;
        while(aux2 == 0) {
            if(resp[i] == hex[j]) {
                resp[i] = hex[15-j];
                aux2 = 1;
            }
            j++;
        }
    }
    char resp_final[8];
    for(i = 0; i < 8 - n; i++) {
        resp_final[i] = 'f';
    }
    for(i = 8 - n; i < 8; i++) {
        resp_final[i] = resp[i-8+n];
    }
    //inverter
    char resp_invertido[8];
    for(int i = 0; i <= 6; i+=2) {
        resp_invertido[i] = resp_final[6-i];
        resp_invertido[i+1] = resp_final[7-i];
    } 

    unsigned int numdec = converter_hex_dec(resp_invertido, 8);
    
    unsigned int num_aux2 = converter_hex_dec(resp_invertido, 8);
    n = 0;
    while (num_aux2 != 0)
    {
        num_aux2 = num_aux2/10;
        n++;
    }
//ok
    char str[n];
    for(int i = 0; i < n; i++) {
        str[i] = numdec/potencia(10, n-1-i) + '0';
        numdec%=potencia(10, n-1-i);
    }
    write(STDOUT_FD, str, n);
}

int main()
{
    char str[32];
    int n = read(STDIN_FD, str, 32);
    int num;
    if(str[0] == '0' && str[1] == 'b') {
        write(STDOUT_FD, str, n);
        num = converte_bin_dec2(str, n);
        converte_int_char(num);
        converter_dec_hex(num);
        converte_dec_hex_en(num);
    }
    else if(str[0] == '0' && str[1] == 'x') {
        num = converter_hex_dec(str,n);
        int tam_bin = converte_dec_bin(num);
        num = converte_bin_dec(str, num);
        converte_int_char(num);
        write(STDOUT_FD, str, n);        
        converter_hex_hex_en(str,n);
    }
    else if(str[0] == '-') {
        char str_aux[32];
        for(int i = 1; i < n; i++) {
            str_aux[i-1] = str[i];
        }
        num = converte_char_int(str_aux,n-1);
        converte_dec_bin2(num);
        write(STDOUT_FD, str, n);
        converter_dec_hex2(num);
        converter_neg_hex_en(num);
    }
    else {
        num = converte_char_int(str,n);
        converte_dec_bin(num);
        write(STDOUT_FD, str, n);
        converter_dec_hex(num);
        converte_dec_hex_en(num);
    }


    //write(STDOUT_FD, str, n);
    return 0;
}

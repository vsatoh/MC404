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

int polinomio_bin(char str[], int n) {
    int num = 0;
    for(int i = 0; i < n; i++) {
        if(str[i] == '1') {
            num += potencia(2,n-1-i);
        }
    }
    return num;
}

int converte_dec_bin(int num, int recuo) {
    int num_aux = num, n = 0;
    while(num_aux != 0) {
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
    
    char resp_aux[32];
    for(int i = 0; i < 32 - n; i++) {
        resp_aux[i] = '0';
    }    

    for(int i = 32 - n; i < 32; i++) {
        resp_aux[i] = resp[i - 32 + n];
    }

    char resp_fim[recuo];
    for(int i = 32 - recuo; i < 32; i++) {
        resp_fim[i - 32 + recuo] = resp_aux[i];
    }

    int numero_cortado;
    numero_cortado = polinomio_bin(resp_fim, recuo);
    return numero_cortado;
}

int converte_dec_bin2(int num, int recuo) {
    int n = 0, aux = 0;
    int num_aux = num;
    while (num_aux != 0)
    {
        num_aux = num_aux/2;
        n++;
    }
    num_aux = num;
    char resp[n];
    for(int i = n-1; i >= 0; i--) {
        if(num_aux%2 == 0) {
            resp[i] = '0';
        } 
        else {
            resp[i] = '1';
        }
        num_aux=num_aux/2;
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

    char resp_aux[32];
    for(int i = 0; i < 32 - n; i++) {
        resp_aux[i] = '1';
    }
    for(int i = 32 - n; i < 32; i++) {
        resp_aux[i] = resp[i - 32 + n];
    }
    char resp_fim[recuo];
    for(int i = 32 - recuo; i < 32; i++) {
        resp_fim[i - 32 + recuo] = resp_aux[i];
    }
    int numero_cortado;
    numero_cortado = polinomio_bin(resp_fim, recuo);
    return numero_cortado;
}

int converte_char_int(char str[], int n) {
    int numero_final = 0;
    for(int i = 1; i <= n; i++) {
        if (str[i-1] != '0') {
            numero_final += (str[i-1] - '0')*potencia(10, n-i);
        }
    }
    return numero_final;
}

void concatena_bin(int num_transf[], int num_sig[]) {
    char bin_conc[32];
    int i_aux = 0;
    for(int i = 4; i >= 0; i--) {
        int num_aux = num_transf[i], n = 0;
        while(num_aux != 0) {
            num_aux = num_aux/2;
            n++;
        }
        num_aux = num_transf[i];

        char resp[n];

        for(int j = n-1; j >= 0; j--) {
            if(num_aux%2 == 0) {
                resp[j] = '0';
            } 
            else {
                resp[j] = '1';
            }
            num_aux=num_aux/2;
        }

        char resp_aux[num_sig[i]];
        for(int j = 0; j < num_sig[i] - n; j++) {
            resp_aux[j] = '0';
        }    

        for(int j = num_sig[i] - n; j < num_sig[i]; j++) {
            resp_aux[j] = resp[j - num_sig[i] + n];
        }

        for(int j = 0; j < num_sig[i]; j++) {
            bin_conc[i_aux + j] = resp_aux[j];
        }
        i_aux += num_sig[i];
    }
    char bin_conc_sep[8][4];
    for(int i = 0; i < 8; i++) {
        for(int j = 0; j < 4; j++) {
            bin_conc_sep[i][j] = bin_conc[4*i + j];
        }
    }
    int num_sep[8];
    for(int i = 0; i < 8; i++) {
        num_sep[i] = polinomio_bin(bin_conc_sep[i], 4);
    }

    char hex_con[11];
    hex_con[0] = '0';
    hex_con[1] = 'x';
    for(int k = 0; k < 8; k++) {
        int num_aux = num_sep[k];
        char hex[16] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F'};
        for (int j = 0; j < 16; j++) {
            if(num_aux == j) {
                hex_con[2+k] = hex[j];
            }
        }
    }
    hex_con[10] = '\n';
    write(STDOUT_FD, hex_con, 11);
}

// unsigned int converte_dec_bin(int num) {
//     if(num == 0 | num == 1) {
//         return num;
//     }
//     else if(num%2 == 1) {
//         return converte_dec_bin(num/2)*10 + 1; 
//     }
//     return converte_dec_bin(num/2)*10;
// }


int main() {
    char str[30];
    int n = read(STDIN_FD, str, 30);

    char masc3[32] = "00000000000000000000000000000111";
    char masc5[32] = "00000000000000000000000000011111";
    char masc8[32] = "00000000000000000000000011111111";
    char masc11[32] = "00000000000000000000011111111111";


    int num[5], num_transf[5];
    int num_sig[5] = {3, 8, 5, 5, 11};
    char mtrx_str[5][4], sinais[5];
    for(int i = 0; i < 5; i++) {
        sinais[i] = str[6*i];
        for(int j = 1; j < 5; j++) {
            mtrx_str[i][j-1] = str[6*i + j];
        }
    }

    for(int i = 0; i < 5; i++) {
        num[i] = converte_char_int(mtrx_str[i], 4);
    }

    for(int i = 0; i < 5; i++) {
        if(sinais[i] == '+') {
            num_transf[i] = converte_dec_bin(num[i], num_sig[i]);
        }
        else {
            num_transf[i] = converte_dec_bin2(num[i], num_sig[i]);
        }
    }
    concatena_bin(num_transf, num_sig);
}
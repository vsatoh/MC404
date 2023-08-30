int converte_dec_bin(int num) {
    int n = 0;
    int num_aux = num;
    while (num_aux != 0)
    {
        num_aux = num_aux/2;
        n++;
    }
    char resp[n+3];
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
    // for(int i = 0; i < n+2; i++) {
    //     printf("%c", resp[i]);
    // }
    resp[n+2] = '\n';
    write(STDOUT_FD, resp, n+3);
    return n;
}

int main() {

}
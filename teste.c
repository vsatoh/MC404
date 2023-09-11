#include  <stdio.h>


int main() {
    int y = 400;
    int k;
    k = y/2;
    for(int i = 0; i < 10; i++) {
        k = (k+y/k)/2;
        printf("Valor de k: %d\n",k);
    }
    return 0;
}

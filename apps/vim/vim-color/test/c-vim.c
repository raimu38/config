#include <stdio.h>

#define MAX_VAL 100

int calculate(int base) {
    if (base >= MAX_VAL) {
        return 0;
    }
    return base * 2;
}

int main() {
    int value = 50;
    const char *status = "Processing";
    
    int result = calculate(value);
    printf("%s: %d\n", status, result);
    
    return 0;
}

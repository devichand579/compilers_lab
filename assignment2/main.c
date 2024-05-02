#include "myl.h"

int main(){
    int n, x;
    float f;
    printStr("Enter an integer: ");
    x = readInt(&n);
    if (x==ERR){
    printStr("The Entered text is not an integer\n");
    }
    else {
        printStr("The integer is: ");
        printInt(n);
    }
    
    printStr("\nEnter a float: ");
    x = readFlt(&f);
    if (x==ERR){
        printStr("The Entered text is not a floating point number\n");
    }
    else {
        printStr("The float is: ");
        printFlt(f);
    }
    printStr("\n");
    return 0;
}

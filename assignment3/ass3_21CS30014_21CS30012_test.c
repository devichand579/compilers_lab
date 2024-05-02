/* Test File */

typedef unsigned long long ull;

static const double alpha = 0.0001;
auto b = 5;
_Bool x = 1;
enum month { jan = 1, feb, mar, apr, may, jun, july,aug,sep,oct,nov,dec };

struct node {
    int value;
	struct node* next;
};

union values {
	int v;
};


void main ()
{
	// testing identifiers and constants
    short signed int number0 = 40;	// integer-constant
    enum month _m = may;			// enum- constant
    float f1_ = 25.56;				// floating-constant
    float f2_ = 23.E-4;
    float f3_ = 23.66e+3;
    float f4_ = .56E2;
    float f5_ = 232e3;
    char _1 = 'x';					// character-constant
    char _2 = '\b';

    // testing string literals
    char s[2] = "";
    char str[] = "hello\\\"\'\n";

    // testing punctuators
    int a = 1, b = 1;
    a++;
    a--;
    a = a|b;
    a = (a) ? a : b;
    a *= b;
    a /= b;
    a %= b;
    a += b;
    a -= b;
    a <<= b;
    a >>= b;
    a &= b;
    a ^= b;
    a |= b, b = 0;
    a = a&b;
    a = a*b;
    a = a+b;
    a = a-b;
    a = !b;
    a = ~b;
    a = a/b;
    a = a%b;
    a = a<<b;
    a = a>>b;
    a = a^b;
   
    inline char toUpper (char ch);

    struct node *head;
    if (!head) {
    	head = head -> next;
    }

    switch (_m) {
    	case 1:	
    		break;
		default:;
    }

    int n, t;
    do {
        n -= 1;
    } while (n > 1);

    for(int i = 0; (i < 6 && i >= 10) || (i > 500 && i != 101); i++) {
    	continue;
    }
 
    if (t <= 30) {
        t = 1;
    } else {
    	t = 0;
    }

    // Testing comments

    // This is a single line comment

    /* This comment is a multi-line comment. 
     * Second line of the multi line comment */
}

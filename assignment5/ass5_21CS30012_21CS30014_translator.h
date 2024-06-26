#ifndef __TRANSLATOR_H
#define __TRANSLATOR_H

#include <iostream>
#include <vector>
#include <list>
using namespace std;


#define __VOID_SIZE 0
#define __FUNCTION_SIZE 0
#define __CHARACTER_SIZE 1
#define __INTEGER_SIZE 4
#define __POINTER_SIZE 4
#define __FLOAT_SIZE 8

class symbol;   //symbol: represents an element(entry) in the symbol table
class symbolType;  //symbolType:  represents the type of an element in the symbol table
class symbolTable;  //symbolTable:  represents the symbol table data structure itself

class quad;      //quad:  Denotes a quad in the Three Address Code translation
class quadArray; //quadArray:  Denotes the entire list of quads for lazy spitting

extern symbol* currentSymbol;  //currentSymbol: Pointer to the current symbol
extern symbolTable* currentST;//currentST: Pointer to the currently active symbol table
extern symbolTable* globalST; //globalST: Pointer to the global symbol table
extern quadArray quadList;   //quadList: The list of quads for lazy spiting
extern int STCount;         //STCount: A count variable used for naming nested symbol tables
extern string blockName;   //blockName: A variable used for naming nested blocks in symbol tables


extern char* yytext;
extern int yyparse();

/*
    Class to represent the type of an element in the symbol table
    class symbolType
    ----------------
    Member Variables:
        type: string            The type of the symbol
        width: int              In case of arrays, it represents the size, for basic types it is 1
        arrType: symbolType*    For arrays, it points to the type of the elements in the array

    Member Methods:
        symbolType(string type_, symbolType* arrType_ = NULL, int width_ = 1)
        - Constructor
*/
class symbolType {
public:
    string type;
    int width;
    symbolType* arrType;

    symbolType(string type_, symbolType* arrType_ = NULL, int width_ = 1);
};

/*
    Class to represent an element(entry) in the symbol table
    class symbol
    ------------
    Member Variables:
        name: string                The name of the symbol
        type: symbolType*           Type of the symbol
        value: string               Initial value of the symbol, if any
        size: int                   Size of the symbol(element)
        offset: int                 Offset of the symbol in the symbol table
        nestedTable: symbolTable*   Pointer to a nested symbol table, if any (useful for functions and blocks)

    Member Methods:
        symbol(string name_, string t = "int", symbolType* arrType = NULL, int width = 0)
        - Constructor

        update(symbolType* t): symbol*
        - Update the contents of an existing symbol
*/
class symbol {
public:
    string name;
    symbolType* type;
    string value;
    int size;
    int offset;
    symbolTable* nestedTable;

    symbol(string name_, string t = "int", symbolType* arrType = NULL, int width = 0);
    symbol* update(symbolType* t);
};

/*
    Class to represent the symbol table data structure
    class symbolTable
    ------------
    Member Variables:
        name: string                The name of the symbol
        tempCount: int              Count of temporary variables generated for the symbol table
        table: list<symbol>         List of all symbols present in the symbol table
        parent: symbolTable*        Pointer to the parent of the symbol table, NULL for the global symbol table

    Member Methods:
        symbolTable(string name_ = "NULL")
        - Constructor

        lookup(string name): symbol*
        - A method to lookup an id (given its name or lexeme) in the symbol table. If the id exists, the entry is returned, otherwise a new entry is created.

        gentemp(symbolType* t, string initValue = ""): symbol*
        - A static method to generate a new temporary, insert it to the symbol table, and return a pointer to the entry

        print(): void
        - Prints the symbol table in a suitable fashion
        
        update(): void
        - Updates different fields of an existing entry
*/
class symbolTable {
public:
    string name;
    int tempCount;
    list<symbol> table;
    symbolTable* parent;

    symbolTable(string name_ = "NULL");

    symbol* lookup(string name);
    static symbol* gentemp(symbolType* t, string initValue = "");

    void print();
    void update();
};

/*
    Class to denote a quad in the Three Address Code translation
    class quad
    ------------
    Member Variables:
        op: string          Operator in the three address code
        arg1: string        First argument in the three address code
        arg2: string        Second argument in the three address code
        result: string      Result of the three address code

    Member Methods:
    quad(string res, string arg1_, string operation = "=", string arg2_ = "")
    - Constructor

    quad(string res, int arg1_, string operation = "=", string arg2_ = "")
    - Constructor

    quad(string res, float arg1_, string operation = "=", string arg2_ = "")
    - Constructor

    The multiple overloaded constructors help to instantiate quads with different kinds of operators and argument lists

    print(): void
    - Prints the quad in a suitable fashion

*/
class quad {
public:
    string op;
    string arg1;
    string arg2;
    string result;

    quad(string res, string arg1_, string operation = "=", string arg2_ = "");
    quad(string res, int arg1_, string operation = "=", string arg2_ = "");
    quad(string res, float arg1_, string operation = "=", string arg2_ = "");

    void print();
};

/*
    Class to denote the entire list of quads for lazy spitting
    class quadArray
    ------------
    Member Variables:
        quads: vector<quads>    A vector of all the quads generated

    Member Methods:
        print(): void
        - Prints the entire list of quads
*/
class quadArray {
public:
    vector<quad> quads;

    void print();
};

/*
    Class to denote an array type
    class Array
    ------------
    Member Variables:
        atype: string           Type of the array, either "arr" or "ptr"
        loc: symbol*            Location to compute address of the array
        Array: symbol*          Symbol table entry for the array
        type: symbolType*       Type of the array generated, used for multidimensional arrays
*/
class Array {
public:
    string atype;
    symbol* loc;
    symbol* Array;
    symbolType* type;
};

/*
    Class to denote a statement
    class statement
    ------------
    Member Variables:
        nextlist: list<int>     Nextlist for the statement
*/
class statement {
public:
    list<int> nextlist;
};

/*
    Class to denote an expression
    class expression
    ------------
    Member Variables:
        type: string                Type of the expression
        loc: symbol*                Pointer to the symbol table entry 
        truelist: list<int>         Truelist for boolean expressions
        falselist: list<int>        Falselist for boolean expressions
        nextlist: list<int>         Nextlist for statement expressions
*/
class expression {
public:
    string type;
    symbol* loc;
    list<int> truelist;
    list<int> falselist;
    list<int> nextlist;
};

/*
    An overloaded method to add a (newly generated) quad of the form: result = arg1 op arg2 where op usually is a binary operator. 
    If arg2 is missing, op is unary. If op also is missing, this is a copy instruction.
    It is overloaded for different types of quads (int, float or string)
*/
void emit(string op, string result, string arg1 = "", string arg2 = "");
void emit(string op, string result, int arg1, string arg2 = "");
void emit(string op, string result, float arg1, string arg2 = "");

/*
    A global function to create a new list containing only i, an index into the array of quads, 
    and to return a pointer to the newly created list
*/
list<int> makelist(int i);

/*
    A global function to concatenate two lists list1 and list2 and to return a pointer to the concatenated list
*/
list<int> merge(list<int> &list1, list<int> &list2);

/*
    A global function to insert address as the target label for each of the quads on the list l
*/
void backpatch(list<int> l, int address);

/*
    Checks compatibility of the types of the symbols s1 and s2
    Overloaded for symbol types also
*/
bool typecheck(symbol* &s1, symbol* &s2);
bool typecheck(symbolType* t1, symbolType* t2);

/*
    Converts a symbol of one type to another and returns a pointer to the converted symbol
*/
symbol* convertType(symbol* s, string t);

/*
    Converts an int to a string
*/
string convertIntToString(int i);

/*
    Converts a float to a string
*/
string convertFloatToString(float f);

/*
    Converts an int to a bool and adds required attributes
*/
expression* convertIntToBool(expression* expr);

/*
    Converts a bool to an int and adds required attributes
*/
expression* convertBoolToInt(expression* expr);

/*
    Changes the currently active symbol table to newTable
*/
void switchTable(symbolTable* newTable);

/*
    Returns the count of the next instruction
*/
int nextinstr();

/*
    Auxiliary function to get the size of a type
*/
int sizeOfType(symbolType* t);

/*
    Auxilary function to print a type
*/
string checkType(symbolType* t);

#endif
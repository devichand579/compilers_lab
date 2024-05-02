#include <stdio.h>
#define KEYWORD                   21
#define IDENTIFIER                22
#define INTEGER_CONSTANT          23
#define FLOATING_CONSTANT         24
#define ENUMERATION_CONSTANT      25
#define CHARACTER_CONSTANT        26
#define STRING_LITERAL            27
#define PUNCTUATOR                28
#define SINGLE_LINE_COMMENT_START 29
#define SINGLE_LINE_COMMENT_END   30
#define MULTI_LINE_COMMENT_START  31
#define MULTI_LINE_COMMENT_END    32
#define INVALID_TOKEN             33

extern int yylex();
extern char* yytext;

int main() {
    int token;
    while(token = yylex()) {
        switch(token) {
            case KEYWORD: 
                printf("<KEYWORD, %d, %s>\n", token, yytext); 
                break;
            case IDENTIFIER: 
                printf("<IDENTIFIER, %d, %s>\n", token, yytext); 
                break;
            case INTEGER_CONSTANT: 
                printf("<INTEGER_CONSTANT, %d, %s>\n", token, yytext); 
                break;
            case FLOATING_CONSTANT: 
                printf("<FLOAT_CONSTANT, %d, %s>\n", token, yytext); 
                break;
            case CHARACTER_CONSTANT: 
                printf("<CHARACTER_CONSTANT, %d, %s>\n", token, yytext); 
                break;
            case STRING_LITERAL: 
                printf("<STRING_LITERAL, %d, %s>\n", token, yytext); 
                break;
            case PUNCTUATOR: 
                printf("<PUNCTUATOR, %d, %s>\n", token, yytext); 
                break;
            case SINGLE_LINE_COMMENT_START: 
                printf("<SINGLE_LINE_COMMENT_START, %d, %s>\n", token, yytext);
                break;

            case SINGLE_LINE_COMMENT_END: 
                printf("<SINGLE_LINE_COMMENT_END, %d, %s>\n", token, "\"\\n\"");
                break;

            case MULTI_LINE_COMMENT_START: 
                printf("<MULTI_LINE_COMMENT_START, %d, %s>\n", token, yytext);
                break;

            case MULTI_LINE_COMMENT_END: 
                printf("<MULTI_LINE_COMMENT_END, %d, %s>\n", token, yytext);
                break;

            default:
                printf("<INVALID_TOKEN, %d, %s>\n", token, yytext);
                break;
        }
    }
    return 0;
}
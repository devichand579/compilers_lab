%{
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
%}

%x SINGLE_LINE_COMMENT
%x MULTI_LINE_COMMENT

KEYWORD                "auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"inline"|"int"|"long"|"register"|"restrict"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while"|"_Bool"|"_Complex"|"_Imaginary"
ESCAPE_SEQUENCE         "\\\'"|"\\\""|"\\?"|"\\\\"|"\\a"|"\\b"|"\\f"|"\\n"|"\\r"|"\\t"|"\\v"
PUNCTUATOR             "["|"]"|"("|")"|"{"|"}"|"."|"->"|"++"|"--"|"&"|"*"|"+"|"-"|"~"|"!"|"/"|"%"|"<<"|">>"|"<"|">"|"<="|">="|"=="|"!="|"^"|"|"|"&&"|"||"|"?"|":"|";"|"..."|"="|"*="|"/="|"%="|"+="|"-="|"<<="|">>="|"&="|"^="|"|="|","|"#"
IDENTIFIER             [A-Za-z_][A-Za-z0-9_]*

DIGIT                  [0-9] 
NONZERO_DIGIT          [1-9]
DIGIT_SEQUENCE         {DIGIT}+
INTEGER_CONSTANT       {NONZERO_DIGIT}{DIGIT}*

EXPONENT_PART          [eE]([+-]?){DIGIT_SEQUENCE}
FRACTIONAL_CONSTANT    ({DIGIT_SEQUENCE}?\.{DIGIT_SEQUENCE})|({DIGIT_SEQUENCE}\.)
FLOATING_CONSTANT      ({FRACTIONAL_CONSTANT}{EXPONENT_PART}?)|({DIGIT_SEQUENCE}{EXPONENT_PART})
ENUMERATION_CONSTANT   {IDENTIFIER}

C_CHAR                 [^\'\\\n]|{ESCAPE_SEQUENCE}
C_CHAR_SEQUENCE        {C_CHAR}+
CHAR_CONSTANT          \'({C_CHAR_SEQUENCE})\'
CONSTANT               {INTEGER_CONSTANT}|{FLOATING_CONSTANT}|{ENUM_CONSTANT}|{CHAR_CONSTANT}

S_CHAR                 [^\"\\\n]|{ESCAPE_SEQUENCE}
S_CHAR_SEQUENCE        {S_CHAR}+
STRING_LITERAL         \"({S_CHAR_SEQUENCE}?)\"

BLANK_SPACE            [ \t\n]



%%

{KEYWORD}              {return KEYWORD;   }
{IDENTIFIER}           {return IDENTIFIER; }
{INTEGER_CONSTANT}     {return INTEGER_CONSTANT; }
{FLOATING_CONSTANT}    { return FLOATING_CONSTANT; }
{CHAR_CONSTANT}        { return CHARACTER_CONSTANT; }
{STRING_LITERAL}       { return STRING_LITERAL; }
{PUNCTUATOR}           { return PUNCTUATOR; }
{BLANK_SPACE}            ;


"//"                            { BEGIN(SINGLE_LINE_COMMENT); return SINGLE_LINE_COMMENT_START; }
<SINGLE_LINE_COMMENT>.          {}
<SINGLE_LINE_COMMENT>\n         { BEGIN(INITIAL); return SINGLE_LINE_COMMENT_END; }
<SINGLE_LINE_COMMENT><<EOF>>    { BEGIN(INITIAL); return SINGLE_LINE_COMMENT_END; }

"/*"                            { BEGIN(MULTI_LINE_COMMENT); return MULTI_LINE_COMMENT_START; }
<MULTI_LINE_COMMENT>"*/"        { BEGIN(INITIAL); return MULTI_LINE_COMMENT_END; }
<MULTI_LINE_COMMENT>.           {}
<MULTI_LINE_COMMENT>\n          {}

.                               { return INVALID_TOKEN; }

%%
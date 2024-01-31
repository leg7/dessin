%skeleton "lalr1.cc"
%require "3.0"

%defines
%define api.parser.class { Parser }
%define api.value.type variant
%define parse.assert

%locations

%code requires{
    #include "contexte.hh"
    #include "expressionBinaire.hh"
    #include "expressionUnaire.hh"
    #include "constante.hh"
    #include "variable.hh"

    class Scanner;
    class Driver;
}

%parse-param { Scanner &scanner }
%parse-param { Driver &driver }

%code{
    #include <iostream>
    #include <string>

    #include "scanner.hh"
    #include "driver.hh"

    #undef  yylex
    #define yylex scanner.yylex
}

%token NL
%token END
%token <int> NUMBER
%token CARRE;
%token RECTANGLE;
%token TRIANGLE;
%token CERCLE;
%token ELLIPSE;
%token LIGNE;
%token CHEMIN;
%token TEXTE;
%token STRING;

%type <int>             operation
%left '-' '+'
%left '*' '/'
%precedence  NEG

%%

programme:
    instruction NL programme
    | END NL {
        YYACCEPT;
    }

instruction:
    expression
    | affectation

expression:
    declaration
    | operation {
        //Modifier cette partie pour prendre en compte la structure avec expressions
        std::cout << "#-> " << $1 << std::endl;
    }

// TODO: Pour chaque forme creer l'objet et l'ajouter dans sa liste correspondante
declaration:
        CARRE NUMBER NUMBER NUMBER
        | RECTANGLE NUMBER NUMBER NUMBER NUMBER NUMBER NUMBER NUMBER NUMBER
        | TRIANGLE NUMBER NUMBER NUMBER NUMBER
        | CERCLE NUMBER NUMBER NUMBER
        | ELLIPSE NUMBER NUMBER NUMBER NUMBER
        | LIGNE NUMBER NUMBER NUMBER NUMBER
        | CHEMIN chemin_rec
        | TEXTE NUMBER NUMBER STRING STRING

chemin_rec:
          NUMBER NUMBER ',' chemin_rec
          | NUMBER NUMBER


affectation:
    '=' { std::cout << "Affectation à réaliser" << std::endl;
    }

operation:
    NUMBER {
        $$ = $1;
    }
    | '(' operation ')' {
        $$ = $2;
    }
    | operation '+' operation {
        $$ = $1 + $3;
    }
    | operation '-' operation {
        $$ = $1 - $3;
    }
    | operation '*' operation {
        $$ = $1 * $3;
    }
    | operation '/' operation {
        $$ = $1 / $3;
    }
    | '-' operation %prec NEG {
        $$ = - $2;
    }

%%

void yy::Parser::error( const location_type &l, const std::string & err_msg) {
    std::cerr << "Erreur : " << l << ", " << err_msg << std::endl;
}

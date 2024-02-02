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
    #include "formes_inc.hh"

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
%token <const char*> STRING;

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
        CARRE NUMBER NUMBER NUMBER {
            driver.ajouterCarre($2, $3, $4);
        }
        | RECTANGLE NUMBER NUMBER NUMBER NUMBER NUMBER NUMBER NUMBER NUMBER {
            driver.ajouterRectangle($2, $3, $4, $5, $6, $7, $8, $9);
        }
        | TRIANGLE NUMBER NUMBER NUMBER NUMBER {
            driver.ajouterTriangle($2, $3, $4, $5);
        }
        | CERCLE NUMBER NUMBER NUMBER {
            driver.ajouterCercle($2, $3, $4);
        }
        | ELLIPSE NUMBER NUMBER NUMBER NUMBER {
            driver.ajouterEllipse($2, $3, $4, $5);
        }
        | LIGNE NUMBER NUMBER NUMBER NUMBER {
            driver.ajouterLigne($2, $3, $4, $5);
        }
        | CHEMIN NUMBER NUMBER ',' chemin_rec {
            driver.ajouterChemin($2, $3);
        }
        | TEXTE NUMBER NUMBER STRING STRING {
            driver.ajouterTexte($2, $3, $4, $5);
        }

chemin_rec:
        NUMBER NUMBER ',' chemin_rec {
            driver.cheminContinuer($1, $2);
        }
        | /* epsilon */ {
        }

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

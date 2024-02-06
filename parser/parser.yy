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
	#include "../couleur.hh"
	#include <cstdint>


	union Hextract
	{
		uint32_t full;
		struct {
			uint8_t b;
			uint8_t g;
			uint8_t r;
			uint8_t _;
		} parts;
	};

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

	#undef	yylex
	#define yylex scanner.yylex

}

%token NL
%token END
%token <int> NUMBER
%token FLECHE

%token COULEUR
%token COULEUR_RGB
%token <unsigned> COULEUR_HEX
%token <Couleur> COULEUR_NOM

%token ROTATION
%token REMPLISSAGE
%token OPACITE
%token EPAISSEUR

%token CARRE
%token RECTANGLE
%token TRIANGLE
%token CERCLE
%token ELLIPSE
%token LIGNE
%token CHEMIN
%token TEXTE
%token <const char*> STRING

%type <int> operation
%type <Forme::Proprietes> proprietes
%type <Forme::Proprietes> propriete
%type <Couleur> couleur
%type <Forme::Proprietes> declaration
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
	| declaration proprietes {
		$1 = $2;
	}
	| operation {
		//Modifier cette partie pour prendre en compte la structure avec expressions
		std::cout << "#-> " << $1 << std::endl;
	}

declaration:
	CARRE NUMBER NUMBER NUMBER {
		driver.ajouterCarre($$, $2, $3, $4);
	}
	| RECTANGLE NUMBER NUMBER NUMBER NUMBER NUMBER NUMBER NUMBER NUMBER {
		driver.ajouterRectangle($$, $2, $3, $4, $5, $6, $7, $8, $9);
	}
	| TRIANGLE NUMBER NUMBER NUMBER NUMBER {
		driver.ajouterTriangle($$, $2, $3, $4, $5);
	}
	| CERCLE NUMBER NUMBER NUMBER {
		driver.ajouterCercle($$, $2, $3, $4);
	}
	| ELLIPSE NUMBER NUMBER NUMBER NUMBER {
		driver.ajouterEllipse($$, $2, $3, $4, $5);
	}
	| LIGNE NUMBER NUMBER NUMBER NUMBER {
		driver.ajouterLigne($$, $2, $3, $4, $5);
	}
	| CHEMIN chemin_rec NUMBER NUMBER {
		driver.ajouterChemin($$, $3, $4);
	}
	| TEXTE NUMBER NUMBER STRING STRING {
		driver.ajouterTexte($$, $2, $3, $4, $5);
	}

chemin_rec:
	chemin_rec NUMBER NUMBER ','  {
		driver.cheminContinuer($2, $3);
	}
	| /* epsilon */ {
	}

proprietes:
	FLECHE propriete propriete_esp {
		$$ = $2; // idem
	}
	| '{' propriete propriete_nl '}' {
		$$ = $2; // TODO: Il faudra changer cette ligne pour que le prop inclu propriete_nl
	}

propriete:
	COULEUR ':' couleur {
		$$.couleur = $3;
	}
	| ROTATION ':' NUMBER {
		$$.rotation = $3 % 360;
	}
	| REMPLISSAGE ':' couleur {
		$$.remplissage = $3;
	}
	| OPACITE ':' NUMBER '%' {
		$$.opacite = $3;
	}
	| EPAISSEUR ':' NUMBER {
		$$.epaisseur = $3;
	}

couleur:
	COULEUR_NOM {
		$$ = Couleur($1);
	}
	| COULEUR_RGB NUMBER ',' NUMBER ',' NUMBER ')' {
		$$ = Couleur($2, $4, $6);
	}
	| COULEUR_HEX {
		Hextract h { $1 };
		$$ = Couleur(h.parts.r, h.parts.g, h.parts.b);
	}

propriete_esp:
	'&' propriete propriete_esp
	| ';'

propriete_nl:
	NL propriete propriete_nl
	| /* epsilon */

affectation:
    IDENTIFIANT '=' expression {

        std::cout << "Affectation à réaliser" << std::endl;
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

%skeleton "lalr1.cc"
%require "3.0"

%defines
%define api.parser.class { Parser }
%define api.value.type variant
%define parse.assert

%locations

%code requires {
	#include "Driver.h"
	#include "../instructions/Instructions.h"
	#include "../elements/formes/Formes.h"
	#include <iostream>

	class Scanner;
	class Driver;
}

%parse-param { Scanner &scanner }
%parse-param { Driver &driver }

%code{
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
%type <Declaration> declaration
%type <Declaration> declarationSimple
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
	 affectation
	| appelFonction
	| boucle
	| branchement
	| declaration

declaration:
	declarationSimple {
		$$ = $1;
	}
	| declarationSimple proprietes {
	}

// TODO: Construire forme puis l'ajouter au contexte de l'AST
declarationSimple:
	CARRE NUMBER NUMBER NUMBER {
		$$ = new Declaration(driver.contexteCourant, new Carre($2, $3, $4));
	}
	| RECTANGLE NUMBER NUMBER NUMBER NUMBER NUMBER NUMBER NUMBER NUMBER {
		$$ = new Declaration(driver.contexteCourant, new Rectangle($2, $3, $4, $5, $6, $7, $8, $9));
	}
	| TRIANGLE NUMBER NUMBER NUMBER NUMBER {
		$$ = new Declaration(driver.contexteCourant, new Triangle($2, $3, $4, $5));
	}
	| CERCLE NUMBER NUMBER NUMBER {
		$$ = new Declaration(driver.contexteCourant, new Cercle($2, $3, $4));
	}
	| ELLIPSE NUMBER NUMBER NUMBER NUMBER {
		$$ = new Declaration(driver.contexteCourant, new Ellipse($2, $3, $4, $5));
	}
	| LIGNE NUMBER NUMBER NUMBER NUMBER {
		$$ = new Declaration(driver.contexteCourant, new Ligne($2, $3, $4, $5));
	}
	| CHEMIN chemin_rec NUMBER NUMBER {
		$$ = new Declaration(driver.contexteCourant, new Chemin($3, $4));
	}
	| TEXTE NUMBER NUMBER STRING STRING {
		$$ = new Declaration(driver.contexteCourant, new Texte($2, $3, $4, $5));
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
    /*IDENTIFIANT '=' expression {

        std::cout << "Affectation à réaliser" << std::endl;
    }*/

appelFonction:

boucle:

branchement:


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

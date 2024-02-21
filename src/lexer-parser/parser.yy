%skeleton "lalr1.cc"
%require "3.2"

%defines
%define api.parser.class { Parser }
%define api.value.type variant
%define parse.assert
%language "c++"

%locations

%code requires {
	#include <memory>
	#include <iostream>
	#include <cmath>

	#include "../instructions/Instruction.h"
	#include "../instructions/Affectation.h"
	#include "../instructions/AppelFonction.h"
	#include "../instructions/Boucle.h"
	#include "../instructions/Branchement.h"
	#include "../instructions/Declaration.h"

	#include "../elements/Couleur.h"
	#include "../elements/formes/Forme.h"
	#include "../elements/formes/Carre.h"
	#include "../elements/formes/Cercle.h"
	#include "../elements/formes/Chemin.h"
	#include "../elements/formes/Ellipse.h"
	#include "../elements/formes/Ligne.h"
	#include "../elements/formes/Rectangle.h"
	#include "../elements/formes/Texte.h"
	#include "../elements/formes/Triangle.h"

	class Scanner;
	class Driver;
}

%parse-param { Scanner &scanner }
%parse-param { Driver &driver }

%code{
	#include "Driver.h"
	#include "scanner.hh"

	#undef	yylex
	#define yylex scanner.yylex

}

%token NL
%token END
%token <int> ENTIER
%token <float> REEL
%token FLECHE

%token <Couleur> COULEUR

%token <int> NUMBER
%token IDENTIFIANT

%token KW_COULEUR
%token KW_ROTATION
%token KW_REMPLISSAGE
%token KW_OPACITE
%token KW_EPAISSEUR
%token KW_TANTQUE
%token KW_SI

%token CARRE
%token RECTANGLE
%token TRIANGLE
%token CERCLE
%token ELLIPSE
%token LIGNE
%token CHEMIN
%token TEXTE
%token <const char*> STRING

%type <std::unique_ptr<Declaration>> declaration
%type <std::unique_ptr<Forme>> forme
// Forme::Proprietes Sythetise
%type <std::unique_ptr<Forme::Proprietes>> proplist_esp
%type <std::unique_ptr<Forme::Proprietes>> proplist_nl
%type <std::unique_ptr<Forme::Proprietes>> propriete

%type <std::unique_ptr<AppelFonction>> appelFonction
%type <std::vector<std::shared_ptr<Instruction>>> arglist

%type <std::unique_ptr<Boucle>> boucle
%type <std::unique_ptr<Expression>> expression
%type <std::unique_ptr<Expression>> comparaison
%type <std::unique_ptr<Instruction>> instruction
%type <std::unique_ptr<Branchement>> branchement
%type <std::vector<std::shared_ptr<Instruction>>> corps
%type <int> operation
%type <std::unique_ptr<Chemin>> chemin_points
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
/*
	 affectation {
		driver.ast.add($$);
	}
	| appelFonction {
		driver.ast.add($$);
	}
	| boucle {
		driver.ast.add($$);
	}
	| branchement {
		driver.ast.add($$);
	}
*/
	declaration {
		driver.ast.add(std::move($$));
	}

declaration:
	forme {
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::move($1));
	}
	| forme FLECHE proplist_esp ';' {
		$1->setProprietes(*$3);
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::move($1));
	}
	| forme '{' proplist_nl '}' {
		$1->setProprietes(*$3);
		$$ = std::make_unique<Declaration>(driver.contexteCourant, std::move($1));
	}

forme:
	CARRE NUMBER NUMBER NUMBER {
		$$ = std::make_unique<Carre>($2, $3, $4);
	}
	| RECTANGLE NUMBER NUMBER NUMBER NUMBER NUMBER NUMBER NUMBER NUMBER {
		$$ = std::make_unique<Rectangle>($2, $3, $4, $5, $6, $7, $8, $9);
	}
	| TRIANGLE NUMBER NUMBER NUMBER NUMBER {
		$$ = std::make_unique<Triangle>($2, $3, $4, $5);
	}
	| CERCLE NUMBER NUMBER NUMBER {
		$$ = std::make_unique<Cercle>($2, $3, $4);
	}
	| ELLIPSE NUMBER NUMBER NUMBER NUMBER {
		$$ = std::make_unique<Ellipse>($2, $3, $4, $5);
	}
	| LIGNE NUMBER NUMBER NUMBER NUMBER {
		$$ = std::make_unique<Ligne>($2, $3, $4, $5);
	}
	| CHEMIN chemin_points {
		$$ = std::move($2);
	}
	| TEXTE NUMBER NUMBER STRING STRING {
		$$ = std::make_unique<Texte>($2, $3, $4, $5);
	}

chemin_points:
	chemin_points ',' NUMBER NUMBER  {
		$$ = std::move($1);
		$$->ajoutePoint($3, $4);
	}
	| NUMBER NUMBER {
		$$ = std::make_unique<Chemin>($1, $2);
	}

proplist_esp:
	propriete {
		$1 = std::move($$);
	}
	| propriete '&' proplist_esp {
		$1 = std::move($$);
	}

proplist_nl:
	propriete {
		$1 = std::move($$);
	}
	| propriete NL proplist_nl {
		$1 = std::move($$);
	}

propriete:
	KW_COULEUR ':' COULEUR {
		$$->couleur = $3;
	}
	| KW_ROTATION ':' REEL {
		$$->rotation = fmod($3, 360.0f);
	}
	| KW_REMPLISSAGE ':' COULEUR {
		$$->remplissage = $3;
	}
	| KW_OPACITE ':' REEL '%' {
		$$->opacite = $3 * .01f;
	}
	| KW_EPAISSEUR ':' REEL {
		$$->epaisseur = $3;
	}

affectation:
    /*IDENTIFIANT '=' expression {

        std::cout << "Affectation à réaliser" << std::endl;
    }*/

appelFonction:
/*
	IDENTIFIANT '(' ')' {
		$$ = std::make_unique<AppelFonction>(driver.contexteCourant);
	}
	IDENTIFIANT '(' arglist ')' {
		$$ = std::make_unique<AppelFonction>(driver.contexteCourant, $3);
	}
*/

arglist:
	expression {
		$$ = std::vector<std::shared_ptr<Expression>>(1, std::move($1));
	}
	| arglist ',' expression {
		$$ = std::move($1);
		$$.push_back(std::move($3));
	}

boucle:
	KW_TANTQUE '(' comparaison ')' corps {
		$$ = std::make_unique<Boucle>(driver.contexteCourant, std::move($3), $5);
	}

branchement:
	KW_SI '(' comparaison ')' corps {
		$$ = std::make_unique<Branchement>(driver.contexteCourant, std::move($3), $5);
	}

expression:
corps:
comparaison:

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
